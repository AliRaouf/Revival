import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final String? message;
  final String? token;
  final int? statusCode;
  final String? username;
  final String? companyDb;
  final int? clientId;
  final int? companyDbId;
  final String? salesEmployeeName;

  const Data({
    this.message,
    this.token,
    this.statusCode,
    this.username,
    this.companyDb,
    this.clientId,
    this.companyDbId,
    this.salesEmployeeName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    message: json['message'] as String?,
    token: json['token'] as String?,
    statusCode: json['statusCode'] as int?,
    username: json['username'] as String?,
    companyDb: json['companyDb'] as String?,
    clientId: json['clientId'] as int?,
    companyDbId: json['companyDbId'] as int?,
    salesEmployeeName: json['salesEmployeeName'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'message': message,
    'token': token,
    'statusCode': statusCode,
    'username': username,
    'companyDb': companyDb,
    'clientId': clientId,
    'companyDbId': companyDbId,
    'salesEmployeeName': salesEmployeeName,
  };

  @override
  List<Object?> get props {
    return [
      message,
      token,
      statusCode,
      username,
      companyDb,
      clientId,
      companyDbId,
      salesEmployeeName,
    ];
  }
}
