import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/business_partners/data/models/business_partner/business_partner.dart';
import 'package:revival/features/business_partners/data/models/single_business_partner/single_business_partner.dart';
import 'package:revival/features/business_partners/domain/repo/get_business_partner_repo.dart';
import 'package:revival/features/business_partners/domain/repo/get_single_partner.dart';

class BusinessPartnerUsecase {
  final GetBusinessPartnerRepo getBusinessPartnerRepo;
  final GetSinglePartnerRepo singleBusinessPartner;
  BusinessPartnerUsecase(this.getBusinessPartnerRepo,this.singleBusinessPartner);
  Future<Either<Failures, BusinessPartner>> getBusinessPartners() async {
    final result = await getBusinessPartnerRepo.getBusinessPartner();
    return result.fold(
      (failure) => left(failure),
      (businessPartner) => right(businessPartner),
    );
  }
    Future<Either<Failures, SingleBusinessPartner>> getSinglePartner(String id) async {
    final result = await singleBusinessPartner.getSinglePartner(id);
    return result.fold(
      (failure) => left(failure),
      (singleBusinessPartner) => right(singleBusinessPartner),
    );
  }
}
