import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/domain/entities/auth_token.dart';
import 'package:revival/features/order/data/models/all_orders/value.dart';
import 'package:revival/features/order/presentation/cubit/open_order/order_cubit.dart';
import 'package:revival/shared/open_orders_invoices_header.dart';
import 'package:revival/features/order/presentation/views/widgets/open_orders_search.dart';
import 'package:revival/shared/order_summary_card.dart';
import 'package:revival/shared/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OpenOrdersScreen extends StatefulWidget {
  const OpenOrdersScreen({super.key});

  @override
  State<OpenOrdersScreen> createState() => _OpenOrdersScreenState();
}

class _OpenOrdersScreenState extends State<OpenOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Value> _sourceOrders = [];

  List<Value> _filteredOrders = [];
  final query = getIt<OrderQuery>().getQuery;


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
              // Search by order number (docNum)
              final docNumString = order.docNum?.toString() ?? '';
              // Search by company code (cardCode)
              final cardCode = order.cardCode?.toLowerCase() ?? '';
              // Search by company name (cardName)
              final cardName = order.cardName?.toLowerCase() ?? '';

              return docNumString.contains(query) ||
                  cardCode.contains(query) ||
                  cardName.contains(query);
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Utilities utilities = Utilities(context);
    return Scaffold(
      backgroundColor: utilities.theme.primaryColor,
      body: SafeArea(
        child: Container(
          color:
              scaffoldBackgroundColor, // Assuming this is a variable from your theme
          child: Column(
            children: [
              openOrdersInvoicesHeader(context, 'Open Orders'.tr()),
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
        if (state is OrderSuccess) {
          _sourceOrders = state.allOrders.data?.value ?? [];
          _filteredOrders = List.from(_sourceOrders);
          _onSearchChanged();
        }
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(
            child: SpinKitWave(color: primaryColor, size: 40),
          );
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

          return Column(
            children: [
              openOrdersSearch(
                context,
                _searchController,
                _searchController.text,
              ),
              // Handle the case where search yields no results.
              if (_filteredOrders.isEmpty)
                Expanded(
                  child: _buildEmptyState(
                    context: context,
                    icon: Icons.search_off_outlined,
                    title: 'No Orders Found',
                    message: 'Try adjusting your search query.',
                  ),
                )
              else
                Expanded(
                  child: RefreshIndicator(
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
                          _filteredOrders
                              .length, // Use the length of the filtered list
                      itemBuilder: (context, index) {
                        final order =
                            _filteredOrders[index];
                        return OrderInvoiceSummaryCard(order: order);
                      },
                    ),
                  ),
                ),
            ],
          );
        }

        return const SizedBox.shrink();
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
    final iconColor = primaryColor.withOpacity(0.6);
    final titleColor = darkTextColor;
    final messageColor = mediumTextColor;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Enhanced icon container
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: primaryColor.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Icon(icon, size: 48, color: iconColor),
            ),
            const SizedBox(height: 24),

            // Title with enhanced styling
            Text(
              title,
              style: textTheme.headlineSmall?.copyWith(
                color: titleColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Message with enhanced styling
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(
                color: messageColor,
                height: 1.5,
              ),
            ),

            // Action button for some empty states
            if (title == 'No Orders Yet') ...[
              const SizedBox(height: 32),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     context.push('/order/new_order');
              //   },
              //   icon: const Icon(Icons.add, size: 20),
              //   label: const Text('Create Your First Order'),
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 24,
              //       vertical: 12,
              //     ),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //   ),
              // ),
            ],
          ],
        ),
      ),
    );
  }

  // Widget _buildFloatingActionButton(BuildContext context) {
  //   return FloatingActionButton(
  //     tooltip: 'Create New Order',
  //     onPressed: () {
  //       context.push('/order/new_order');
  //     },
  //     child: const Icon(Icons.add, size: 32),
  //   );
  // }

  @override
  void dispose() {
    // It's crucial to remove the listener and dispose of the controller to prevent memory leaks.
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
