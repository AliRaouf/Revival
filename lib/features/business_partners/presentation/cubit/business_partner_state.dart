part of 'business_partner_cubit.dart';

sealed class BusinessPartnerState extends Equatable {
  const BusinessPartnerState();

  @override
  List<Object> get props => [];
}

final class BusinessPartnerInitial extends BusinessPartnerState {}
final class BusinessPartnerLoading extends BusinessPartnerState {}
final class BusinessPartnerSuccess extends BusinessPartnerState {
  final BusinessPartner businessPartners;

  const BusinessPartnerSuccess(this.businessPartners);
}
final class BusinessPartnerError extends BusinessPartnerState {
  final String message;
  
  const BusinessPartnerError(this.message);
}
