part of 'copy_order_invoice_cubit.dart';

sealed class CopyOrderInvoiceState extends Equatable {
  const CopyOrderInvoiceState();

  @override
  List<Object> get props => [];
}

final class CopyOrderInvoiceInitial extends CopyOrderInvoiceState {}

final class CopyOrderInvoiceLoading extends CopyOrderInvoiceState {}

final class CopyOrderInvoiceSuccess extends CopyOrderInvoiceState {
  final Map<String, dynamic> response;

  const CopyOrderInvoiceSuccess({required this.response});
}

final class CopyOrderInvoiceError extends CopyOrderInvoiceState {
  final String errorMessage;

  const CopyOrderInvoiceError({required this.errorMessage});
}
