import 'package:easy_localization/easy_localization.dart';

class BusinessPartner {
  final String code;
  final String name;
  final double balance;
  final String location;
  final String? contactPerson;
  final String? phone;

  BusinessPartner({
    required this.code,
    required this.name,
    required this.balance,
    required this.location,
    this.contactPerson,
    this.phone,
  });

  String get partnerType {
    if (code.toUpperCase().startsWith('C')) {
      return 'Customer';
    } else if (code.toUpperCase().startsWith('V')) {
      return 'Vendor';
    }
    return 'Other';
  }
}