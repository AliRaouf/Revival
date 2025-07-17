import 'package:equatable/equatable.dart';

class Value extends Equatable {
  final int? docEntry;
  final int? docNum;
  final String? docType;
  final String? docStatus;
  final String? docDate;
  final String? docDueDate;
  final String? cardCode;
  final String? slpCode;
  final double? docTotal;
  final double? discPrcnt;
  final double? discSum;
  final double? vatPercent;
  final double? vatSum;
  final String? canceled;
  final String? cardName;

  const Value({
    this.docEntry,
    this.docNum,
    this.docType,
    this.docStatus,
    this.docDate,
    this.docDueDate,
    this.cardCode,
    this.slpCode,
    this.docTotal,
    this.discPrcnt,
    this.discSum,
    this.vatPercent,
    this.vatSum,
    this.canceled,
    this.cardName,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    docEntry: json['DocEntry'] as int?,
    docNum: json['DocNum'] as int?,
    docType: json['DocType'] as String?,
    docStatus: json['DocStatus'] as String?,
    docDate: json['DocDate'] as String?,
    docDueDate: json['DocDueDate'] as String?,
    cardCode: json['CardCode'] as String?,
    slpCode: json['SlpCode'] as String?,
    docTotal: (json['DocTotal'] as num?)?.toDouble(),
    discPrcnt: json['DiscPrcnt'] as double?,
    discSum: json['DiscSum'] as double?,
    vatPercent: json['VatPercent'] as double?,
    vatSum: (json['VatSum'] as num?)?.toDouble(),
    canceled: json['CANCELED'] as String?,
    cardName: json['CardName'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'DocEntry': docEntry,
    'DocNum': docNum,
    'DocType': docType,
    'DocStatus': docStatus,
    'DocDate': docDate,
    'DocDueDate': docDueDate,
    'CardCode': cardCode,
    'SlpCode': slpCode,
    'DocTotal': docTotal,
    'DiscPrcnt': discPrcnt,
    'DiscSum': discSum,
    'VatPercent': vatPercent,
    'VatSum': vatSum,
    'CANCELED': canceled,
    'CardName': cardName,
  };

  @override
  List<Object?> get props {
    return [
      docEntry,
      docNum,
      docType,
      docStatus,
      docDate,
      docDueDate,
      cardCode,
      slpCode,
      docTotal,
      discPrcnt,
      discSum,
      vatPercent,
      vatSum,
      canceled,
      cardName,
    ];
  }
}
