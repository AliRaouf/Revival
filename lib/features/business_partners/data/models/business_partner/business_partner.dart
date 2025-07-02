import 'package:equatable/equatable.dart';

import 'datum.dart';

class BusinessPartner extends Equatable {
  final bool? success;
  final int? statusCode;
  final String? message;
  final List<Datum>? data;
  final int? timestamp;

  const BusinessPartner({
    this.success,
    this.statusCode,
    this.message,
    this.data,
    this.timestamp,
  });

  factory BusinessPartner.fromJson(Map<String, dynamic> json) {
    return BusinessPartner(
      success: json['success'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
              .toList(),
      timestamp: json['timestamp'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'statusCode': statusCode,
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
    'timestamp': timestamp,
  };

  @override
  List<Object?> get props {
    return [success, statusCode, message, data, timestamp];
  }
}
