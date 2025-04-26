import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/ar_invoice/domain/entity/invoice.dart';
import 'package:revival/features/ar_invoice/presentation/utils/invoice_utils.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';
import 'package:revival/shared/open_orders_invoices_header.dart';
import 'package:revival/features/order/presentation/views/widgets/open_orders_search.dart';
import 'package:revival/shared/order_summary_card.dart';
import 'package:revival/shared/utils.dart';

class OpenInvoicesScreen extends StatefulWidget {
  const OpenInvoicesScreen({super.key});

  @override
  State<OpenInvoicesScreen> createState() => _OpenInvoicesScreenState();
}

class _OpenInvoicesScreenState extends State<OpenInvoicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<Invoice> _filteredInvoices = [];
  final InvoiceUtils invoiceUtils = InvoiceUtils();
  @override
  void initState() {
    super.initState();
    _filteredInvoices = List.from(invoiceUtils.allInvoices);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query == _searchQuery) return;

    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredInvoices = List.from(invoiceUtils.allInvoices);
      } else {
        _filteredInvoices =
            invoiceUtils.allInvoices.where((order) {
              return order.customerName.toLowerCase().contains(_searchQuery) ||
                  order.orderCode.toLowerCase().contains(_searchQuery) ||
                  order.order.toLowerCase().contains(_searchQuery);
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
              openOrdersInvoicesHeader(context, 'Open Invoices'),
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
    if (invoiceUtils.allInvoices.isEmpty) {
      return _buildEmptyState(
        context: context,
        icon: Icons.list_alt_outlined,
        title: 'No Invoices Yet',
        message: 'When orders are created, they will appear here.',
      );
    }

    if (_filteredInvoices.isEmpty && _searchQuery.isNotEmpty) {
      return _buildEmptyState(
        context: context,
        icon: Icons.search_off_outlined,
        title: 'No Invoices Found',
        message: 'Try adjusting your search query.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 80, top: 8),
      itemCount: _filteredInvoices.length,
      itemBuilder: (context, index) {
        final invoice = _filteredInvoices[index];
        return OrderInvoiceSummaryCard(invoice: invoice);
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
      tooltip: 'Create New Invoice',
      onPressed: () {
        context.push('/invoice/new_invoice');
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
