import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revival/features/order/presentation/views/widgets/add_items_dialogue.dart';
// No url_launcher needed for UI-only demo

// Define the colors from the blue/grey "Open Orders" screen & Green for Success
const Color primaryDarkBlue = Color(0xFF17405E); // Main dark blue
const Color successGreen = Color(0xFF28a745); // Standard success green color
const Color whatsappGreen = Color(0xFF25D366); // WhatsApp brand green
const Color lightGreyBackground = Color(0xFFF9FAFB);
const Color mediumGreyText = Color(0xFF6B7280);
const Color darkGreyText = Color(0xFF374151);
const Color lightBorderGrey = Color(0xFFD1D5DB);

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  // Controllers for text fields
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  // Controllers and initial values for dates
  late TextEditingController _dateController;
  late TextEditingController _validUntilController;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedValidUntilDate = DateTime.now().add(
    const Duration(days: 30),
  );

  // Variables to hold dropdown selections
  String? _selectedCustomer;
  String? _selectedShippingAddress;
  String? _selectedSalesPerson;
  String? _selectedContactPerson;

  // Dummy items for dropdowns
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
    _dateController = TextEditingController(
      text: DateFormat('MMM d, yyyy').format(_selectedDate),
    );
    _validUntilController = TextEditingController(
      text: DateFormat('MMM d, yyyy').format(_selectedValidUntilDate),
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

  // Function to show date picker
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _selectedDate : _selectedValidUntilDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryDarkBlue,
              onPrimary: Colors.white,
              onSurface: darkGreyText,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: primaryDarkBlue),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      // (Date update logic remains the same as before)
      setState(() {
        final formattedDate = DateFormat('MMM d, yyyy').format(picked);
        if (isStartDate) {
          _selectedDate = picked;
          _dateController.text = formattedDate;
          if (_selectedValidUntilDate.isBefore(_selectedDate)) {
            _selectedValidUntilDate = _selectedDate.add(
              const Duration(days: 1),
            );
            _validUntilController.text = DateFormat(
              'MMM d, yyyy',
            ).format(_selectedValidUntilDate);
          }
        } else {
          if (picked.isBefore(_selectedDate)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Valid until date cannot be before the order date.',
                ),
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

  @override
  Widget build(BuildContext context) {
    // (Build method structure remains the same - only change is in _buildBottomBar's submit action)
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- All Form Fields remain the same ---
                  _buildDropdownField(
                    label: "Customer",
                    value: _selectedCustomer,
                    items: _customerItems,
                    onChanged: (v) {
                      setState(() => _selectedCustomer = v);
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          label: "Date",
                          controller: _dateController,
                          onTap: () => _selectDate(context, true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDateField(
                          label: "Valid until",
                          controller: _validUntilController,
                          onTap: () => _selectDate(context, false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: "Reference number",
                    controller: _referenceController,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(label: "Title", controller: _titleController),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: "Shipping Address",
                    value: _selectedShippingAddress,
                    items: _addressItems,
                    onChanged: (v) {
                      setState(() => _selectedShippingAddress = v);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: "Sales person",
                    value: _selectedSalesPerson,
                    items: _salesPersonItems,
                    onChanged: (v) {
                      setState(() => _selectedSalesPerson = v);
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    label: "Contact Person",
                    value: _selectedContactPerson,
                    items: _contactPersonItems,
                    onChanged: (v) {
                      setState(() => _selectedContactPerson = v);
                    },
                  ),
                  // --- End Form Fields ---
                  const SizedBox(height: 32),
                  Text(
                    "Added items",
                    style: TextStyle(color: mediumGreyText, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 100),
                    alignment: Alignment.center,
                    child: const Text(
                      "List is empty.",
                      style: TextStyle(color: mediumGreyText, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "ADD TEXT LINE",
                          style: TextStyle(
                            color: primaryDarkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          showAddItemDialog(context, "Customer A");
                        },
                        child: const Text(
                          "ADD ITEMS",
                          style: TextStyle(
                            color: primaryDarkBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          _buildBottomBar(context), // Submit button here calls the new dialog
        ],
      ),
    );
  }

  // --- Helper Widgets (_buildTextField, _buildDateField, _buildDropdownField) remain exactly the same as the previous "color only" version ---
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: mediumGreyText, fontSize: 12)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          maxLength: maxLength,
          style: TextStyle(color: darkGreyText),
          decoration: InputDecoration(
            hintText: label == "Title" ? null : label,
            hintStyle: TextStyle(color: lightBorderGrey),
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            isDense: true,
            counterText:
                maxLength != null
                    ? '${controller.text.length}/$maxLength'
                    : null,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: lightBorderGrey),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: lightBorderGrey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: primaryDarkBlue, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: mediumGreyText, fontSize: 12)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          style: TextStyle(color: darkGreyText),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
            isDense: true,
            suffixIcon: const Icon(
              Icons.arrow_drop_down,
              color: mediumGreyText,
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: lightBorderGrey),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: lightBorderGrey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: primaryDarkBlue, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: mediumGreyText, fontSize: 12)),
        DropdownButtonFormField<String>(
          dropdownColor: Colors.grey[50],
          isDense: true,
          value: value,
          hint: const Text("Select", style: TextStyle(color: darkGreyText)),
          isExpanded: true,
          style: TextStyle(color: darkGreyText),
          icon: const Icon(Icons.arrow_drop_down, color: mediumGreyText),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            isDense: true,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: lightBorderGrey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: lightBorderGrey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryDarkBlue, width: 2),
            ),
          ),
          items:
              items.map<DropdownMenuItem<String>>((String itemValue) {
                return DropdownMenuItem<String>(
                  value: itemValue,
                  child: Text(itemValue),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
  // --- End Helper Widgets ---

  // Builds the bottom bar - Submit button now calls _showSuccessDialog
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Total Row remains the same
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Estimated net total:",
                style: TextStyle(fontSize: 16, color: mediumGreyText),
              ),
              Row(
                children: [
                  Text(
                    "0.00 GBP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkGreyText,
                    ),
                  ), // Placeholder Total
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      print("Refresh total tapped");
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: primaryDarkBlue,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Buttons Row
          Row(
            children: [
              Expanded(
                // Save Draft Button
                child: OutlinedButton(
                  onPressed: () {
                    print("Save Draft tapped");
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryDarkBlue,
                    side: const BorderSide(color: primaryDarkBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    "SAVE DRAFT",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                // Submit Button
                child: ElevatedButton(
                  onPressed: () {
                    // --- Call the new Success Dialog ---
                    _showSuccessDialog(context);
                    // --- End Call ---
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryDarkBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: 2,
                  ),
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- NEW SUCCESS DIALOG METHOD ---
  Future<void> _showSuccessDialog(BuildContext buildContext) async {
    // --- Placeholder Data for Totals (Replace with actual calculations) ---
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
          backgroundColor: Colors.white, // White background for the dialog
          shape: RoundedRectangleBorder(
            // Rounded corners like the image
            borderRadius: BorderRadius.circular(15.0),
          ),
          // Use Padding for content to control spacing
          contentPadding: const EdgeInsets.fromLTRB(
            24.0,
            20.0,
            24.0,
            0,
          ), // Less padding at bottom before actions
          content: Column(
            mainAxisSize: MainAxisSize.min, // Take only needed height
            children: <Widget>[
              // 1. Success Icon
              const Icon(
                Icons.check_circle,
                color: successGreen, // Use defined green color
                size: 50.0, // Adjust size as needed
              ),
              const SizedBox(height: 16.0),

              // 2. SUCCESS Title
              const Text(
                "SUCCESS",
                style: TextStyle(
                  color: successGreen, // Use defined green color
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),

              // 3. Main Message (from image, adapted)
              const Text(
                "Thank you for your request.\nOrder submitted.", // Simplified message
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkGreyText, // Use darker grey text
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 16.0),

              // 4. Invoice Summary Section
              const Text(
                "Invoice Summary:", // Section Title
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mediumGreyText,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 8.0),
              // Use const Text for static placeholder text
              const Text(
                'Subtotal:      $subtotal',
                style: TextStyle(fontSize: 13, color: darkGreyText),
              ),
              const Text(
                'Discount:     $discount',
                style: TextStyle(fontSize: 13, color: darkGreyText),
              ),
              const Text(
                'VAT:             $vat',
                style: TextStyle(fontSize: 13, color: darkGreyText),
              ),
              const Divider(height: 20, thickness: 1, color: lightBorderGrey),
              const Text(
                'Grand Total:  $grandTotal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: darkGreyText,
                ),
              ),
              const SizedBox(height: 24.0), // Space before buttons
            ],
          ),
          // Actions section for the buttons
          actionsPadding: const EdgeInsets.fromLTRB(
            16.0,
            0,
            16.0,
            16.0,
          ), // Padding around buttons
          actionsAlignment:
              MainAxisAlignment
                  .center, // Center buttons if row doesn't fill width
          actions: <Widget>[
            Row(
              // Use Row for 50/50 split
              children: [
                // WhatsApp Button (50% width)
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      size: 18,
                    ), // Generic chat icon
                    label: const Text("WhatsApp"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: whatsappGreen, // Specific WhatsApp green
                      foregroundColor: Colors.white, // White text
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      // UI Only - No action
                      print('WhatsApp UI Button Tapped');
                    },
                  ),
                ),
                const SizedBox(width: 10), // Space between buttons
                // OK Button (50% width)
                Expanded(
                  child: ElevatedButton(
                    child: const Text("OK"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDarkBlue, // Company scheme blue
                      foregroundColor: Colors.white, // White text
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close the dialog
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // AppBar remains the same as the previous version
    return AppBar(
      backgroundColor: primaryDarkBlue,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New order',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'revival',
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
}
