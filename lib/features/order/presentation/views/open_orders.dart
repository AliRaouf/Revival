// --- open_orders_screen.dart ---

import 'package:flutter/material.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart';
import 'dart:async'; // For potential future debouncing

// --- !!! IMPORT YOUR ACTUAL SCREEN FILES !!! ---
import 'package:revival/features/order/presentation/views/new_orders.dart'; // For the FAB (+) button
import 'package:revival/features/order/presentation/views/single_order.dart'; // <--- IMPORT YOUR SINGLE ORDER SCREEN FILE

// --- Data Model (Simple Example) ---
class OrderInfo {
  final String id;
  final String invoice;
  final String order;
  final String orderCode;
  final String quote;
  final String customerName;

  OrderInfo({
    required this.id,
    required this.invoice,
    required this.order,
    required this.orderCode,
    required this.quote,
    required this.customerName,
  });
}

// --- Main Screen Widget ---
class OpenOrdersScreen extends StatefulWidget {
  const OpenOrdersScreen({super.key});

  @override
  State<OpenOrdersScreen> createState() => _OpenOrdersScreenState();
}

class _OpenOrdersScreenState extends State<OpenOrdersScreen> {
  // --- Style Constants ---
  static const Color _primaryColor = Color(0xFF17405E);
  static const Color _backgroundColor = Color(0xFFF9FAFB);
  static const Color _cardColor = Colors.white;
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 12.0;

  // --- State Variables for Search ---
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<OrderInfo> _filteredOrders = [];

  // --- Sample Data (Source of Truth) ---
  final List<OrderInfo> _allOrders = List.generate(
    20,
    (index) => OrderInfo(
      id: 'ORDER_${100 + index}', // Use a more descriptive ID for clarity
      invoice: "10000${index}",
      order: "${500 + index}",
      orderCode: "RC${20210 + index}",
      quote: "100${index}",
      customerName:
          index % 3 == 0
              ? "Ahmed Khaled Co."
              : index % 3 == 1
              ? "Fatima Hassan Trading"
              : "Global Solutions Ltd.",
    ),
  );

  @override
  void initState() {
    super.initState();
    _filteredOrders = List.from(_allOrders);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // --- Search Logic ---
  void _onSearchChanged() {
    final query = _searchController.text.trim().toLowerCase();
    if (query == _searchQuery) return;

    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredOrders = List.from(_allOrders);
      } else {
        _filteredOrders =
            _allOrders.where((order) {
              final nameMatches = order.customerName.toLowerCase().contains(
                _searchQuery,
              );
              final codeMatches = order.orderCode.toLowerCase().contains(
                _searchQuery,
              );
              // You might want to search other fields like order number too
              final orderNumMatches = order.order.toLowerCase().contains(
                _searchQuery,
              );
              return nameMatches || codeMatches || orderNumMatches;
            }).toList();
      }
    });
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: _backgroundColor,
          child: Column(
            children: [
              _buildHeader(context),
              buildBrandBar(context, 1.0, false),
              _buildSearchBar(),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  // --- Helper Widgets (Header, Branding, SearchBar, Content, EmptyState - unchanged) ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: _primaryColor,
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding / 2,
        vertical: _verticalPadding / 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                tooltip: 'Back',
                onPressed: () => Navigator.pop(context),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Open Orders',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white),
            tooltip: 'Profile',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile button tapped!')),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        _horizontalPadding,
        _verticalPadding,
        _horizontalPadding,
        _verticalPadding / 2,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search by Name or Order Code...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon:
              _searchQuery.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    tooltip: 'Clear Search',
                    onPressed: () {
                      _searchController.clear(); // This triggers the listener
                    },
                  )
                  : null,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: _primaryColor.withOpacity(0.8),
              width: 1.5,
            ),
          ),
        ),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_allOrders.isEmpty) {
      // Check original list first
      return _buildEmptyState(
        icon: Icons.list_alt_outlined,
        title: "No Orders Yet",
        message: "When orders are created, they will appear here.",
      );
    }

    if (_filteredOrders.isEmpty && _searchQuery.isNotEmpty) {
      return _buildEmptyState(
        icon: Icons.search_off_outlined,
        title: "No Orders Found",
        message: "Try adjusting your search query.",
      );
    }

    // Display the list using the _OrderSummaryCard
    return Container(
      color: _backgroundColor, // Use the screen background color
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: _horizontalPadding,
          right: _horizontalPadding,
          bottom: 80, // Space for FAB
          top: _horizontalPadding / 2,
        ),
        itemCount: _filteredOrders.length,
        itemBuilder: (context, index) {
          final order = _filteredOrders[index];
          // Pass the actual order data to the card
          return _OrderSummaryCard(order: order); // <--- Use the Card Widget
        },
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(_horizontalPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  // --- Floating Action Button (Navigates to NewOrderScreen) ---
  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: _primaryColor,
      elevation: 4,
      tooltip: 'Create New Order',
      onPressed: () {
        // Navigate using the IMPORTED NewOrderScreen class
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => const NewOrderScreen(), // From new_orders.dart
          ),
        );
      },
      child: const Icon(Icons.add, color: Colors.white, size: 32),
    );
  }
} // End of _OpenOrdersScreenState class

// --- Enhanced Order Summary Card Widget ---
class _OrderSummaryCard extends StatelessWidget {
  final OrderInfo order;

  const _OrderSummaryCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: _OpenOrdersScreenState._cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        // --- onTap ACTION MODIFIED ---
        onTap: () {
          print("Tapped on order: ${order.id}"); // Keep for debugging
          Navigator.push(
            context,
            MaterialPageRoute(
              // Use the IMPORTED SingleOrderScreen from single_order.dart
              // Assuming your real SingleOrderScreen constructor takes 'orderId'
              builder:
                  (context) => SingleOrderScreen(
                    orderId: order.id,
                  ), // <--- NAVIGATE TO IMPORTED SCREEN
            ),
          );
        },
        // --- END onTap MODIFICATION ---
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _OpenOrdersScreenState._primaryColor.withOpacity(
                0.1,
              ),
              child: Icon(
                Icons.receipt_long, // Consistent icon
                color: _OpenOrdersScreenState._primaryColor,
                size: 24,
              ),
            ),
            title: Text(
              order.customerName,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: _OpenOrdersScreenState._primaryColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Code: ${order.orderCode} / Order: ${order.order}',
                style: textTheme.bodyMedium?.copyWith(color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 28,
            ),
            contentPadding: EdgeInsets.zero, // Let Padding handle spacing
          ),
        ),
      ),
    );
  }
}
