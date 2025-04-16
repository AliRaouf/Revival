import 'package:flutter/material.dart';
import 'package:revival/features/order/presentation/views/new_orders.dart';
import 'package:revival/features/order/presentation/views/single_order.dart';

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
              OrderSummaryWidget(
                invoice: "100000",
                order: "500",
                orderCode: "20211",
                quote: "1000",
                customerName: "Ahmed Khaled",
              ),
              OrderSummaryWidget(
                invoice: "100000",
                order: "500",
                orderCode: "20211",
                quote: "1000",
                customerName: "Ahmed Khaled",
              ),
              OrderSummaryWidget(
                invoice: "100000",
                order: "500",
                orderCode: "20211",
                quote: "1000",
                customerName: "Ahmed Khaled",
              ),
              OrderSummaryWidget(
                invoice: "100000",
                order: "500",
                orderCode: "20211",
                quote: "1000",
                customerName: "Ahmed Khaled",
              ),
            ],
          );
        },
      ),
    );
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
