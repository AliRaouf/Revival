import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';

class GetOrderDetails {
  final OrderRepo orderRepository;
  GetOrderDetails(this.orderRepository);

  Future<Either<Failures, SingleOrder>> call(String docEntry) async {
    return await orderRepository.getOrderDetails(docEntry);
  }
}
