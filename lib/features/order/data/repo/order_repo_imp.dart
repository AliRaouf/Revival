
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/core/services/api_service.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/order/data/models/all_orders/all_orders.dart';
import 'package:revival/features/order/data/models/copy_to_invoice/copy_to_invoice.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';
import 'package:dio/dio.dart';

class OrderRepoImp implements OrderRepo {
  final ApiService apiService;
  OrderRepoImp(this.apiService);

  // Helper to robustly extract any error message from the nested error JSON or SAP error string
  String? extractAnyErrorMessage(Map<String, dynamic> errorJson) {
    log('extractAnyErrorMessage called with:');
    log('JSON ERROR: $errorJson');
    String? errorMessage =
        errorJson['data']?['errorMessage'] ?? errorJson['message'];
    log('Extracted errorMessage: $errorMessage');
    if (errorMessage == null) return null;

    // Try to find a JSON object in the string
    final jsonRegex = RegExp(r'\{.*\}', dotAll: true);
    final match = jsonRegex.firstMatch(errorMessage.replaceAll('\n', ' '));
    log('JSON regex match: ${match?.group(0)}');
    if (match != null) {
      String jsonString = match.group(0)!;
      // Clean up escape sequences
      jsonString = jsonString
          .replaceAll(r'\n', '')
          .replaceAll('<EOL>', '')
          .replaceAll(r'\"', '"');
      log('Cleaned JSON string: $jsonString');
      // try {
      //   final jsonMap = json.decode(jsonString);
      //   log('Parsed JSON map: $jsonMap');
      //   if (jsonMap is Map && jsonMap.containsKey('error')) {
      //     final error = jsonMap['error'];
      //     if (error is Map && error.containsKey('message')) {
      //       log('Extracted message from JSON: ${error['message']}');
      //       return error['message'];
      //     }
      //   }
      // } catch (e) {
      //   log('Error parsing SAP error message: $e');
      //   // If parsing fails, just continue to fallback
      // }
    }

    // Try to extract a message like: "message" : "..."
    final regex = RegExp(r'"message"\s*:\s*"([^"]+)"');
    final messageMatch = regex.firstMatch(errorMessage);
    log('Message regex match: ${messageMatch?.group(1)}');
    if (messageMatch != null) {
      return messageMatch.group(1); // The actual message
    }

    // Fallback: try to find any readable error message
    final fallback = RegExp(r'Invalid BP code[^"\\]*');
    final fallbackMatch = fallback.firstMatch(errorMessage);
    log('Invalid BP code fallback match: ${fallbackMatch?.group(0)}');
    if (fallbackMatch != null) {
      return fallbackMatch.group(0);
    }

    // Fallback: try to find any readable error message
    final genericFallback = RegExp(r'[A-Z][^"\n]+');
    final genericFallbackMatch = genericFallback.firstMatch(errorMessage);
    log('Generic fallback match: ${genericFallbackMatch?.group(0)}');
    if (genericFallbackMatch != null) {
      return genericFallbackMatch.group(0);
    }

    log('No error message extracted.');
    return null;
  }

  @override
  Future<Either<Failures, AllOrders>> getOpenOrders(
    Map<String, dynamic>? query,
  ) async {
    try {
      final data = await apiService.get(
        '/sync/my-open-orders',
        queryParameters: query,
      );
      return right(AllOrders.fromJson(data));
    } catch (e) {
      // Check for the specific failure types first
      if (e is ServerFailure) {
        return left(e);
      }
      if (e is ApiException) {
        return left(ServerFailure(e.message));
      }
      // Keep a fallback for any other truly unexpected errors
      return left(
        ServerFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  // In your repository/data source file
  Future<Either<Failures, SingleOrder>> getOrderDetails(String docEntry) async {
    final dbid = getIt<OrderQuery>().getQuery?['companyDbId'] ?? '';
    var responseData;
    try {
      final data = await apiService.get(
        '/sync/$docEntry',
        queryParameters: {"companyDbId": dbid},
      );
      responseData = data; // Store the data before parsing
      // log(data.toString());
      return right(SingleOrder.fromJson(data));
    } catch (e) {
      // Check for the specific failure types first
      if (e is ServerFailure) {
        return left(e);
      }
      if (e is ApiException) {
        return left(ServerFailure(e.message));
      }
      // Keep a fallback for any other truly unexpected errors
      return left(
        ServerFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> copyOrderToInvoice(
    String docEntry,
    CopyToInvoice copyToInvoiceData,
  ) async {
    final dbid = getIt<OrderQuery>().getQuery?['companyDbId'] ?? '';
    try {
      final data = await apiService.post(
        '/api/invoices/from-order/$docEntry?companyDbId=$dbid',
        data: copyToInvoiceData.toJson(),
      );
      // Check for error in the response payload
      if ((data['status'] == 'FAILED') || (data['errorMessage'] != null)) {
        final anyError = extractAnyErrorMessage(data);
        if (anyError != null) {
          return left({'error': anyError});
        }
        return left(data);
      }
      return right(data);
    } on DioException catch (e) {
      // Try to extract the backend error payload if available
      if (e.response?.data != null) {
        final anyError = extractAnyErrorMessage(e.response!.data);
        if (anyError != null) {
          return left({'error': anyError});
        }
        return left(e.response!.data);
      }
      return left({'type': 'ServerFailure', 'message': e.message});
    } catch (e) {
      // If the error is a Map (backend JSON), return it directly
      if (e is Map<String, dynamic>) {
        final anyError = extractAnyErrorMessage(e);
        if (anyError != null) {
          print({'error': anyError});
          return left({'error': anyError});
        }
        print(e);
        return left(e);
      }
      if (e is ServerFailure) {
        return left({'type': 'ServerFailure', 'message': e.errMessage});
      }
      if (e is ApiException) {
        return left({'type': 'ApiException', 'message': e.message});
      }
      return left({'type': 'UnknownFailure', 'message': e.toString()});
    }
  }
}
