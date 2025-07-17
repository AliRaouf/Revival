import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/domain/use_case/get_order_details.dart';

part 'single_order_state.dart';

class SingleOrderCubit extends Cubit<SingleOrderState> {
  final GetOrderDetails _getOrderDetails;

  SingleOrderCubit({required GetOrderDetails getOrderDetails})
    : _getOrderDetails = getOrderDetails,
      super(SingleOrderInitial());

  Future<Either<Failures, SingleOrder>> getSingleOrder(String docEntry) async {
    emit(SingleOrderLoading());
    try {
      final result = await _getOrderDetails.call(docEntry);

      result.fold(
        (failure) => emit(SingleOrderError(errorMessage: failure.errMessage)),
        (order) {
          emit(SingleOrderSuccess(singleOrder: order));
        },
      );

      return result;
    } catch (e) {
      emit(SingleOrderError(errorMessage: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
