import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart'; // For number formatting

// --- Updated Data Model for Stock Item (Unchanged) ---
class StockItem {
  final String itemCode;
  final String itemName;
  final double available;
  final double committed;
  final String uom;
  final String itemGroup;
  final double taxPercentage;

  double get onHand => available + committed;

  StockItem({
    required this.itemCode,
    required this.itemName,
    required this.available,
    required this.committed,
    required this.uom,
    required this.itemGroup,
    required this.taxPercentage,
  });
}

// --- The Stock Viewing Page ---
class WarehouseStockPage extends StatefulWidget {
  const WarehouseStockPage({super.key});

  @override
  State<WarehouseStockPage> createState() => _WarehouseStockPageState();
}

class _WarehouseStockPageState extends State<WarehouseStockPage> {
  // --- Colors (Consistent Theme) ---
  static const Color primaryColor = Color(0xFF003366);
  static const Color accentColor = Color(0xFF004a99);
  static const Color cardBackgroundColor = Colors.white;
  static const Color backgroundColor = Color(0xFFF0F2F5);
  static const Color labelColor = Color(0xFF6c757d);
  static const Color textColor = Color(0xFF212529);
  static const Color positiveStockColor = Color(0xFF28a745);
  static const Color zeroStockColor = labelColor;
  static const Color lowStockColor = Color(0xFFffc107);
  static const Color negativeStockColor = Color(0xFFdc3545);
  static const Color searchBarColor = Color(0xFF002244);

  // --- Sample Stock Data (Unchanged) ---
  final List<StockItem> _allStockItems = [
    StockItem(itemCode: 'A0001', itemName: 'Standard Bolt M10', available: 1500, committed: 50, uom: 'PC', itemGroup: 'Fasteners', taxPercentage: 10.0),
    StockItem(itemCode: 'A0002', itemName: 'Washer M10', available: 3250, committed: 120, uom: 'PC', itemGroup: 'Fasteners', taxPercentage: 10.0),
    StockItem(itemCode: 'B0105', itemName: 'Industrial Gearbox', available: 15, committed: 3, uom: 'EA', itemGroup: 'Mechanical', taxPercentage: 15.0),
    StockItem(itemCode: 'B0110', itemName: 'Motor Assembly Type A', available: 5, committed: 5, uom: 'EA', itemGroup: 'Electrical', taxPercentage: 15.0),
    StockItem(itemCode: 'C2000', itemName: 'Safety Gloves (Pair)', available: 250, committed: 0, uom: 'PR', itemGroup: 'Safety', taxPercentage: 5.0),
    StockItem(itemCode: 'C2001', itemName: 'Hard Hat - Yellow', available: 0, committed: 0, uom: 'EA', itemGroup: 'Safety', taxPercentage: 5.0),
    StockItem(itemCode: 'D5555', itemName: 'Lubricant Can 5L', available: 88, committed: 12, uom: 'CAN', itemGroup: 'Consumables', taxPercentage: 0.0),
    StockItem(itemCode: 'F1234', itemName: 'Filter Cartridge X', available: 19, committed: 1, uom: 'EA', itemGroup: 'Filtration', taxPercentage: 15.0),
  ];

  // --- State Variables ---
  List<StockItem> _filteredStockItems = [];
  final TextEditingController _searchController = TextEditingController();
  String? _expandedItemCode;
  bool _isLoading = false;
  // --- State for Group Filter ---
  String? _selectedItemGroup; // Can be null or "All Groups" initially
  List<String> _availableItemGroups = [];
  static const String _allGroupsValue = "All Groups"; // Constant for clarity

  // --- Formatters ---
  final NumberFormat _qtyFormatter = NumberFormat("#,##0", "en_US");
  final NumberFormat _percentFormatter = NumberFormat("0.##'%'", "en_US");

  @override
  void initState() {
    super.initState();
    _populateItemGroups(); // Populate the groups list
    _selectedItemGroup = _allGroupsValue; // Start with "All Groups" selected
    _filteredStockItems = _allStockItems; // Initially show all
    _searchController.addListener(_filterStockItems);
  }

  // --- Helper to get unique groups ---
  void _populateItemGroups() {
    final Set<String> groups = {};
    for (var item in _allStockItems) {
      groups.add(item.itemGroup);
    }
    _availableItemGroups = [_allGroupsValue, ...groups.toList()..sort()]; // Add "All" and sort
  }


