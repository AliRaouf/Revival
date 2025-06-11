import 'package:revival/features/order/domain/entity/order.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';

class CreateNewOrder {
  final OrderRepo orderRepo;
  CreateNewOrder(this.orderRepo);
  // Future<void> call(OrderInfo order) async {
  //   await orderRepo.createNewOrder(order);
  // }
}
