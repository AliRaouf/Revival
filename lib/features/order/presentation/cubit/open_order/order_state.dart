part of 'order_cubit.dart';

@immutable
sealed class OrderCubitState {}

final class OrderCubitInitial extends OrderCubitState {}

final class OrderLoading extends OrderCubitState {}

final class OrderSuccess extends OrderCubitState {
  final AllOrders allOrders;
  OrderSuccess({required this.allOrders});
}

final class OrderError extends OrderCubitState {
  final String errorMessage;
  OrderError({required this.errorMessage});
}
