import 'package:revival/features/order/domain/entity/order.dart';

abstract class OrderRepo {
Future<List<Order>> getOpenOrders({String? searchQuery});
  Future<Order> getOrderDetails(String orderId);
  Future<Order> createNewOrder(Order orderData);
  Future<void> saveOrderAsDraft(Order orderData);
}