  @override
  void dispose() {
    _searchController.removeListener(_filterStockItems);
    _searchController.dispose();
    super.dispose();
  }

  // --- UPDATED Filtering Logic ---
  void _filterStockItems() {
    final query = _searchController.text.toLowerCase();
    final selectedGroup = _selectedItemGroup;

    setState(() {
      // Start with the full list
      List<StockItem> tempFiltered = _allStockItems;

      // 1. Filter by Group (if a specific group is selected)
      if (selectedGroup != null && selectedGroup != _allGroupsValue) {
        tempFiltered = tempFiltered.where((item) => item.itemGroup == selectedGroup).toList();
      }

      // 2. Filter by Search Query (on the result of the group filter)
      if (query.isNotEmpty) {
        tempFiltered = tempFiltered.where((item) {
          final codeLower = item.itemCode.toLowerCase();
          final nameLower = item.itemName.toLowerCase();
          return codeLower.contains(query) || nameLower.contains(query);
        }).toList();
      }

      _filteredStockItems = tempFiltered;
      // Optionally collapse card when filtering changes
      _expandedItemCode = null;
    });
  }


  Future<void> _refreshData() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    // TODO: Fetch real data from API here and update _allStockItems
    // After fetching new _allStockItems:
    setState(() {
      _allStockItems.shuffle(); // Demo shuffle
      _populateItemGroups(); // Re-populate groups in case they changed
      _searchController.clear();
      _selectedItemGroup = _allGroupsValue; // Reset group filter
      _filteredStockItems = _allStockItems; // Apply filters (which now includes reset group)
      _expandedItemCode = null;
      _isLoading = false;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Stock data refreshed!'),
        duration: const Duration(seconds: 1),
        backgroundColor: accentColor,
      ),
    );
  }

  Color _getAvailableStockColor(double available) {
    if (available <= 0) return zeroStockColor;
    if (available < 20) return lowStockColor;
    return positiveStockColor;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Warehouse Stock"),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2.0,
        actions: [
          IconButton(
            icon: _isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                : const Icon(Icons.refresh),
            tooltip: 'Refresh Stock Data',
            onPressed: _refreshData,
          ),
        ],
        // --- AppBar Bottom with Search and Group Filter ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120.0), // Increased height for two rows
          child: Container( // Container to control background color if needed
            color: primaryColor, // Keep AppBar color for the filter section
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                // --- Search Bar ---
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white.withOpacity(0.7),
                  decoration: InputDecoration(
                    hintText: 'Search Item Code or Name...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.8), size: 20),
                    filled: true,
                    fillColor: searchBarColor.withOpacity(0.8),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: isSearching
                        ? IconButton(
                      icon: Icon(Icons.clear, color: Colors.white.withOpacity(0.8), size: 20),
                      onPressed: () => _searchController.clear(),
                      padding: EdgeInsets.zero, // Remove extra padding
                      constraints: const BoxConstraints(), // Remove constraints if needed
                    )
                        : null,
                  ),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),

                const SizedBox(height: 8), // Space between search and dropdown

                // --- Item Group Dropdown Filter ---
                SizedBox( // Constrain width if needed, or let it fill
                  height: 45, // Explicit height for the dropdown row
                  child: DropdownButtonFormField<String>(
                    value: _selectedItemGroup,
                    isExpanded: true,
                    items: _availableItemGroups.map((String group) {
                      return DropdownMenuItem<String>(
                        value: group,
                        child: Text(
                          group,
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == null) return;
                      setState(() {
                        _selectedItemGroup = newValue;
                        _filterStockItems(); // Re-apply filters when group changes
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardBackgroundColor, // White background for dropdown
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none, // No border needed if filled
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: accentColor, width: 1.5), // Highlight on focus
                      ),
                    ),
                    style: TextStyle(color: textColor, fontSize: 14), // Text color inside dropdown
                    icon: Icon(Icons.filter_list, color: primaryColor, size: 20),
                    dropdownColor: cardBackgroundColor, // Background of the dropdown menu items
                  ).animate(delay: 200.ms).fadeIn().slideY(begin: 0.3),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        color: primaryColor,
        child: _buildStockList(textTheme),
      ),
    );
  }

  // --- Builder for the list content (Unchanged) ---
  Widget _buildStockList(TextTheme textTheme) {
    if (_filteredStockItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.filter_list_off_outlined, size: 70, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No Stock Items Found',
                style: textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              if (_selectedItemGroup != _allGroupsValue || _searchController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Try adjusting your search or group filter.',
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 300.ms);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      itemCount: _filteredStockItems.length,
      itemBuilder: (context, index) {
        final item = _filteredStockItems[index];
        final bool isExpanded = _expandedItemCode == item.itemCode;

        return StockItemExpandableCard(
          item: item,
          isExpanded: isExpanded,
          qtyFormatter: _qtyFormatter,
          percentFormatter: _percentFormatter,
          getAvailableStockColor: _getAvailableStockColor,
          onTap: () {
            setState(() {
              if (_expandedItemCode == item.itemCode) {
                _expandedItemCode = null;
              } else {
                _expandedItemCode = item.itemCode;
              }
            });
          },
          primaryColor: primaryColor,
          cardBackgroundColor: cardBackgroundColor,
          labelColor: labelColor,
          textColor: textColor,
        )
            .animate(delay: (60 * (index % 20)).ms)
            .fadeIn(duration: 350.ms)
            .slideY(begin: 0.1, duration: 250.ms, curve: Curves.easeOut);
      },
    );
  }
}


