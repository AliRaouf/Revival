import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/business_partners/data/models/business_partner/business_partner.dart';
import 'package:revival/features/business_partners/domain/use_cases/business_partner_usecase.dart';

part 'business_partner_state.dart';

class BusinessPartnerCubit extends Cubit<BusinessPartnerState> {
  final BusinessPartnerUsecase _businessPartnerUsecase;
  BusinessPartnerCubit({required BusinessPartnerUsecase businessPartnerUsecase})
    : _businessPartnerUsecase = businessPartnerUsecase,
      super(BusinessPartnerInitial());

  Future<Either<Failures, BusinessPartner>> getBusinessPartners() async {
    emit(BusinessPartnerLoading());
    try {
      final result = await _businessPartnerUsecase.getBusinessPartners();
      return result.fold(
        (failure) {
          emit(BusinessPartnerError(failure.errMessage));
          return Left(failure);
        },
        (businessPartners) {
          emit(BusinessPartnerSuccess(businessPartners));
          return Right(businessPartners);
        },
      );
    } catch (e) {
      emit(BusinessPartnerError(e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
