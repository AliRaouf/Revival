import 'package:flutter/material.dart';
// Import other necessary packages if any

// --- Define Theme Colors (Consistent with other pages) ---
// It's best practice to define these in a shared theme file or access via Theme.of(context)
// For simplicity in this example, defining them as static constants here.
class AppColors {
  static const Color primaryColor = Color(0xFF003366); // Dark Blue/Navy
  static const Color accentColor = Color(0xFF004a99); // Slightly lighter blue
  static const Color cardBackgroundColor = Colors.white;
  static const Color backgroundColor = Color(0xFFF0F2F5); // Light grey background
  static const Color labelColor = Color(0xFF6c757d); // Muted grey for labels
  static const Color textColor = Color(0xFF212529); // Dark text
  static const Color subtleBorderColor = Color(0xFFced4da); // Lighter border for inputs
}

// --- New Business Partner Page ---
class NewBusinessPartnerPage extends StatefulWidget {
  // Use const constructor
  const NewBusinessPartnerPage({super.key});

  @override
  State<NewBusinessPartnerPage> createState() => _NewBusinessPartnerPageState();
}

class _NewBusinessPartnerPageState extends State<NewBusinessPartnerPage> {

  // --- Section Title Style using Theme Colors ---
  // (Alternatively, define this in the main theme's TextTheme)
  final TextStyle _sectionTitleStyle = const TextStyle(
    fontSize: 17, // Slightly smaller for forms maybe
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor, // Use theme primary color
    letterSpacing: 0.5,
  );

  // --- State Variables for Dropdowns (Unchanged) ---
  String? _selectedType;
  String? _selectedCurrency;
  String? _selectedPaymentTerms;
  String? _selectedPriceList;
  String? _selectedGroupNo;
  String? _selectedAddressId;

  // --- Placeholder Dropdown Options (Unchanged) ---
  final List<String> _typeOptions = ['Customer', 'Supplier', 'Lead'];
  final List<String> _currencyOptions = ['USD', 'EUR', 'GBP', 'JPY', 'CAD', 'EGP']; // Added EGP
  final List<String> _paymentTermsOptions = ['Net 30', 'Net 60', 'Due on Receipt', 'Custom'];
  final List<String> _priceListOptions = ['Retail Price List', 'Wholesale Price List', 'Distributor Price List'];
  final List<String> _groupNoOptions = ['G001', 'G002', 'CUST-Domestic', 'CUST-Intl'];
  final List<String> _addressIdOptions = ['BILL_TO_MAIN', 'SHIP_TO_WAREHOUSE', 'HQ', 'Branch-1'];

  // --- Text Editing Controllers (MUST ADD THESE) ---
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobilePhoneController = TextEditingController();
  final _groupNameController = TextEditingController();
  final _groupTypeController = TextEditingController();
  final _groupsCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _countyController = TextEditingController();

  // --- Form Key for Validation (Recommended) ---
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _codeController.dispose();
    _nameController.dispose();
    _mobilePhoneController.dispose();
    _groupNameController.dispose();
    _groupTypeController.dispose();
    _groupsCodeController.dispose();
    _cityController.dispose();
    _countyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Access theme data if needed for deeper customization
    // final theme = Theme.of(context);

