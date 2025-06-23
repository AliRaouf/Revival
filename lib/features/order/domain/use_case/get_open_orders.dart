import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/order/data/models/all_orders/all_orders.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';

class GetOpenOrders {
  final OrderRepo orderRepository;

  GetOpenOrders(this.orderRepository);

  Future<Either<Failures, AllOrders>> call(Map<String, dynamic>? query) async {
    return await orderRepository.getOpenOrders(query);
  }
}
