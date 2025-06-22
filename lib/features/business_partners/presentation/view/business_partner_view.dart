import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/ar_invoice/presentation/views/single_invoice.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/business_partner_textfield.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/dropdown.dart';
import 'package:revival/features/business_partners/presentation/view/widgets/save_partner_button.dart';
import 'package:revival/shared/utils.dart'; // Import easy_localization

class NewBusinessPartnerPage extends StatefulWidget {
  const NewBusinessPartnerPage({super.key});

  @override
  State<NewBusinessPartnerPage> createState() => _NewBusinessPartnerPageState();
}

class _NewBusinessPartnerPageState extends State<NewBusinessPartnerPage> {
  String? _selectedType;
  String? _selectedCurrency;
  String? _selectedPaymentTerms;
  String? _selectedPriceList;
  String? _selectedGroupNo;
  String? _selectedAddressId;
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
    final utilities = Utilities(context);

    return Scaffold(
      backgroundColor: utilities.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Create New Partner"),
        backgroundColor: utilities.colorScheme.primary,
        foregroundColor: utilities.colorScheme.onPrimary,
        titleTextStyle: utilities.textTheme.titleLarge?.copyWith(
          color: utilities.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2.0,
      ),
      body: Container(
        color: scaffoldBackgroundColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  context: context, // Pass context
                  title: "General Information", // Localize title
                  icon: Icons.business_center,
                  children: [
                    buildTextField(
                      context: context, // Pass context
                      label: "Code", // Localize label
                      controller: _codeController,
                      validator:
                          (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Code cannot be empty'
                                  : null,
                    ),
                    buildTextField(
                      context: context, // Pass context
                      label: "Name", // Localize label
                      controller: _nameController,
                      validator:
                          (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Name cannot be empty'
                                  // Localize validator message
                                  : null,
                    ),
                    BusinessPartnerDropdown(
                      context: context, // Pass context
                      label: "Type", // Localize label
                      hint: "Select Type", // Localize hint
                      value: _selectedType,
                      items: utilities.typeOptions,
                      onChanged:
                          (newValue) =>
                              setState(() => _selectedType = newValue),
                      validator:
                          (value) =>
                              value == null ? 'Please select a type' : null,
                      getLocalizedDropdownItems: _getLocalizedDropdownItems(
                        utilities.typeOptions,
                      ), // Localize validator message
                    ),
                    BusinessPartnerDropdown(
                      context: context, // Pass context
                      label: "Currency", // Localize label
                      hint: "Select Currency", // Localize hint
                      value: _selectedCurrency,
                      items: utilities.currencyOptions,
                      onChanged:
                          (newValue) =>
                              setState(() => _selectedCurrency = newValue),
                      validator:
                          (value) =>
                              value == null ? 'Please select a currency' : null,
                      getLocalizedDropdownItems: _getLocalizedDropdownItems(
                        utilities.currencyOptions,
                      ), // Localize validator message
                    ),
                    buildTextField(
                      context: context, // Pass context
                      label: "Mobile Phone", // Localize label
                      controller: _mobilePhoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    BusinessPartnerDropdown(
                      context: context, //
                      label: "Payment Terms",
                      hint: "Select Terms",
                      value: _selectedPaymentTerms,
                      items: utilities.paymentTermsOptions,
                      onChanged:
                          (newValue) =>
                              setState(() => _selectedPaymentTerms = newValue),
                      getLocalizedDropdownItems: _getLocalizedDropdownItems(
                        utilities.paymentTermsOptions,
                      ),
                    ),
                    BusinessPartnerDropdown(
                      context: context, // Pass context
                      label: "Price List", // Localize label
                      hint: "Select Price List", // Localize hint
                      value: _selectedPriceList,
                      items: utilities.priceListOptions,
                      onChanged:
                          (newValue) =>
                              setState(() => _selectedPriceList = newValue),
                      getLocalizedDropdownItems: _getLocalizedDropdownItems(
                        utilities.priceListOptions,
                      ),
                    ),
                  ],
                ),

                _buildSection(
                  context: context, // Pass context
                  title: "Group Information", // Localize title
                  icon: Icons.group_work,
                  children: [
                    BusinessPartnerDropdown(
                      context: context, // Pass context
                      label: "Group No.", // Localize label
                      hint: "Select Group Number", // Localize hint
                      value: _selectedGroupNo,
                      items: utilities.groupNoOptions,
                      onChanged:
                          (newValue) =>
                              setState(() => _selectedGroupNo = newValue),
                      getLocalizedDropdownItems: _getLocalizedDropdownItems(
                        utilities.groupNoOptions,
                      ),
                    ),
                    buildTextField(
                      context: context, // Pass context
                      label: "Group Name", // Localize label
                      controller: _groupNameController,
                    ),
                    buildTextField(
                      context: context, // Pass context
                      label: "Group Type", // Localize label
                      controller: _groupTypeController,
                    ),
                    buildTextField(
                      context: context, // Pass context
                      label: "GroupsCode", // Localize label
                      controller: _groupsCodeController,
                    ),
                  ],
                ),

                _buildSection(
                  context: context, // Pass context
                  title: "Address Information", // Localize title
                  icon: Icons.location_on,
                  children: [
                    BusinessPartnerDropdown(
                      context: context, // Pass context
                      label: "Address ID", // Localize label
                      hint: "Select Address ID", // Localize hint
                      value: _selectedAddressId,
                      items: utilities.addressIdOptions,
                      onChanged:
                          (newValue) =>
                              setState(() => _selectedAddressId = newValue),
                      getLocalizedDropdownItems: _getLocalizedDropdownItems(
                        utilities.addressIdOptions,
                      ),
                    ),
                    buildTextField(
                      context: context, // Pass context
                      label: "City", // Localize label
                      controller: _cityController,
                    ),
                    buildTextField(
                      context: context, // Pass context
                      label: "County", // Localize label
                      controller: _countyController,
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                SavePartnerButton(saveForm: _saveForm),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required BuildContext context, // Added context
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context); // Access theme
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Use theme's primary color for icon
              Icon(icon, color: colorScheme.primary, size: 22),
              const SizedBox(width: 10),
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary, // Use theme's primary color
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          // Use theme's divider color
          Divider(
            height: 20,
            thickness: 0.8,
            color: theme.dividerColor.withOpacity(
              0.7,
            ), // Use theme's divider color
          ),
          ...children,
        ],
      ),
    );
  } // Helper to localize dropdown items

  List<DropdownMenuItem<String>> _getLocalizedDropdownItems(
    List<String> items,
  ) {
    return items.map<DropdownMenuItem<String>>((String itemValue) {
      return DropdownMenuItem<String>(
        value: itemValue,
        // Localize the item text
        child: Text(itemValue, overflow: TextOverflow.ellipsis),
      );
    }).toList();
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with saving data
      // final code = _codeController.text;
      // final name = _nameController.text;
      // final mobile = _mobilePhoneController.text;
      // final groupName = _groupNameController.text;
      // final groupType = _groupTypeController.text;
      // final groupsCode = _groupsCodeController.text;
      // final city = _cityController.text;
      // final county = _countyController.text;
      SnackBar(
        // Localize snackbar message
        content: Text('Form Valid! Data logged to console.'),
        backgroundColor:
            Colors.green, // Consider using theme's success color if available
      );
    } else {
      // Form is invalid, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // Localize snackbar message
          content: Text('Please fix the errors in the form.'),
          backgroundColor:
              Theme.of(context).colorScheme.error, // Use theme's error color
        ),
      );
    }
  }
}
