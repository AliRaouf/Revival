import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/business_partners/data/models/business_partner/business_partner.dart';

abstract class GetBusinessPartnerRepo {
  Future<Either<Failures, BusinessPartner>> getBusinessPartner();
}