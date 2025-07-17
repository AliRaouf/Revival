import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/core/services/api_service.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/features/business_partners/data/models/single_business_partner/single_business_partner.dart';
import 'package:revival/features/business_partners/domain/repo/get_single_partner.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';

class GetSinglePartnerImp implements GetSinglePartnerRepo {
  final ApiService apiService;
  GetSinglePartnerImp(this.apiService);
  @override
  Future<Either<Failures, SingleBusinessPartner>> getSinglePartner(String id)async{
     final dbid = getIt<OrderQuery>().getQuery?['companyDbId'] ?? '';
    try {
      final businessPartner = await apiService.get(
        '/sync/businesspartners/$id',
        queryParameters: {'companyDBId': dbid},
      );
      return right(SingleBusinessPartner.fromJson(businessPartner));
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
