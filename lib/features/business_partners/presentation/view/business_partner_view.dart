import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF003366);
  static const Color accentColor = Color(0xFF004a99);
  static const Color cardBackgroundColor = Colors.white;
  static const Color backgroundColor = Color(0xFFF0F2F5);
  static const Color labelColor = Color(0xFF6c757d);
  static const Color textColor = Color(0xFF212529);
  static const Color subtleBorderColor = Color(0xFFced4da);
}

class NewBusinessPartnerPage extends StatefulWidget {
  const NewBusinessPartnerPage({super.key});

  @override
  State<NewBusinessPartnerPage> createState() => _NewBusinessPartnerPageState();
}

class _NewBusinessPartnerPageState extends State<NewBusinessPartnerPage> {
  final TextStyle _sectionTitleStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
    letterSpacing: 0.5,
  );

  String? _selectedType;
  String? _selectedCurrency;
  String? _selectedPaymentTerms;
  String? _selectedPriceList;
  String? _selectedGroupNo;
  String? _selectedAddressId;

  final List<String> _typeOptions = ['Customer', 'Supplier', 'Lead'];
  final List<String> _currencyOptions = [
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'CAD',
    'EGP',
  ];
  final List<String> _paymentTermsOptions = [
    'Net 30',
    'Net 60',
    'Due on Receipt',
    'Custom',
  ];
  final List<String> _priceListOptions = [
    'Retail Price List',
    'Wholesale Price List',
    'Distributor Price List',
  ];
  final List<String> _groupNoOptions = [
    'G001',
    'G002',
    'CUST-Domestic',
    'CUST-Intl',
  ];
  final List<String> _addressIdOptions = [
    'BILL_TO_MAIN',
    'SHIP_TO_WAREHOUSE',
    'HQ',
    'Branch-1',
  ];

  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _mobilePhoneController = TextEditingController();
  final _groupNameController = TextEditingController();
  final _groupTypeController = TextEditingController();
  final _groupsCodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _countyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Create New Partner"),

        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
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

                    validator:
                        (value) =>
                            (value == null || value.isEmpty)
                                ? 'Code cannot be empty'
                                : null,
                  ),
                  _buildTextField(
                    label: "Name",
                    controller: _nameController,
                    validator:
                        (value) =>
                            (value == null || value.isEmpty)
                                ? 'Name cannot be empty'
                                : null,
                  ),
                  _buildDropdownField(
                    label: "Type",
                    hint: "Select Type",
                    value: _selectedType,
                    items: _typeOptions,
                    onChanged:
                        (newValue) => setState(() => _selectedType = newValue),
                    validator:
                        (value) =>
                            value == null ? 'Please select a type' : null,
                  ),
                  _buildDropdownField(
                    label: "Currency",
                    hint: "Select Currency",
                    value: _selectedCurrency,
                    items: _currencyOptions,
                    onChanged:
                        (newValue) =>
                            setState(() => _selectedCurrency = newValue),
                    validator:
                        (value) =>
                            value == null ? 'Please select a currency' : null,
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
                    onChanged:
                        (newValue) =>
                            setState(() => _selectedPaymentTerms = newValue),
                  ),
                  _buildDropdownField(
                    label: "Price List",
                    hint: "Select Price List",
                    value: _selectedPriceList,
                    items: _priceListOptions,
                    onChanged:
                        (newValue) =>
                            setState(() => _selectedPriceList = newValue),
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
                    onChanged:
                        (newValue) =>
                            setState(() => _selectedGroupNo = newValue),
                  ),
                  _buildTextField(
                    label: "Group Name",
                    controller: _groupNameController,
                  ),
                  _buildTextField(
                    label: "Group Type",
                    controller: _groupTypeController,
                  ),
                  _buildTextField(
                    label: "GroupsCode",
                    controller: _groupsCodeController,
                  ),
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
                    onChanged:
                        (newValue) =>
                            setState(() => _selectedAddressId = newValue),
                  ),
                  _buildTextField(label: "City", controller: _cityController),
                  _buildTextField(
                    label: "County",
                    controller: _countyController,
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save_alt_outlined),
                  label: const Text("Save Partner"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 2.0,
                  ),
                  onPressed: _saveForm,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 22),
              const SizedBox(width: 10),
              Text(title, style: _sectionTitleStyle),
            ],
          ),

          Divider(
            height: 20,
            thickness: 0.8,
            color: AppColors.labelColor.withOpacity(0.3),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: AppColors.textColor, fontSize: 15),
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,

          labelStyle: const TextStyle(
            color: AppColors.labelColor,
            fontSize: 15,
          ),
          hintStyle: const TextStyle(color: AppColors.labelColor, fontSize: 15),

          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 12.0,
          ),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
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
          fillColor: AppColors.cardBackgroundColor,
        ),
      ),
    );
  }

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
        hint: Text(
          hint,
          style: const TextStyle(color: AppColors.labelColor, fontSize: 15),
        ),

        style: const TextStyle(color: AppColors.textColor, fontSize: 15),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,

          labelStyle: const TextStyle(
            color: AppColors.labelColor,
            fontSize: 15,
          ),

          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 12.0,
          ),

          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.subtleBorderColor),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
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
          fillColor: AppColors.cardBackgroundColor,
        ),
        items:
            items.map<DropdownMenuItem<String>>((String itemValue) {
              return DropdownMenuItem<String>(
                value: itemValue,
                child: Text(itemValue, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
        onChanged: onChanged,

        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.labelColor,
        ),
        dropdownColor: AppColors.cardBackgroundColor,
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final code = _codeController.text;
      final name = _nameController.text;
      final mobile = _mobilePhoneController.text;
      final groupName = _groupNameController.text;
      final groupType = _groupTypeController.text;
      final groupsCode = _groupsCodeController.text;
      final city = _cityController.text;
      final county = _countyController.text;

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

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form Valid! Data logged to console.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fix the errors in the form.'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }
}

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
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      cardTheme: CardTheme(
        elevation: 1.5,
        color: AppColors.cardBackgroundColor,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: AppColors.labelColor, fontSize: 15),
        hintStyle: const TextStyle(color: AppColors.labelColor, fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.subtleBorderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.subtleBorderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
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
        fillColor: AppColors.cardBackgroundColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: AppColors.textColor),
        labelSmall: TextStyle(color: AppColors.labelColor),
      ).apply(
        bodyColor: AppColors.textColor,
        displayColor: AppColors.textColor,
      ),
    );

    return MaterialApp(
      title: 'SAP B1 Create Partner',
      theme: theme,

      home: const NewBusinessPartnerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
