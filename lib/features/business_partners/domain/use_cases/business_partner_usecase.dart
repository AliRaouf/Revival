import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/business_partners/data/models/business_partner/business_partner.dart';
import 'package:revival/features/business_partners/domain/repo/get_business_partner_repo.dart';

class BusinessPartnerUsecase {
  final GetBusinessPartnerRepo getBusinessPartnerRepo;
  BusinessPartnerUsecase(this.getBusinessPartnerRepo);
  Future<Either<Failures, BusinessPartner>> getBusinessPartners()async {
    final result = await getBusinessPartnerRepo.getBusinessPartner();
    return result.fold(
      (failure) => left(failure),
      (businessPartner) => right(businessPartner),
    );
  }
}