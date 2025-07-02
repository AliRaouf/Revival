import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

abstract class Failures {
  final String errMessage;
  Failures(this.errMessage);
}

class ServerFailure extends Failures {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        // You could use .tr() here for localization
        return ServerFailure(
          'The connection timed out. Please check your internet and try again.',
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          'A secure connection could not be established. Please try again later.',
        );

      case DioExceptionType.cancel:
        return ServerFailure('The request was cancelled. Please try again.');

      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          return ServerFailure(
            "We’re having trouble reaching our servers. Please check your network and try again.",
          );
        }
        return ServerFailure(
          'An unknown network error occurred. Please try again.',
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(dioError.response);

      default:
        return ServerFailure('Something went wrong. Please try again.');
    }
  }

  factory ServerFailure.fromBadResponse(Response? response) {
    int? statusCode = response?.statusCode;
    dynamic data = response?.data;
    String defaultMessage =
        'Something went wrong on our end. Please try again in a few moments.';

    String messageToDisplay = defaultMessage;

    // Prefer a server-provided message if it exists and is a simple string.
    if (data is Map<String, dynamic> && data['message'] is String) {
      messageToDisplay = data['message'];
    }
    // Handle cases where data might be a direct string error from the server
    else if (data is String && data.isNotEmpty) {
      messageToDisplay = data;
    }

    // Otherwise, use the status code for a more specific client-side message.
    switch (statusCode) {
      case 400:
        messageToDisplay =
            'There was a problem with your request. Please check your input.';
        break;
      case 401:
        messageToDisplay = 'Incorrect Username or password. Please try again.';
        break;
      case 403:
        messageToDisplay = "You don't have permission to do that.";
        break;
      case 404:
        messageToDisplay = "We couldn't find what you were looking for.";
        break;
      case 500:
      case 502:
      case 503:
        messageToDisplay =
            'Our systems are experiencing issues. Please try again later.';
        break;
      default:
        // defaultMessage is already set, no change needed unless specific logic for other codes
        break;
    }

    // Append status code if available
    if (statusCode != null) {
      return ServerFailure(
        messageToDisplay,
      ); //add this into the message to display status code: (Status Code: $statusCode)
    } else {
      return ServerFailure("$messageToDisplay (Status Code: $statusCode)");
    }
  }
}
