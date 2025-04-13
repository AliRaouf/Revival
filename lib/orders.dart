import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildBranding(context),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFF17405E),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(color: Colors.transparent),
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Open Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildBranding(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Image.network(
          width: MediaQuery.of(context).size.width * 0.45,
          'https://revival-me.com/new2/wp-content/uploads/2020/05/Revival-transparent.png',
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: const Color(0xFFF9FAFB),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            child: Column(
              children: [
                _buildCheckboxListItem('Header A', isChecked: true),
                _buildDivider(),
                _buildCheckboxListItem('Header B', isChecked: false),
                _buildDivider(),
                _buildCheckboxListItem('Header C', isChecked: false),
                _buildDivider(),
                _buildCheckboxListItem('Cell 1', isChecked: true),
                _buildDivider(),
                _buildCheckboxListItem('Cell 2', isChecked: false),
                _buildDivider(),
                _buildCheckboxListItem('Cell 3', isChecked: false),
              ],
            ),
          ),
          // Additional content can be added here
        ],
      ),
    );
  }

  Widget _buildCheckboxListItem(String title, {bool isChecked = false}) {
    return Container(
      color: Colors.white,
      height: 57,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildCheckbox(isChecked),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 13.6,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(bool isChecked) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: isChecked ? const Color(0xFF0075FF) : Colors.white,
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: isChecked ? const Color(0xFF0075FF) : const Color(0xFF767676),
          width: 1,
        ),
      ),
      child:
          isChecked
              ? const Icon(Icons.check, size: 16, color: Colors.white)
              : null,
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6));
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.small(
      shape: CircleBorder(),
      backgroundColor: const Color(0xFF17405E),
      elevation: 4,
      onPressed: () {},
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
