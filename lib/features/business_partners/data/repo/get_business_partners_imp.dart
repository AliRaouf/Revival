import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/core/services/api_service.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/features/business_partners/data/models/business_partner/business_partner.dart';
import 'package:revival/features/business_partners/domain/repo/get_business_partner_repo.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';

class GetBusinessPartnersImp implements GetBusinessPartnerRepo {
  final ApiService apiService;
  GetBusinessPartnersImp(this.apiService);
  @override
  Future<Either<Failures, BusinessPartner>> getBusinessPartner() async {
    final dbid = getIt<OrderQuery>().getQuery?['companyDbId'] ?? '';
    try {
      final businessPartners = await apiService.get(
        '/sync/businesspartners',
        queryParameters: {'companyDBId': dbid},
      );
      return right(BusinessPartner.fromJson(businessPartners));
    } catch (e) {
      // Check for the specific failure types first
      if (e is ServerFailure) {
        return left(e);
      }
      if (e is ApiException) {
        return left(ServerFailure(e.message));
      }
      // Keep a fallback for any other truly unexpected errors
      return left(
        ServerFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
