import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/order/data/models/all_orders/all_orders.dart';
import 'package:revival/features/order/data/models/copy_to_invoice/copy_to_invoice.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';

abstract class OrderRepo {
  Future<Either<Failures, AllOrders>> getOpenOrders(
    Map<String, dynamic>? query,
  );
  Future<Either<Failures, SingleOrder>> getOrderDetails(String docEntry);
  Future<Either<Failures, Map<String, dynamic>>> copyOrderToInvoice(
    String docEntry,
    CopyToInvoice copyToInvoiceData,
  );
  // Future<OrderInfo> createNewOrder(OrderInfo orderData);
  // Future<void> saveOrderAsDraft(OrderInfo orderData);
}
