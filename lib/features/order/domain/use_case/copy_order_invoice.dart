import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/features/order/data/models/copy_to_invoice/copy_to_invoice.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';

class CopyOrderInvoice {
  final OrderRepo orderRepository;
  CopyOrderInvoice(this.orderRepository);

  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> call(
    String docEntry,
    CopyToInvoice copyToInvoiceData,
  ) async {
    return await orderRepository.copyOrderToInvoice(
      docEntry,
      copyToInvoiceData,
    );
  }
}
