import 'package:revival/features/order/domain/entity/order.dart';

abstract class OrderRepo {
Future<List<OrderInfo>> getOpenOrders({String? searchQuery});
  Future<OrderInfo> getOrderDetails(String orderId);
  Future<OrderInfo> createNewOrder(OrderInfo orderData);
  Future<void> saveOrderAsDraft(OrderInfo orderData);
}