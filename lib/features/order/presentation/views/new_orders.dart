import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revival/features/order/presentation/views/widgets/add_items_dialogue.dart'; // Assuming refactored
// Import theme constants for specific styles/colors
import 'package:revival/core/theme/theme.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  // --- Controllers ---
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  late TextEditingController _dateController;
  late TextEditingController _validUntilController;

  // --- State Variables ---
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedValidUntilDate = DateTime.now().add(const Duration(days: 30));
  String? _selectedCustomer;
  String? _selectedShippingAddress;
  String? _selectedSalesPerson;
  String? _selectedContactPerson;

  // --- Dummy Data (Replace with actual data fetching) ---
  final List<String> _customerItems = ['Customer A', 'Customer B', 'Customer C'];
  final List<String> _addressItems = ['Address 1', 'Address 2', 'Main Office'];
  final List<String> _salesPersonItems = ['Sales Rep 1', 'Sales Rep 2'];
  final List<String> _contactPersonItems = ['Contact X', 'Contact Y', 'Contact Z'];

  // --- Lifecycle Methods ---
  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController(text: _formatDate(_selectedDate));
    _validUntilController = TextEditingController(text: _formatDate(_selectedValidUntilDate));
  }

  @override
  void dispose() {
    _referenceController.dispose();
    _titleController.dispose();
    _dateController.dispose();
    _validUntilController.dispose();
    super.dispose();
  }

  // --- Helper Methods ---
  String _formatDate(DateTime date) => DateFormat('MMM d, yyyy').format(date);

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final theme = Theme.of(context); // Get theme for DatePicker styling

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _selectedDate : _selectedValidUntilDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)), // Allow past dates?
      lastDate: DateTime(2101),
      // Apply theme overrides for DatePicker
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: primaryColor, // Use theme primary
              onPrimary: Colors.white,
              onSurface: darkTextColor, // Text color in picker
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: primaryColor), // OK/Cancel buttons
            ),
            // Optional: Customize dialog background, etc.
            // datePickerTheme: theme.datePickerTheme.copyWith(...)
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
          // Ensure valid until is after start date
          if (_selectedValidUntilDate.isBefore(_selectedDate)) {
            _selectedValidUntilDate = _selectedDate.add(const Duration(days: 1));
            _validUntilController.text = _formatDate(_selectedValidUntilDate);
          }
        } else {
          // Ensure valid until is not before start date
          if (picked.isBefore(_selectedDate)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Valid until date cannot be before the order date.'),
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
    // Ensure customer is selected before adding items
    if (_selectedCustomer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a customer first.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    // Show the refactored Add Item Dialog
    showAddItemDialog(context, _selectedCustomer!);
  }

  void _saveDraft() {
    // Implement save draft logic
    print("Save Draft tapped");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Save Draft functionality not implemented.'), behavior: SnackBarBehavior.floating),
    );
  }

  void _submitOrder() {
    // Implement submit logic (validation, API call, etc.)
    print("Submit tapped");
    // --- Call the Success Dialog ---
    _showSuccessDialog(context);
  }


  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // Use theme background color (or surface if preferred for content area)
      backgroundColor: theme.colorScheme.background,
      appBar: _buildAppBar(context), // Uses AppBarTheme
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Form Fields ---
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
                    label: "Reference number",
                    controller: _referenceController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    context: context,
                    label: "Title",
                    controller: _titleController,
                    maxLength: 50, // Example maxLength
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    context: context,
                    label: "Shipping Address",
                    value: _selectedShippingAddress,
                    items: _addressItems,
                    onChanged: (v) => setState(() => _selectedShippingAddress = v),
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    context: context,
                    label: "Sales person",
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
                    onChanged: (v) => setState(() => _selectedContactPerson = v),
                  ),
                  // --- End Form Fields ---

                  const SizedBox(height: 32),
                  Text(
                    "Added items",
                    style: theme.textTheme.titleSmall, // Use theme style
                  ),
                  const SizedBox(height: 16),
                  // --- Item List Area (Placeholder) ---
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
                      "List is empty.", // TODO: Replace with actual item list
                      style: theme.textTheme.bodyLarge?.copyWith(color: mediumTextColor),
                    ),
                  ),
                  // --- End Item List Area ---
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Add Text Line not implemented.'), behavior: SnackBarBehavior.floating),
                          );
                        },
                        // Use theme style, override text if needed
                        child: const Text("ADD TEXT LINE"),
                      ),
                      TextButton(
                        onPressed: _addItem,
                        // Use theme style, override text if needed
                        child: const Text("ADD ITEMS"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80), // Space for bottom bar overlap
                ],
              ),
            ),
          ),
          _buildBottomBar(context), // Submit/Save buttons
        ],
      ),
    );
  }

  // --- AppBar Builder ---
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Uses AppBarTheme defined in app_theme.dart
    return AppBar(
      // backgroundColor, foregroundColor, elevation, titleTextStyle from theme
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Icon color from theme
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Column( // Keep Column for multi-line title
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('New order'), // Title style from theme
          Text(
            'revival', // Subtitle - consider using subtitle property of AppBar
            style: TextStyle( // Explicit style for subtitle
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      centerTitle: false, // From theme
      titleSpacing: 0, // Keep specific title spacing
    );
  }

  // --- Field Builders (Using Theme) ---

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
        Text(label, style: theme.textTheme.bodySmall), // Use theme label style
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          style: theme.textTheme.bodyMedium, // Use theme input text style
          decoration: kUnderlinedInputDecoration.copyWith( // Use specific underline style
             // hintText: label == "Title" ? null : label, // Hint can be set here
             counterText: maxLength != null ? null : '', // Hide default counter if needed
             counterStyle: theme.textTheme.bodySmall?.copyWith(fontSize: 10), // Style counter
             // No labelText needed as we have external label
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
          decoration: kUnderlinedInputDecoration.copyWith( // Use specific underline style
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: theme.iconTheme.color?.withOpacity(0.6), // Theme icon color
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
        // No SizedBox needed, DropdownButtonFormField has internal padding
        DropdownButtonFormField<String>(
          value: value,
          items: items.map<DropdownMenuItem<String>>((String itemValue) {
            return DropdownMenuItem<String>(
              value: itemValue,
              child: Text(itemValue, style: theme.textTheme.bodyMedium), // Style dropdown items
            );
          }).toList(),
          onChanged: onChanged,
          // Use specific underline style
          decoration: kUnderlinedInputDecoration.copyWith(
             hintText: "Select", // Add hint text here if needed
             // Dropdown icon is handled by the widget itself, but can be styled:
             // icon: Icon(Icons.arrow_drop_down, color: theme.iconTheme.color?.withOpacity(0.6)),
          ),
          dropdownColor: theme.cardColor, // Background color of the dropdown menu
          isExpanded: true,
          style: theme.textTheme.bodyMedium, // Style for the selected item display
          icon: Icon(Icons.arrow_drop_down, color: theme.iconTheme.color?.withOpacity(0.6)),
        ),
      ],
    );
  }
  // --- End Field Builders ---


  // --- Bottom Bar Builder ---
  Widget _buildBottomBar(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    // Placeholder total - replace with actual calculation
    const String estimatedTotal = "0.00 GBP";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: theme.cardColor, // Use card color for background
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1), // Use theme shadow
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, -2), // Shadow pointing upwards
          ),
        ],
        // Optional: Add top border
        // border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Total Row ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Estimated net total:",
                style: textTheme.bodyLarge?.copyWith(color: mediumTextColor), // Use theme style
              ),
              Row(
                children: [
                  Text(
                    estimatedTotal, // Use calculated total
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface, // Use theme text color
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      print("Refresh total tapped");
                      // Add logic to recalculate total
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Recalculate total not implemented.'), behavior: SnackBarBehavior.floating),
                      );
                    },
                    child: Icon(
                      Icons.refresh,
                      color: colorScheme.primary, // Use theme primary color
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // --- Buttons Row ---
          Row(
            children: [
              Expanded(
                // Save Draft Button using OutlinedButtonTheme
                child: OutlinedButton(
                  onPressed: _saveDraft,
                  // Style comes from theme
                  child: const Text("SAVE DRAFT"),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                // Submit Button using ElevatedButtonTheme
                child: ElevatedButton(
                  onPressed: _submitOrder,
                   // Style comes from theme
                  child: const Text("SUBMIT"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // --- End Bottom Bar ---


  // --- Success Dialog Builder ---
  Future<void> _showSuccessDialog(BuildContext buildContext) async {
    final theme = Theme.of(buildContext);
    final textTheme = theme.textTheme;

    // --- Placeholder Data (Replace with actual calculations) ---
    const String subtotal = "100.00 GBP";
    const String discount = "-10.00 GBP (10%)";
    const String vat = "+15.00 GBP (15%)";
    const String grandTotal = "105.00 GBP";
    // --- End Placeholder Data ---

    return showDialog<void>(
      context: buildContext,
      barrierDismissible: false, // User must tap button
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // Uses DialogTheme for background, shape, elevation
          contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 16.0), // Adjust padding
          titlePadding: const EdgeInsets.only(top: 24.0), // Padding for potential title
          // Optional Title:
          // title: Center(
          //   child: Text("Order Submitted", style: theme.dialogTheme.titleTextStyle)
          // ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 1. Success Icon
              Icon(
                Icons.check_circle,
                color: successColor, // Use theme constant
                size: 50.0,
              ),
              const SizedBox(height: 16.0),

              // 2. SUCCESS Title
              Text(
                "SUCCESS",
                style: textTheme.titleMedium?.copyWith( // Use appropriate text style
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),

              // 3. Main Message
              Text(
                "Thank you for your request.\nOrder submitted.",
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium, // Use theme style
              ),
              const SizedBox(height: 20.0),

              // 4. Invoice Summary Section
              Text(
                "Invoice Summary:",
                style: textTheme.titleSmall?.copyWith(color: mediumTextColor), // Use theme style
              ),
              const SizedBox(height: 8.0),
              // Use helper for consistent summary row styling
              _buildSummaryRow(context, 'Subtotal:', subtotal),
              _buildSummaryRow(context, 'Discount:', discount),
              _buildSummaryRow(context, 'VAT:', vat),
              const Divider(height: 20), // Uses DividerTheme
              _buildSummaryRow(context, 'Grand Total:', grandTotal, isBold: true),
              const SizedBox(height: 24.0), // Space before buttons
            ],
          ),
          // Actions section for the buttons
          actionsPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            Row(
              children: [
                // WhatsApp Button
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: const Text("WhatsApp"),
                    // Use specific success style, override background
                    style: kElevatedButtonSuccessStyle.copyWith(
                       backgroundColor: MaterialStateProperty.all(whatsappColor), // Use WhatsApp color
                    ),
                    onPressed: () {
                      print('WhatsApp UI Button Tapped');
                       ScaffoldMessenger.of(dialogContext).showSnackBar(
                        const SnackBar(content: Text('WhatsApp integration not implemented.'), behavior: SnackBarBehavior.floating),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // OK Button
                Expanded(
                  child: ElevatedButton(
                    // Use default ElevatedButton style from theme
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close the dialog
                      // Optionally navigate back further or refresh previous screen
                      // Navigator.of(buildContext).pop();
                    },
                     child: const Text("OK"),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Helper for Dialog Summary Rows
  Widget _buildSummaryRow(BuildContext context, String label, String value, {bool isBold = false}) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: textTheme.bodySmall),
          Text(
            value,
            style: (isBold ? textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold) : textTheme.bodyMedium)
                ?.copyWith(color: darkTextColor), // Ensure color contrast
          ),
        ],
      ),
    );
  }
  // --- End Success Dialog ---
}
