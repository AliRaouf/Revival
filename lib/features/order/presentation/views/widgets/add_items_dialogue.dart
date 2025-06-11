import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/domain/use_case/calculate_item_totals.dart';

void showAddItemDialog(BuildContext context, String customerName) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => _AddItemDialogContent(customerName: customerName),
  );
}

class _AddItemDialogContent extends StatefulWidget {
  final String customerName;

  const _AddItemDialogContent({required this.customerName});

  @override
  State<_AddItemDialogContent> createState() => _AddItemDialogContentState();
}

class _AddItemDialogContentState extends State<_AddItemDialogContent> {
  final _itemCodeController = TextEditingController();
  final _descController = TextEditingController();
  final _qtyController = TextEditingController(text: '1');
  final _unitPriceController = TextEditingController(text: '0.00');
  final _discountController = TextEditingController(text: '0.00');

  String _total = '0.00';
  String _discountedTotal = '0.00';
  String _selectedWarehouse = 'WH-001';

  final List<String> _warehouseItems = ['WH-001', 'WH-002', 'WH-MAIN'];

  @override
  void initState() {
    super.initState();
    _qtyController.addListener(_calculateTotals);
    _unitPriceController.addListener(_calculateTotals);
    _discountController.addListener(_calculateTotals);
    _calculateTotals();
  }

  void _calculateTotals() {
    final qty = int.tryParse(_qtyController.text) ?? 0;
    final unitPrice = double.tryParse(_unitPriceController.text) ?? 0.0;

    final discountAmount = double.tryParse(_discountController.text) ?? 0.0;
    CalculateItemTotals calculateItemTotals = CalculateItemTotals(
      quantity: qty,
      price: unitPrice,
      discount: discountAmount,
    );
    final total = calculateItemTotals.calculateCurrentTotal();
    final discountedTotal =
        calculateItemTotals.calculateCurrentDiscountedTotal();

    setState(() {
      _total = total.toStringAsFixed(2);
      _discountedTotal = discountedTotal.toStringAsFixed(2);
    });
  }

  void _addItem() {
    print(
      'Item Added: Code=${_itemCodeController.text}, Qty=${_qtyController.text}, ...',
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final dialogWidthFactor = isSmallScreen ? 0.9 : 0.5;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 40,
        vertical: isSmallScreen ? 40 : 80,
      ),
      child: FractionallySizedBox(
        widthFactor: dialogWidthFactor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.customerName,
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 24),

                _buildRow(
                  context,
                  'Item Code',
                  _styledField(
                    context,
                    controller: _itemCodeController,
                    hintText: 'Enter item code',
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
                  'Discount',
                  _styledField(
                    context,
                    controller: _discountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    hintText: 'Amount (e.g., 5.00)',
                  ),
                ),

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

                    decoration: kAddItemDialogInputDecoration.copyWith(
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

                const Divider(height: 32),

                _buildDisplayRow(context, 'Total', _total),
                _buildDisplayRow(context, 'After Discount', _discountedTotal),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: kTextButtonErrorStyle,
                      child: Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _addItem,

                      child: Text('Add Item'),
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

  Widget _buildRow(BuildContext context, String label, Widget field) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: field),
        ],
      ),
    );
  }

  Widget _buildDisplayRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(color: mediumTextColor),
          ),
          Text(
            value,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _styledField(
    BuildContext context, {
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? hintText,
    IconData? icon,
    VoidCallback? onIconTap,
    bool readOnly = false,
    void Function(String)? onChanged,
  }) {
    final theme = Theme.of(context);

    return Material(
      elevation: 2.0,
      shadowColor: theme.shadowColor,
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onChanged: onChanged,
        style: theme.textTheme.bodyMedium,
        decoration: kAddItemDialogInputDecoration.copyWith(
          hintText: hintText,

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

  @override
  void dispose() {
    _itemCodeController.dispose();
    _descController.dispose();
    _qtyController.dispose();
    _unitPriceController.dispose();
    _discountController.dispose();
    super.dispose();
  }
}
