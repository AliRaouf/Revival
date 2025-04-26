import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/features/ar_invoice/presentation/utils/invoice_utils.dart';
import 'package:revival/features/order/presentation/views/widgets/add_items_dialogue.dart';

import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/order/presentation/views/widgets/new_order_bottom_appbar.dart';

class NewInvoiceScreen extends StatefulWidget {
  const NewInvoiceScreen({super.key});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  late TextEditingController _dateController;
  late TextEditingController _validUntilController;
  final InvoiceUtils invoiceUtils = InvoiceUtils();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedValidUntilDate = DateTime.now().add(
    const Duration(days: 30),
  );
  String? _selectedCustomer;
  String? _selectedShippingAddress;
  String? _selectedSalesPerson;
  String? _selectedContactPerson;

  final List<String> _customerItems = [
    'Customer A',
    'Customer B',
    'Customer C',
  ];
  final List<String> _addressItems = ['Address 1', 'Address 2', 'Main Office'];
  final List<String> _salesPersonItems = ['Sales Rep 1', 'Sales Rep 2'];
  final List<String> _contactPersonItems = [
    'Contact X',
    'Contact Y',
    'Contact Z',
  ];

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: _formatDate(_selectedDate));
    _validUntilController = TextEditingController(
      text: _formatDate(_selectedValidUntilDate),
    );
  }

  @override
  void dispose() {
    _referenceController.dispose();
    _titleController.dispose();
    _dateController.dispose();
    _validUntilController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) => DateFormat('MMM d, yyyy').format(date);

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final theme = Theme.of(context);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _selectedDate : _selectedValidUntilDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2101),

      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: darkTextColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: primaryColor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        final formattedDate = _formatDate(picked);
        if (isStartDate) {
          _selectedDate = picked;
          _dateController.text = formattedDate;

          if (_selectedValidUntilDate.isBefore(_selectedDate)) {
            _selectedValidUntilDate = _selectedDate.add(
              const Duration(days: 1),
            );
            _validUntilController.text = _formatDate(_selectedValidUntilDate);
          }
        } else {
          if (picked.isBefore(_selectedDate)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Valid until date cannot be before the order date.',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {
            _selectedValidUntilDate = picked;
            _validUntilController.text = formattedDate;
          }
        }
      });
    }
  }

  void _addItem() {
    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a customer first.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showAddItemDialog(context, _selectedCustomer!);
  }

  void _saveDraft() {
    print("Save Draft tapped");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Save Draft functionality not implemented.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _submitOrder() {
    print("Submit tapped");

    invoiceUtils.showSuccessDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdownField(
                    context: context,
                    label: "Customer",
                    value: _selectedCustomer,
                    items: _customerItems,
                    onChanged: (v) => setState(() => _selectedCustomer = v),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          context: context,
                          label: "Date",
                          controller: _dateController,
                          onTap: () => _selectDate(context, true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDateField(
                          context: context,
                          label: "Valid until",
                          controller: _validUntilController,
                          onTap: () => _selectDate(context, false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context: context,
                    label: "Reference Number",
                    controller: _referenceController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context: context,
                    label: "Title",
                    controller: _titleController,
                    maxLength: 50,
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    context: context,
                    label: "Shipping Address",
                    value: _selectedShippingAddress,
                    items: _addressItems,
                    onChanged:
                        (v) => setState(() => _selectedShippingAddress = v),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    context: context,
                    label: "Sales Person",
                    value: _selectedSalesPerson,
                    items: _salesPersonItems,
                    onChanged: (v) => setState(() => _selectedSalesPerson = v),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    context: context,
                    label: "Contact Person",
                    value: _selectedContactPerson,
                    items: _contactPersonItems,
                    onChanged:
                        (v) => setState(() => _selectedContactPerson = v),
                  ),

                  const SizedBox(height: 32),
                  Text("Added Items", style: theme.textTheme.titleSmall),
                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 100),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.dividerColor),
                      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                      color: theme.colorScheme.surface.withOpacity(0.5),
                    ),
                    child: Text(
                      "List is empty.",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: mediumTextColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Add Text Line not implemented.'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },

                        child: Text("Add Text Line"),
                      ),
                      TextButton(onPressed: _addItem, child: Text("Add Items")),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          NewOrderBottomAppbar(
            context,
            saveDraft: _saveDraft,
            submitOrder: _submitOrder,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('New Invoice'),
          Text(
            'Revival',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      centerTitle: false,
      titleSpacing: 0,
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    int? maxLength,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          style: theme.textTheme.bodyMedium,
          decoration: kUnderlinedInputDecoration.copyWith(
            counterText: maxLength != null ? null : '',
            counterStyle: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          style: theme.textTheme.bodyMedium,
          decoration: kUnderlinedInputDecoration.copyWith(
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: theme.iconTheme.color?.withOpacity(0.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.bodySmall),

        DropdownButtonFormField<String>(
          value: value,
          items:
              items.map<DropdownMenuItem<String>>((String itemValue) {
                return DropdownMenuItem<String>(
                  value: itemValue,
                  child: Text(itemValue, style: theme.textTheme.bodyMedium),
                );
              }).toList(),
          onChanged: onChanged,

          decoration: kUnderlinedInputDecoration.copyWith(hintText: 'Select'),
          dropdownColor: theme.cardColor,
          isExpanded: true,
          style: theme.textTheme.bodyMedium,
          icon: Icon(
            Icons.arrow_drop_down,
            color: theme.iconTheme.color?.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
