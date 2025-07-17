import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/business_partners/data/models/single_business_partner/single_business_partner.dart';

abstract class GetSinglePartnerRepo {
  Future<Either<Failures, SingleBusinessPartner>> getSinglePartner(String id);
}