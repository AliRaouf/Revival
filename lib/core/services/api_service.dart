import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:flutter/foundation.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() {
    return 'ApiException: $message (Status Code: $statusCode)';
  }
}

class ApiService {
  final Dio dio;
  ApiService(this.dio);

  /// Generic GET request method
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
        _handleDioException(e);
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
        _handleDioException(e);
      } catch (e) {
        throw ApiException('An unexpected error occurred: $e');
      }
    } else {
      throw ApiException(
        'No internet connection. Please check your network settings.',
      );
    }
  }

  Never _handleDioException(DioException e) {
    if (e.response != null) {
      debugPrint('Status Code: ${e.response?.statusCode}');
      switch (e.response?.statusCode) {
        case 400:
          throw ApiException('Bad Request.', e.response?.statusCode);
        case 401:
          throw ApiException(
            'Unauthorized. Please log in again.',
            e.response?.statusCode,
          );
        case 403:
          throw ApiException(
            'Forbidden. You do not have permission.',
            e.response?.statusCode,
          );
        case 404:
          final errorMessage =
              e.response?.data['message'] ?? 'Resource not found.';
          throw ApiException(errorMessage, e.response?.statusCode);
        case 500:
          throw ApiException(
            'Internal Server Error. Please try again later.',
            e.response?.statusCode,
          );
        default:
          throw ApiException(
            'Oops, something went wrong.',
            e.response?.statusCode,
          );
      }
    } else {
      debugPrint('DioException without response: ${e.message}');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.error is SocketException) {
        throw ApiException(
          'Connection Error. Please check your internet connection.',
        );
      }
      throw ApiException('An unexpected error occurred: ${e.message}');
    }
  }
}
