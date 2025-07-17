import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/order/data/models/copy_to_invoice/copy_to_invoice.dart';
import 'package:revival/features/order/domain/use_case/copy_order_invoice.dart';

part 'copy_order_invoice_state.dart';

class CopyOrderInvoiceCubit extends Cubit<CopyOrderInvoiceState> {
  CopyOrderInvoice _copyOrderInvoiceUseCase;
  CopyOrderInvoiceCubit({required CopyOrderInvoice copyOrderInvoiceUseCase})
    : _copyOrderInvoiceUseCase = copyOrderInvoiceUseCase,
      super(CopyOrderInvoiceInitial());
  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> copyOrderToInvoice(
    String docEntry,
    CopyToInvoice copyToInvoice,
  ) async {
    emit(CopyOrderInvoiceLoading());
    try {
      final result = await _copyOrderInvoiceUseCase.call(
        docEntry,
        copyToInvoice,
      );

      result.fold(
        (failureMap) => emit(CopyOrderInvoiceError(errorMap: failureMap)),
        (invoice) {
          emit(CopyOrderInvoiceSuccess(response: invoice));
        },
      );

      return result;
    } catch (e) {
      emit(CopyOrderInvoiceError(errorMap: {'error': e.toString()}));
      return left({'error': e.toString()});
    }
  }
}