    return Scaffold(
      // Use theme background color
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Create New Partner"),
        // Use theme colors
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2.0, // Consistent elevation
      ),
      body: SingleChildScrollView(
        // Add more padding around the content
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form( // Wrap content in a Form for validation
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: "General Information",
                icon: Icons.business_center,
                children: [
                  _buildTextField(
                    label: "Code",
                    controller: _codeController,
                    // Example validator
                    validator: (value) => (value == null || value.isEmpty) ? 'Code cannot be empty' : null,
                  ),
                  _buildTextField(
                    label: "Name",
                    controller: _nameController,
                    validator: (value) => (value == null || value.isEmpty) ? 'Name cannot be empty' : null,
                  ),
                  _buildDropdownField(
                    label: "Type",
                    hint: "Select Type",
                    value: _selectedType,
                    items: _typeOptions,
                    onChanged: (newValue) => setState(() => _selectedType = newValue),
                    validator: (value) => value == null ? 'Please select a type' : null,
                  ),
                  _buildDropdownField(
                    label: "Currency",
                    hint: "Select Currency",
                    value: _selectedCurrency,
                    items: _currencyOptions,
                    onChanged: (newValue) => setState(() => _selectedCurrency = newValue),
                    validator: (value) => value == null ? 'Please select a currency' : null,
                  ),
                  _buildTextField(
                    label: "Mobile Phone",
                    controller: _mobilePhoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  _buildDropdownField(
                    label: "Payment Terms",
                    hint: "Select Terms",
                    value: _selectedPaymentTerms,
                    items: _paymentTermsOptions,
                    onChanged: (newValue) => setState(() => _selectedPaymentTerms = newValue),
                  ),
                  _buildDropdownField(
                    label: "Price List",
                    hint: "Select Price List",
                    value: _selectedPriceList,
                    items: _priceListOptions,
                    onChanged: (newValue) => setState(() => _selectedPriceList = newValue),
                  ),
                ],
              ),

              _buildSection(
                title: "Group Information",
                icon: Icons.group_work,
                children: [
                  _buildDropdownField(
                    label: "Group No.",
                    hint: "Select Group Number",
                    value: _selectedGroupNo,
                    items: _groupNoOptions,
                    onChanged: (newValue) => setState(() => _selectedGroupNo = newValue),
                  ),
                  _buildTextField(label: "Group Name", controller: _groupNameController),
                  _buildTextField(label: "Group Type", controller: _groupTypeController),
                  _buildTextField(label: "GroupsCode", controller: _groupsCodeController),
                ],
              ),

              _buildSection(
                title: "Address Information",
                icon: Icons.location_on,
                children: [
                  _buildDropdownField(
                    label: "Address ID",
                    hint: "Select Address ID",
                    value: _selectedAddressId,
                    items: _addressIdOptions,
                    onChanged: (newValue) => setState(() => _selectedAddressId = newValue),
                  ),
                  _buildTextField(label: "City", controller: _cityController),
                  _buildTextField(label: "County", controller: _countyController),
                ],
              ),

              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon( // Add icon to button
                  icon: const Icon(Icons.save_alt_outlined),
                  label: const Text("Save Partner"),
                  style: ElevatedButton.styleFrom(
                    // Use theme colors for button
                    backgroundColor: AppColors.accentColor, // Use accent for actions usually
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2.0, // Subtle elevation
                  ),
                  onPressed: _saveForm, // Call validation method
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets using Theme Colors ---

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0), // Slightly less bottom padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 22), // Use theme primary
              const SizedBox(width: 10),
              Text(title, style: _sectionTitleStyle),
            ],
          ),
          // Use a lighter divider
          Divider(height: 20, thickness: 0.8, color: AppColors.labelColor.withOpacity(0.3)),
          ...children,
        ],
      ),
    );
  }

  // Updated TextField helper using Theme Colors and Controller
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14), // Slightly less padding
      child: TextFormField( // Use TextFormField for validation
        controller: controller,
        style: const TextStyle(color: AppColors.textColor, fontSize: 15), // Use theme text color
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          // Use theme colors for label and borders
          labelStyle: const TextStyle(color: AppColors.labelColor, fontSize: 15),
          hintStyle: const TextStyle(color: AppColors.labelColor, fontSize: 15),
          // Use contentPadding for height control
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          // Consistent border styling using theme colors
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5), // Highlight with primary
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true, // Add fill for better contrast on grey background
          fillColor: AppColors.cardBackgroundColor, // White fill
        ),
      ),
    );
  }

  // Updated Dropdown helper using Theme Colors
  Widget _buildDropdownField({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        hint: Text(hint, style: const TextStyle(color: AppColors.labelColor, fontSize: 15)),
        // Use theme text color
        style: const TextStyle(color: AppColors.textColor, fontSize: 15),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          // Use theme colors for label and borders
          labelStyle: const TextStyle(color: AppColors.labelColor, fontSize: 15),
          // Use contentPadding for height control
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          // Consistent border styling using theme colors
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5), // Highlight with primary
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true, // Add fill for better contrast
          fillColor: AppColors.cardBackgroundColor, // White fill
        ),
        items: items.map<DropdownMenuItem<String>>((String itemValue) {
          return DropdownMenuItem<String>(
            value: itemValue,
            child: Text(itemValue, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: onChanged,
        // Use theme color for icon
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.labelColor),
        dropdownColor: AppColors.cardBackgroundColor, // Background of the options list
      ),
    );
  }

  // --- Form Save Logic ---
  void _saveForm() {
    // Validate the form
    if (_formKey.currentState?.validate() ?? false) {
      // If valid, proceed to gather data
      final code = _codeController.text;
      final name = _nameController.text;
      final mobile = _mobilePhoneController.text;
      final groupName = _groupNameController.text;
      final groupType = _groupTypeController.text;
      final groupsCode = _groupsCodeController.text;
      final city = _cityController.text;
      final county = _countyController.text;

      // --- Print Gathered Data (Replace with actual save API call) ---
      print("--- FORM VALID - Saving Business Partner ---");
      print("Code: $code");
      print("Name: $name");
      print("Type: $_selectedType");
      print("Currency: $_selectedCurrency");
      print("Mobile: $mobile");
      print("Payment Terms: $_selectedPaymentTerms");
      print("Price List: $_selectedPriceList");
      print("Group No: $_selectedGroupNo");
      print("Group Name: $groupName");
      print("Group Type: $groupType");
      print("GroupsCode: $groupsCode");
      print("Address ID: $_selectedAddressId");
      print("City: $city");
      print("County: $county");
      print("------------------------------------------");

      // --- Placeholder for API call ---
      // try { ... } catch (e) { ... }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form Valid! Data logged to console.'),
          backgroundColor: Colors.green,
        ),
      );
      // Optional: Navigate back after successful save
      // Navigator.pop(context);

    } else {
      // Form is invalid, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fix the errors in the form.'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }
}

