import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/order/data/models/copy_to_invoice/copy_to_invoice.dart';
import 'package:revival/features/order/presentation/cubit/copy_order_invoice/copy_order_invoice_cubit.dart';
import 'package:revival/features/order/presentation/cubit/open_order/order_cubit.dart';
import 'package:revival/features/order/presentation/cubit/single_order/single_order_cubit.dart';
import 'package:revival/features/order/presentation/views/widgets/contact_info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/copy_to_invoice_button.dart';
import 'package:revival/features/order/presentation/views/widgets/order_info_card.dart';
import 'package:revival/features/order/presentation/views/widgets/order_items_list.dart';
import 'package:revival/features/order/presentation/views/widgets/order_totals_card.dart';

class SingleOrderScreen extends StatelessWidget {
  const SingleOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleOrderCubit, SingleOrderState>(
      builder: (context, state) {
        if (state is SingleOrderLoading) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SingleOrderError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Order Details')),
            body: const Center(child: Text('Order not found.')),
          );
        }
        if (state is SingleOrderSuccess) {
          final order = state.singleOrder;
          final copyToInvoiceData = CopyToInvoice.fromSingleOrder(order);
          return Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Order ${order.data?.docEntry ?? ""}'),
                  const SizedBox(height: 3),
                  Text(
                    order.data?.cardName ?? "No Customer Name",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            body: Container(
              color: Theme.of(context).colorScheme.surface,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 18.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Replaced _buildSectionCard with a dedicated widget
                    OrderInfoCard(orderData: order),
                    const SizedBox(height: 24),

                    ContactInfoCard(orderData: order),
                    const SizedBox(height: 24),

                    // ElevatedButton(
                    //   onPressed: () => print('Custom Fields button tapped'),
                    //   child: const Text('Custom Fields'),
                    // ),
                    // const SizedBox(height: 24),

                    // Replaced item list with a dedicated widget
                    OrderItemsList(orderLines: order.data?.orderLines ?? []),
                    const SizedBox(height: 24),

                    // Replaced totals section with a dedicated widget
                    OrderTotalsCard(orderLines: order.data?.orderLines ?? []),
                    const SizedBox(height: 30),

                    BlocListener<CopyOrderInvoiceCubit, CopyOrderInvoiceState>(
                      listener: (context, state) {
                        if (state is CopyOrderInvoiceSuccess) {
                          final query = getIt<OrderQuery>().getQuery;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invoice copied successfully!'),
                            ),
                          );
                          context.read<OrderCubit>().getOpenOrders(query);
                          context.pop();
                        } else if (state is CopyOrderInvoiceError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)),
                          );
                        }
                      },
                      child: CopyToInvoiceCollectButton(
                        type: "Invoice",
                        copyToInvoiceData: copyToInvoiceData,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Order Details')),
          body: const Center(child: Text('No order data available.')),
        );
      },
    );
  }
}
