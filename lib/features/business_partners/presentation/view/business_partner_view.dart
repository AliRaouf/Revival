import 'package:flutter/material.dart';

class NewBusinessPartnerPage extends StatelessWidget {
  NewBusinessPartnerPage({super.key});

  final Color _primaryTextColor = Color(0xFF1C1C1C); // Dark, readable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create new business partner"),
        backgroundColor: const Color(0xFF17405E), // Blue-gray
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: DefaultTextStyle(
          style: TextStyle(color: _primaryTextColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownField("Organization", "2Demo"),
              _buildTextField("Card code"),
              _buildTextField("Name"),
              _buildTextField("Federal tax ID", counterText: "0/32"),
              _buildDropdownField("Default sales person", "Amr Khatab"),
              _buildDropdownField("Partner type", "Customer"),
              _buildTextField("Telephone number"),
              _buildTextField("Email address"),
              _buildTextField("Website"),
              _buildTextField("Notes"),
              const SizedBox(height: 16),
              Text(
                "Contact",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _primaryTextColor,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _buildTextField("First name")),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTextField("Last name")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {String? counterText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        style: const TextStyle(color: Color(0xFF1C1C1C)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1C1C1C)),
          border: const OutlineInputBorder(),
          counterText: counterText ?? '',
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1C1C1C)),
          border: const OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 16, color: Color(0xFF1C1C1C)),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1C1C1C)),
          ],
        ),
      ),
    );
  }
}
