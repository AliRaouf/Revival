import 'package:flutter/material.dart';
// Import theme constants
import 'package:revival/core/theme/theme.dart';

// Function to show the dialog
void showAddItemDialog(BuildContext context, String customerName) {
  // Use StatefulWidget inside the dialog builder for local state management
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent closing by tapping outside
    builder: (_) => _AddItemDialogContent(customerName: customerName),
  );
}

// --- Dialog Content Widget ---
class _AddItemDialogContent extends StatefulWidget {
  final String customerName;

  const _AddItemDialogContent({required this.customerName});

  @override
  State<_AddItemDialogContent> createState() => _AddItemDialogContentState();
}

class _AddItemDialogContentState extends State<_AddItemDialogContent> {
  // Controllers for text fields
  final _itemCodeController = TextEditingController();
  final _descController = TextEditingController();
  final _qtyController = TextEditingController(text: '1'); // Default quantity
  final _unitPriceController = TextEditingController(text: '0.00');
  final _discountController = TextEditingController(text: '0.00');

  // State for calculated values
  String _total = '0.00';
  String _discountedTotal = '0.00';
  String _selectedWarehouse = 'WH-001'; // Example warehouse code

  // Dummy warehouse list (replace with actual data)
  final List<String> _warehouseItems = ['WH-001', 'WH-002', 'WH-MAIN'];

  @override
  void initState() {
    super.initState();
    // Add listeners to calculate totals automatically
    _qtyController.addListener(_calculateTotals);
    _unitPriceController.addListener(_calculateTotals);
    _discountController.addListener(_calculateTotals);
    _calculateTotals(); // Initial calculation
  }

  @override
  void dispose() {
    _itemCodeController.dispose();
    _descController.dispose();
    _qtyController.dispose();
    _unitPriceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  // Calculation logic
  void _calculateTotals() {
    final qty = int.tryParse(_qtyController.text) ?? 0;
    final unitPrice = double.tryParse(_unitPriceController.text) ?? 0.0;
    // Assuming discount is a fixed amount, not percentage
    final discountAmount = double.tryParse(_discountController.text) ?? 0.0;

    final currentTotal = (qty * unitPrice);
    final currentDiscountedTotal = currentTotal - discountAmount;

    // Update state only if values changed to avoid unnecessary rebuilds
    if (mounted &&
        (_total != currentTotal.toStringAsFixed(2) ||
            _discountedTotal != currentDiscountedTotal.toStringAsFixed(2))) {
      setState(() {
        _total = currentTotal.toStringAsFixed(2);
        _discountedTotal = currentDiscountedTotal.toStringAsFixed(2);
      });
    }
  }

  // Function to handle adding the item
  void _addItem() {
    // TODO: Add validation logic here
    // if (_formKey.currentState?.validate() ?? false) { ... }

    // TODO: Pass item data back to the NewOrderScreen
    print(
      'Item Added: Code=${_itemCodeController.text}, Qty=${_qtyController.text}, ...',
    );

    Navigator.pop(context); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    // Determine dialog width based on screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final dialogWidthFactor =
        isSmallScreen ? 0.9 : 0.5; // Adjust factor as needed

    return Dialog(
      // Uses DialogTheme for background, shape, elevation
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 40, // Adjust padding based on size
        vertical: isSmallScreen ? 40 : 80,
      ),
      child: FractionallySizedBox(
        widthFactor: dialogWidthFactor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0), // Consistent padding
            child: Column(
              mainAxisSize: MainAxisSize.min, // Take minimum height
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // --- Title ---
                Text(
                  widget.customerName,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),

                // --- Input Fields ---
                _buildRow(
                  context,
                  'Item Code',
                  _styledField(
                    context,
                    controller: _itemCodeController,
                    hintText: 'Enter item code',
                    // icon: Icons.search, // Optional search icon
                    // onIconTap: () { /* TODO: Implement item search */ }
                  ),
                ),
                _buildRow(
                  context,
                  'Description',
                  _styledField(
                    context,
                    controller: _descController,
                    hintText: 'Item description',
                  ),
                ),
                _buildRow(
                  context,
                  'Quantity',
                  _styledField(
                    context,
                    controller: _qtyController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                _buildRow(
                  context,
                  'Unit Price',
                  _styledField(
                    context,
                    controller: _unitPriceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
                _buildRow(
                  context,
                  'Discount', // Assuming fixed amount discount
                  _styledField(
                    context,
                    controller: _discountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    hintText: 'Amount (e.g., 5.00)',
                  ),
                ),
                // --- Warehouse Dropdown ---
                _buildRow(
                  context,
                  'Warehouse',
                  DropdownButtonFormField<String>(
                    value: _selectedWarehouse,
                    items:
                        _warehouseItems
                            .map(
                              (wh) => DropdownMenuItem(
                                value: wh,
                                child: Text(wh, style: textTheme.bodyMedium),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedWarehouse = value);
                      }
                    },
                    // Use the styled field decoration
                    decoration: kAddItemDialogInputDecoration.copyWith(
                      // Remove floating label behavior if not desired for dropdown
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    dropdownColor: theme.cardColor,
                    style: textTheme.bodyMedium,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: theme.iconTheme.color?.withOpacity(0.6),
                    ),
                  ),
                ),

                const Divider(height: 32), // Use theme divider
                // --- Totals Display ---
                _buildDisplayRow(context, 'Total:', _total),
                _buildDisplayRow(context, 'After Discount:', _discountedTotal),

                const SizedBox(height: 24),

                // --- Action Buttons ---
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Align buttons to end
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style:
                          kTextButtonErrorStyle, // Use specific error style for Cancel
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _addItem,
                      // Uses ElevatedButtonTheme style
                      child: const Text('Add Item'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets for Rows ---

  // Row for Label + Input Field
  Widget _buildRow(BuildContext context, String label, Widget field) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
      ), // Consistent vertical padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
        children: [
          SizedBox(
            width: 100, // Fixed width for labels
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color:
                    theme.colorScheme.primary, // Use primary color for labels
              ),
            ),
          ),
          const SizedBox(width: 12), // Space between label and field
          Expanded(child: field),
        ],
      ),
    );
  }

  // Row for Label + Display Value
  Widget _buildDisplayRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align label and value
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: mediumTextColor,
            ), // Use medium color for label
          ),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ), // Slightly bolder value
          ),
        ],
      ),
    );
  }

  // Helper for the styled input field used in this dialog
  Widget _styledField(
    BuildContext context, {
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? hintText,
    IconData? icon, // Optional icon
    VoidCallback? onIconTap, // Action for icon tap
    bool readOnly = false,
    void Function(String)? onChanged,
  }) {
    final theme = Theme.of(context);

    // Use Material for elevation effect
    return Material(
      elevation: 2.0, // Add subtle elevation
      shadowColor: theme.shadowColor,
      borderRadius: BorderRadius.circular(
        kDefaultBorderRadius,
      ), // Match input border radius
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onChanged: onChanged,
        style: theme.textTheme.bodyMedium, // Use theme style for input text
        decoration: kAddItemDialogInputDecoration.copyWith(
          // Use specific dialog input style
          hintText: hintText,
          // Add icon if provided
          suffixIcon:
              icon != null
                  ? IconButton(
                    icon: Icon(
                      icon,
                      color: theme.iconTheme.color?.withOpacity(0.6),
                    ),
                    onPressed: onIconTap,
                    splashRadius: 20,
                  )
                  : null,
        ),
      ),
    );
  }
}
