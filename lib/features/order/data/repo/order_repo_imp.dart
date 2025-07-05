
import 'package:dartz/dartz.dart';
import 'package:revival/core/failures/failures.dart';
import 'package:revival/core/services/api_service.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/order/data/models/all_orders/all_orders.dart';
import 'package:revival/features/order/data/models/copy_to_invoice/copy_to_invoice.dart';
import 'package:revival/features/order/data/models/single_order/single_order.dart';
import 'package:revival/features/order/domain/repo/order_repo.dart';

class OrderRepoImp implements OrderRepo {
  final ApiService apiService;
  OrderRepoImp(this.apiService);
  @override
  Future<Either<Failures, AllOrders>> getOpenOrders(
    Map<String, dynamic>? query,
  ) async {
    try {
      final data = await apiService.get(
        '/sync/my-open-orders',
        queryParameters: query,
      );
      return right(AllOrders.fromJson(data));
    } catch (e) {
      // Check for the specific failure types first
      if (e is ServerFailure) {
        return left(e);
      }
      if (e is ApiException) {
        return left(ServerFailure(e.message));
      }
      // Keep a fallback for any other truly unexpected errors
      return left(
        ServerFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  // In your repository/data source file
  Future<Either<Failures, SingleOrder>> getOrderDetails(String docEntry) async {
    final dbid = getIt<OrderQuery>().getQuery?['companyDbId'] ?? '';
    var responseData;
    try {
      final data = await apiService.get(
        '/sync/$docEntry',
        queryParameters: {"companyDbId": dbid},
      );
      responseData = data; // Store the data before parsing
      // log(data.toString());
      return right(SingleOrder.fromJson(data));
    } catch (e) {
      // Check for the specific failure types first
      if (e is ServerFailure) {
        return left(e);
      }
      if (e is ApiException) {
        return left(ServerFailure(e.message));
      }
      // Keep a fallback for any other truly unexpected errors
      return left(
        ServerFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failures, Map<String, dynamic>>> copyOrderToInvoice(
    String docEntry,
    CopyToInvoice copyToInvoiceData,
  ) async {
    final dbid = getIt<OrderQuery>().getQuery?['companyDbId'] ?? '';
    try {
      final data = await apiService.post(
        '/api/invoices/from-order/$docEntry?companyDbId=$dbid',
        data: copyToInvoiceData.toJson(),
      );
      return right(data);
    } catch (e) {
      // Check for the specific failure types first
      if (e is ServerFailure) {
        return left(e);
      }
      if (e is ApiException) {
        return left(ServerFailure(e.message));
      }
      // Keep a fallback for any other truly unexpected errors
      return left(
        ServerFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