// --- Dedicated Expandable Card Widget (Unchanged) ---
class StockItemExpandableCard extends StatelessWidget {
  final StockItem item;
  final bool isExpanded;
  final VoidCallback onTap;
  final NumberFormat qtyFormatter;
  final NumberFormat percentFormatter;
  final Color Function(double) getAvailableStockColor;
  final Color primaryColor;
  final Color cardBackgroundColor;
  final Color labelColor;
  final Color textColor;

  const StockItemExpandableCard({
    super.key,
    required this.item,
    required this.isExpanded,
    required this.onTap,
    required this.qtyFormatter,
    required this.percentFormatter,
    required this.getAvailableStockColor,
    required this.primaryColor,
    required this.cardBackgroundColor,
    required this.labelColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final availableColor = getAvailableStockColor(item.available);

    return Card(
      elevation: isExpanded ? 3.0 : 1.5,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: cardBackgroundColor,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: primaryColor.withOpacity(0.1),
        highlightColor: primaryColor.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Always Visible Row ---
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.itemName,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.itemCode,
                          style: textTheme.bodySmall?.copyWith(color: labelColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Avail: ', style: textTheme.bodySmall?.copyWith(color: labelColor, fontSize: 11)),
                          Text(
                            qtyFormatter.format(item.available),
                            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: availableColor, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Commit: ', style: textTheme.bodySmall?.copyWith(color: labelColor, fontSize: 11)),
                          Text(
                            qtyFormatter.format(item.committed),
                            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, color: item.committed > 0 ? textColor.withOpacity(0.8) : labelColor, fontSize: 13),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: labelColor,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // --- Expandable Details ---
              AnimatedSize(
                duration: 300.ms,
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                child: Visibility(
                  visible: isExpanded,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(height: 1, thickness: 0.5),
                        const SizedBox(height: 8),
                        _buildDetailRow(Icons.straighten_outlined, "UoM", item.uom, textTheme),
                        _buildDetailRow(Icons.category_outlined, "Group", item.itemGroup, textTheme),
                        _buildDetailRow(Icons.percent_outlined, "Tax", percentFormatter.format(item.taxPercentage / 100), textTheme),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper for detail rows (Unchanged) ---
  Widget _buildDetailRow(IconData icon, String label, String value, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Icon(icon, size: 15, color: labelColor),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: textTheme.bodySmall?.copyWith(color: labelColor, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(color: textColor, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}


// --- Main App Setup (Unchanged) ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor = Color(0xFF003366);
  static const Color accentColor = Color(0xFF004a99);
  static const Color backgroundColor = Color(0xFFF0F2F5);
  static const Color cardBackgroundColor = Colors.white;
  static const Color textColor = Color(0xFF212529);
  static const Color labelColor = Color(0xFF6c757d);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: accentColor,
          background: backgroundColor,
          onBackground: textColor,
          surface: cardBackgroundColor,
          onSurface: textColor,
          error: Colors.red.shade700,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2.0,
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          elevation: 1.5,
          color: cardBackgroundColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        textTheme: const TextTheme(
          labelSmall: TextStyle(color: labelColor),
        ).apply(
          bodyColor: textColor,
          displayColor: textColor,
        )
    );

    return MaterialApp(
      title: 'Warehouse Stock Viewer',
      theme: theme,
      home: const WarehouseStockPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}