// --- Main App Setup (Assuming it provides the Theme) ---
// You would have your MyApp class here, similar to previous examples,
// ensuring it defines the necessary themes (InputDecorationTheme, etc.)
// that match AppColors.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          primary: AppColors.primaryColor,
          secondary: AppColors.accentColor,
          background: AppColors.backgroundColor,
          onBackground: AppColors.textColor,
          surface: AppColors.cardBackgroundColor,
          onSurface: AppColors.textColor,
          error: Colors.red.shade700,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 2.0,
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme( // You might not use cards directly here, but good to define
          elevation: 1.5,
          color: AppColors.cardBackgroundColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        // --- CRUCIAL: Define Input Decoration Theme ---
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: AppColors.labelColor, fontSize: 15),
          hintStyle: const TextStyle(color: AppColors.labelColor, fontSize: 15),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          filled: true,
          fillColor: AppColors.cardBackgroundColor, // Default fill color for inputs
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor, // Default button uses accent
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Consistent padding
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16) // Consistent text style
            )
        ),
        textTheme: const TextTheme( // Define base text styles if needed
          bodyMedium: TextStyle(color: AppColors.textColor),
          labelSmall: TextStyle(color: AppColors.labelColor),
        ).apply(
          bodyColor: AppColors.textColor,
          displayColor: AppColors.textColor,
        )
    );

    return MaterialApp(
      title: 'SAP B1 Create Partner',
      theme: theme,
      // You might navigate here from another screen, e.g., the FAB on the list page
      home: const NewBusinessPartnerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}