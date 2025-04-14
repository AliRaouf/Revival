import 'package:flutter/material.dart';
import 'package:revival/features/order/presentation/views/new_orders.dart';

class OpenOrdersScreen extends StatelessWidget {
  const OpenOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildBranding(context),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Container(
      color: const Color(0xFF17405E),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () => Navigator.pop(context),
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Open Orders',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 17 * textScale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildBranding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
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
          'https://revival-me.com/new2/wp-content/uploads/2020/05/Revival-transparent.png',
          width: screenWidth * 0.45,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: const Color(0xFFF9FAFB),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final padding = isTablet ? 24.0 : 16.0;

          return ListView(
            padding: EdgeInsets.all(padding),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 1,
                child: Column(
                  children: [
                    _buildCheckboxListItem(
                      context,
                      'Header A',
                      isChecked: true,
                    ),
                    _buildDivider(),
                    _buildCheckboxListItem(
                      context,
                      'Header B',
                      isChecked: false,
                    ),
                    _buildDivider(),
                    _buildCheckboxListItem(
                      context,
                      'Header C',
                      isChecked: false,
                    ),
                    _buildDivider(),
                    _buildCheckboxListItem(context, 'Cell 1', isChecked: true),
                    _buildDivider(),
                    _buildCheckboxListItem(context, 'Cell 2', isChecked: false),
                    _buildDivider(),
                    _buildCheckboxListItem(context, 'Cell 3', isChecked: false),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCheckboxListItem(
    BuildContext context,
    String title, {
    bool isChecked = false,
  }) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height * 0.07,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildCheckbox(isChecked),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14 * textScale,
                  color: const Color(0xFF1F2937),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(bool isChecked) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isChecked ? const Color(0xFF0075FF) : Colors.white,
        borderRadius: BorderRadius.circular(4),
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

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color(0xFF17405E),
      elevation: 4,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewOrderScreen()),
        );
      },
      child: const Icon(Icons.add, color: Colors.white, size: 32),
    );
  }
}
