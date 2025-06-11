import 'package:revival/features/order/domain/entity/order.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';

class GetOrderDetails {
  final OrderRepo orderRepository;
  GetOrderDetails({required this.orderRepository});

  // Future<OrderInfo> call(String orderId) async {
  //   return await orderRepository.getOrderDetails(orderId);
  // }
}
