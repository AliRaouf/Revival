import 'package:revival/features/order/domain/entity/order.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';

class AddOrderItem {
  final OrderRepo orderRepository;
  AddOrderItem(this.orderRepository);

  Future<void> call(Order order) async {
    // await orderRepository.(order);
  }
}