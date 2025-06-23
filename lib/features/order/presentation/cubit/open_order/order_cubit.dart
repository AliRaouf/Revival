import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/order/data/models/all_orders/all_orders.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/domain/use_case/get_open_orders.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderCubitState> {
  final GetOpenOrders _getOpenOrders;
  OrderCubit({required GetOpenOrders getOpenOrders})
    : _getOpenOrders = getOpenOrders,
      super(OrderCubitInitial());

  Future<Either<Failures, AllOrders>> getOpenOrders(
    Map<String, dynamic>? query,
  ) async {
    emit(OrderLoading());
    try {
      final result = await _getOpenOrders.call(query);

      result.fold(
        (failure) => emit(OrderError(errorMessage: failure.errMessage)),
        (orders) {
          emit(OrderSuccess(allOrders: orders));
        },
      );

      return result;
    } catch (e) {
      emit(OrderError(errorMessage: e.toString()));
      return Left(ServerFailure(e.toString()));
    }
  }
}
