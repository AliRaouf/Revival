import 'package:equatable/equatable.dart';

import 'order_line.dart';

class Data extends Equatable {
  final int? docEntry;
  final int? docNum;
  final String? canceled;
  final String? docDate;
  final String? docDueDate;
  final double? vatSum;
  final int? vatPercent;
  final String? cardCode;
  final String? phone1;
  final String? cardName;
  final String? slpCode;
  final String? salesEmployeeName;
  final String? salesEmployeeMobile;
  final List<OrderLine>? orderLines;

  const Data({
    this.docEntry,
    this.docNum,
    this.canceled,
    this.docDate,
    this.docDueDate,
    this.vatSum,
    this.vatPercent,
    this.cardCode,
    this.phone1,
    this.cardName,
    this.slpCode,
    this.salesEmployeeName,
    this.salesEmployeeMobile,
    this.orderLines,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    docEntry: json['docEntry'] as int?,
    docNum: json['docNum'] as int?,
    canceled: json['canceled'] as String?,
    docDate: json['docDate'] as String?,
    docDueDate: json['docDueDate'] as String?,
    vatSum: (json['vatSum'] as num?)?.toDouble(),
    vatPercent: (json['vatPercent'] as num?)?.toInt(),
    cardCode: json['cardCode'] as String?,
    phone1: json['phone1'] as String?,
    cardName: json['cardName'] as String?,
    slpCode: json['slpCode'] as String?,
    salesEmployeeName: json['salesEmployeeName'] as String?,
    salesEmployeeMobile: json['salesEmployeeMobile'] as String?,
    orderLines:
        (json['orderLines'] as List<dynamic>?)
            ?.map((e) => OrderLine.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'docEntry': docEntry,
    'docNum': docNum,
    'canceled': canceled,
    'docDate': docDate,
    'docDueDate': docDueDate,
    'vatSum': vatSum,
    'vatPercent': vatPercent,
    'cardCode': cardCode,
    'phone1': phone1,
    'cardName': cardName,
    'slpCode': slpCode,
    'salesEmployeeName': salesEmployeeName,
    'salesEmployeeMobile': salesEmployeeMobile,
    'orderLines': orderLines?.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props {
    return [
      docEntry,
      docNum,
      canceled,
      docDate,
      docDueDate,
      vatSum,
      vatPercent,
      cardCode,
      phone1,
      cardName,
      slpCode,
      salesEmployeeName,
      salesEmployeeMobile,
      orderLines,
    ];
  }
}
