import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:revival/core/failures/failures.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() {
    return message;
  }
}

class ApiService {
  final Dio dio;
  ApiService(this.dio);

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    bool hasConnection = await InternetConnection().hasInternetAccess;
    if (hasConnection) {
      try {
        final response = await dio.get(
          endpoint,
          queryParameters: queryParameters,
        );
        return response.data;
      } on DioException catch (e) {
        throw ServerFailure.fromDioError(e);
      } catch (e) {
        throw ApiException('An unexpected error occurred: $e');
      }
    } else {
      throw ApiException(
        'No internet connection. Please check your network settings.',
      );
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? data}) async {
    bool hasConnection = await InternetConnection().hasInternetAccess;
    if (hasConnection) {
      try {
        final response = await dio.post(endpoint, data: data);
        return response.data;
      } on DioException catch (e) {
        // Special case: for copyToInvoice endpoint, throw the full backend JSON
        if (endpoint.contains('/api/invoices/from-order/') &&
            e.response?.data != null) {
          throw e.response!.data;
        }
        throw ServerFailure.fromDioError(e);
      } catch (e) {
        throw ApiException('An unexpected error occurred: $e');
      }
    } else {
      throw ApiException(
        'Connection Error. Please check your internet connection.'.tr(),
      );
    }
  }
}
