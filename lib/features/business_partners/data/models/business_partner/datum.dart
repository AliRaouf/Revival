import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? cardCode;
  final String? cardName;
  final String? cardType;
  final String? currency;
  final String? address;
  final String? phone1;
  final int? payTermsGrpCode;
  final int? priceListNum;
  final double? currentBalance;
  final String? groupName;
  final int? groupCode;
  final String? priceListName;
  final dynamic companyDbId;
  final dynamic companyDbName;

  const Datum({
    this.id,
    this.cardCode,
    this.cardName,
    this.cardType,
    this.currency,
    this.address,
    this.phone1,
    this.payTermsGrpCode,
    this.priceListNum,
    this.currentBalance,
    this.groupName,
    this.groupCode,
    this.priceListName,
    this.companyDbId,
    this.companyDbName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json['id'] as int?,
    cardCode: json['cardCode'] as String?,
    cardName: json['cardName'] as String?,
    cardType: json['cardType'] as String?,
    currency: json['currency'] as String?,
    address: json['address'] as String?,
    phone1: json['phone1'] as String?,
    payTermsGrpCode: json['payTermsGrpCode'] as int?,
    priceListNum: json['priceListNum'] as int?,
    currentBalance: (json['currentBalance'] as num?)?.toDouble(),
    groupName: json['groupName'] as String?,
    groupCode: json['groupCode'] as int?,
    priceListName: json['priceListName'] as String?,
    companyDbId: json['companyDbId'] as dynamic,
    companyDbName: json['companyDbName'] as dynamic,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'cardCode': cardCode,
    'cardName': cardName,
    'cardType': cardType,
    'currency': currency,
    'address': address,
    'phone1': phone1,
    'payTermsGrpCode': payTermsGrpCode,
    'priceListNum': priceListNum,
    'currentBalance': currentBalance,
    'groupName': groupName,
    'groupCode': groupCode,
    'priceListName': priceListName,
    'companyDbId': companyDbId,
    'companyDbName': companyDbName,
  };

  @override
  List<Object?> get props {
    return [
      id,
      cardCode,
      cardName,
      cardType,
      currency,
      address,
      phone1,
      payTermsGrpCode,
      priceListNum,
      currentBalance,
      groupName,
      groupCode,
      priceListName,
      companyDbId,
      companyDbName,
    ];
  }
}
