import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';
import 'package:revival/features/order/data/models/all_orders/value.dart';
import 'package:revival/features/order/presentation/utils/order_utils.dart';
import 'package:revival/shared/open_orders_invoices_header.dart';
import 'package:revival/features/order/presentation/views/widgets/open_orders_search.dart';
import 'package:revival/shared/order_summary_card.dart';
import 'package:revival/shared/utils.dart';

class OpenOrdersScreen extends StatefulWidget {
  const OpenOrdersScreen({super.key});

  @override
  State<OpenOrdersScreen> createState() => _OpenOrdersScreenState();
}

class _OpenOrdersScreenState extends State<OpenOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Value> _filteredOrders = [];
   List<Value> _sourceOrders = []; 
  final OrderUtils orderUtils = OrderUtils();

  @override
  void initState() {
    super.initState();
 if (orderUtils.allOrders.success == true && orderUtils.allOrders.data?.value != null) {
      _sourceOrders = List.from(orderUtils.allOrders.data!.value!);
      _filteredOrders = List.from(_sourceOrders);
    }
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query == _searchQuery) return;

    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        // If search is empty, show all original orders
        _filteredOrders = List.from(_sourceOrders);
      } else {
        // 2. Filter the source list, not the entire response object
        _filteredOrders = _sourceOrders.where((order) {
          // Add null checks for safety if these fields can be null
          final customerName = order.docNum.toString();
          final orderCode = order.cardCode!;
          final orderName = order.docEntry.toString();

          return customerName.contains(_searchQuery) ||
              orderCode.contains(_searchQuery) ||
              orderName.contains(_searchQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Utilities(context);
    return Scaffold(
      backgroundColor: utilities.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          color: scaffoldBackgroundColor,
          child: Column(
            children: [
              openOrdersInvoicesHeader(context, 'Open Orders'),
              buildBrandBar(
                context,
                MediaQuery.textScalerOf(context).textScaleFactor,
                MediaQuery.of(context).size.width > 600,
              ),
              openOrdersSearch(context, _searchController, _searchQuery),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (orderUtils.allOrders.success == false) {
      return _buildEmptyState(
        context: context,
        icon: Icons.list_alt_outlined,
        title: 'No Orders Yet',
        message: 'When orders are created, they will appear here.',
      );
    }

    if (_filteredOrders.isEmpty && _searchQuery.isNotEmpty) {
      return _buildEmptyState(
        context: context,
        icon: Icons.search_off_outlined,
        title: 'No Orders Found',
        message: 'Try adjusting your search query.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 80, top: 8),
      itemCount: _filteredOrders.length,
      itemBuilder: (context, index) {
        final order = _filteredOrders[index];
        return OrderInvoiceSummaryCard(order: order);
      },
    );
  }

  Widget _buildEmptyState({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String message,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final iconColor = theme.iconTheme.color?.withOpacity(0.4);
    final titleColor = theme.colorScheme.onSurface.withOpacity(0.6);
    final messageColor = theme.colorScheme.onSurface.withOpacity(0.5);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: iconColor),
            const SizedBox(height: 16),
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(color: titleColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: messageColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      tooltip: 'Create New Order',
      onPressed: () {
        context.push('/order/new_order');
      },
      child: const Icon(Icons.add, size: 32),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
