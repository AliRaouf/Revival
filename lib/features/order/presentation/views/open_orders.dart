import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/dashboard/presentation/views/widgets/brand_bar.dart'; // Assuming refactored
// Import your actual screen files
import 'package:revival/features/order/presentation/views/new_orders.dart'; // Refactored
import 'package:revival/features/order/presentation/views/single_order.dart'; // Needs refactoring or exists
// Import theme constants if needed

// --- Data Model (Simple Example - Unchanged) ---
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
  // --- State Variables ---
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<OrderInfo> _filteredOrders = [];

  // --- Sample Data (Replace with actual data fetching) ---
  final List<OrderInfo> _allOrders = List.generate(
    20,
    (index) => OrderInfo(
      id: 'ORDER_${100 + index}',
      invoice: "10000$index",
      order: "${500 + index}",
      orderCode: "RC${20210 + index}",
      quote: "100$index",
      customerName:
          index % 3 == 0
              ? "Ahmed Khaled Co."
              : index % 3 == 1
              ? "Fatima Hassan Trading"
              : "Global Solutions Ltd.",
    ),
  );

  // --- Lifecycle Methods ---
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
    // Basic debounce mechanism (optional, consider using packages like flutter_hooks or rxdart for more robust debouncing)
    // Timer? debounce;
    // if (debounce?.isActive ?? false) debounce?.cancel();
    // debounce = Timer(const Duration(milliseconds: 300), () {
    final query = _searchController.text.trim().toLowerCase();
    if (query == _searchQuery) return;

    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredOrders = List.from(_allOrders);
      } else {
        _filteredOrders =
            _allOrders.where((order) {
              return order.customerName.toLowerCase().contains(_searchQuery) ||
                  order.orderCode.toLowerCase().contains(_searchQuery) ||
                  order.order.toLowerCase().contains(_searchQuery);
            }).toList();
      }
    });
    // });
  }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Use theme background
      body: SafeArea(
        child: Container(
          color: scaffoldBackgroundColor,
          child: Column(
            children: [
              _buildHeader(context), // Uses AppBarTheme
              // Assuming BrandBar uses theme
              buildBrandBar(
                context,
                MediaQuery.textScalerOf(context).textScaleFactor,
                MediaQuery.of(context).size.width > 600,
              ),
              _buildSearchBar(context), // Uses InputDecorationTheme
              Expanded(
                child: _buildContent(context),
              ), // Uses TextTheme, CardTheme etc.
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(
        context,
      ), // Uses FABTheme
    );
  }

  // --- Header Builder (Uses AppBarTheme implicitly) ---
  Widget _buildHeader(BuildContext context) {
    // Use AppBar for standard styling and back button handling
    return AppBar(
      // Properties like backgroundColor, foregroundColor, elevation from theme
      automaticallyImplyLeading:
          false, // Remove default back button if adding custom one
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icon color from theme
        tooltip: 'Back',
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Open Orders',
        // titleTextStyle from theme
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline), // Icon color from theme
          tooltip: 'Profile',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile button tapped!'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
    );
  }

  // --- Search Bar Builder ---
  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color?.withOpacity(0.6);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16.0,
        12.0,
        16.0,
        8.0,
      ), // Adjusted padding
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search by Name or Order Code...',
          prefixIcon: Icon(Icons.search, color: iconColor),
          suffixIcon:
              _searchQuery.isNotEmpty
                  ? IconButton(
                    icon: Icon(Icons.clear, color: iconColor),
                    tooltip: 'Clear Search',
                    onPressed: () {
                      _searchController
                          .clear(); // Listener will handle state update
                    },
                  )
                  : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ).applyDefaults(theme.inputDecorationTheme),
        style: theme.textTheme.bodyLarge, // Use theme text style
      ),
    );
  }

  // --- Content Builder (List or Empty State) ---
  Widget _buildContent(BuildContext context) {
    if (_allOrders.isEmpty) {
      return _buildEmptyState(
        context: context,
        icon: Icons.list_alt_outlined,
        title: "No Orders Yet",
        message: "When orders are created, they will appear here.",
      );
    }

    if (_filteredOrders.isEmpty && _searchQuery.isNotEmpty) {
      return _buildEmptyState(
        context: context,
        icon: Icons.search_off_outlined,
        title: "No Orders Found",
        message: "Try adjusting your search query.",
      );
    }

    // Display the list using the refactored _OrderSummaryCard
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: 12, // Adjust list padding to align with card margins
        right: 12,
        bottom: 80, // Space for FAB
        top: 8,
      ),
      itemCount: _filteredOrders.length,
      itemBuilder: (context, index) {
        final order = _filteredOrders[index];
        return _OrderSummaryCard(order: order); // Use the Card Widget
      },
    );
  }

  // --- Empty State Builder ---
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

  // --- Floating Action Button Builder (Uses FABTheme) ---
  Widget _buildFloatingActionButton(BuildContext context) {
    // Uses FloatingActionButtonThemeData from app_theme.dart
    return FloatingActionButton(
      // backgroundColor, foregroundColor, elevation, shape from theme
      tooltip: 'Create New Order',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewOrderScreen()),
        );
      },
      child: const Icon(Icons.add, size: 32), // Icon color from theme
    );
  }
} // End of _OpenOrdersScreenState class

// --- Order Summary Card Widget (Refactored) ---
class _OrderSummaryCard extends StatelessWidget {
  final OrderInfo order;

  const _OrderSummaryCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final listTileTheme = theme.listTileTheme;

    return Card(
      // Uses CardTheme properties (color, elevation, shadow, shape, margin)
      child: InkWell(
        // Use theme splash/highlight
        splashColor: theme.splashColor,
        highlightColor: theme.highlightColor,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              // Ensure SingleOrderScreen exists and accepts orderId
              builder: (context) => SingleOrderScreen(orderId: order.id),
            ),
          );
        },
        child: ListTile(
          // Use ListTileTheme properties (dense, contentPadding, iconColor)
          leading: CircleAvatar(
            backgroundColor: colorScheme.primary.withOpacity(
              0.1,
            ), // Subtle primary background
            child: Icon(
              Icons.receipt_long,
              color: colorScheme.primary, // Use primary color for icon
              size: 24,
            ),
          ),
          title: Text(
            order.customerName,
            // Use theme title style, override color if needed
            style:
                listTileTheme.titleTextStyle?.copyWith(
                  fontWeight: FontWeight.w600, // Make title bold
                  color: colorScheme.primary, // Use primary color for title
                ) ??
                textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              'Code: ${order.orderCode} / Order: ${order.order}',
              // Use theme subtitle style
              style: listTileTheme.subtitleTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: listTileTheme.iconColor?.withOpacity(
              0.8,
            ), // Use theme icon color
            size: 28,
          ),
          // contentPadding: listTileTheme.contentPadding, // Use theme padding
        ),
      ),
    );
  }
}
