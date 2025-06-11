import 'package:revival/features/order/domain/entity/order.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';

class GetOpenOrders {
  final OrderRepo orderRepository;

  GetOpenOrders(this.orderRepository);

  // Future<List<OrderInfo>> call() async {
  //   return await orderRepository.getOpenOrders();
  // }
}
