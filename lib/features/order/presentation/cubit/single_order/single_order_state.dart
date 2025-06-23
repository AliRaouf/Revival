part of 'single_order_cubit.dart';

sealed class SingleOrderState extends Equatable {
  const SingleOrderState();

  @override
  List<Object> get props => [];
}

final class SingleOrderInitial extends SingleOrderState {}

final class SingleOrderLoading extends SingleOrderState {}

final class SingleOrderSuccess extends SingleOrderState {
  final SingleOrder singleOrder;
  const SingleOrderSuccess({required this.singleOrder});
}

final class SingleOrderError extends SingleOrderState {
  final String errorMessage;
  const SingleOrderError({required this.errorMessage});
}
