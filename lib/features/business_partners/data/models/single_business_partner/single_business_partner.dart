import 'package:equatable/equatable.dart';

import 'data.dart';

class SingleBusinessPartner extends Equatable {
  final bool? success;
  final int? statusCode;
  final String? message;
  final Data? data;
  final int? timestamp;

  const SingleBusinessPartner({
    this.success,
    this.statusCode,
    this.message,
    this.data,
    this.timestamp,
  });

  factory SingleBusinessPartner.fromJson(Map<String, dynamic> json) {
    return SingleBusinessPartner(
      success: json['success'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data:
          json['data'] == null
              ? null
              : Data.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data?.toJson(),
    'timestamp': timestamp,
  };

  @override
  List<Object?> get props {
    return [success, statusCode, message, data, timestamp];
  }
}
