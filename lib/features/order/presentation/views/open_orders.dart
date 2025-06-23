import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/order/data/models/all_orders/value.dart';
import 'package:revival/features/order/presentation/cubit/open_order/order_cubit.dart';
import 'package:revival/features/order/presentation/cubit/single_order/single_order_cubit.dart';
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

  // This list holds the original, unmodified data from the API.
  List<Value> _sourceOrders = [];

  // This list holds the data to be displayed, which will be filtered.
  List<Value> _filteredOrders = [];
  final query = getIt<OrderQuery>().getQuery;
  // No need for a separate _searchQuery state variable, we can get it from the controller.

  @override
  void initState() {
    super.initState();
    // Add the listener ONCE when the widget is initialized.
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderCubit>().getOpenOrders(query);
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        // If the search query is empty, display the full original list.
        _filteredOrders = List.from(_sourceOrders);
      } else {
        // Otherwise, filter the source list based on the query.
        _filteredOrders =
            _sourceOrders.where((order) {
              // Reimplementing search by docNum clearly.
              // We use toString() to ensure the search works even if docNum is an integer.
              final docNumString = order.docNum?.toString() ?? '';
              final cardCode = order.cardCode?.toLowerCase() ?? '';

              return docNumString.contains(query) || cardCode.contains(query);
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
          color:
              scaffoldBackgroundColor, // Assuming this is a variable from your theme
          child: Column(
            children: [
              openOrdersInvoicesHeader(context, 'Open Orders'.tr()),
              buildBrandBar(
                context,
                MediaQuery.textScalerOf(context).textScaleFactor,
                MediaQuery.of(context).size.width > 600,
              ),
              // Pass the controller. No need to pass the query string.
              openOrdersSearch(
                context,
                _searchController,
                _searchController.text,
              ),

              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
      // floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    // Using BlocConsumer to combine listener and builder for cleaner code.
    return BlocConsumer<OrderCubit, OrderCubitState>(
      listener: (context, state) {
        // The listener is perfect for side-effects that should only happen once per state change.
        if (state is OrderSuccess) {
          // 1. Initialize our source and filtered lists when data is successfully loaded.
          _sourceOrders = state.allOrders.data?.value ?? [];
          _filteredOrders = List.from(_sourceOrders);
          // 2. If a search query already exists, re-apply it.
          // This handles cases where the screen might be rebuilt after a search was entered.
          _onSearchChanged();
        }
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrderError) {
          return _buildEmptyState(
            context: context,
            icon: Icons.error_outline,
            title: 'Error',
            message: state.errorMessage,
          );
        }

        if (state is OrderSuccess) {
          // Handle the case where the initial list is empty.
          if (_sourceOrders.isEmpty) {
            return _buildEmptyState(
              context: context,
              icon: Icons.list_alt_outlined,
              title: 'No Orders Yet',
              message: 'When orders are created, they will appear here.',
            );
          }

          // Handle the case where search yields no results.
          if (_filteredOrders.isEmpty) {
            return _buildEmptyState(
              context: context,
              icon: Icons.search_off_outlined,
              title: 'No Orders Found',
              message: 'Try adjusting your search query.',
            );
          }

          return RefreshIndicator(
            onRefresh: () {
              return context.read<OrderCubit>().getOpenOrders(query);
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: 80,
                top: 8,
              ),
              itemCount:
                  _filteredOrders.length, // Use the length of the filtered list
              itemBuilder: (context, index) {
                final order =
                    _filteredOrders[index]; // Get the item from the filtered list
                // Assuming OrderInvoiceSummaryCard has a tap handler to trigger SingleOrderCubit
                return OrderInvoiceSummaryCard(order: order);
              },
            ),
          );
        }

        // Default fallback state
        return const SizedBox.shrink();
      },
    );
  }

  // No changes needed for _buildEmptyState, _buildFloatingActionButton, or dispose.
  // ... (keep your existing implementations for these methods)

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
    // It's crucial to remove the listener and dispose of the controller to prevent memory leaks.
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
