// lib/widgets/sales_analysis_table_row.dart (or your preferred location)
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart'; // Assuming primaryColor/backgroundColor are here
// Removed import for single_invoice - not used here

class SalesAnalysisTableRow extends StatelessWidget {
  final int number;
  final DateTime date;
  final String paymentMethod;
  final List<String> items; // List of items for the dialog
  final double discount;
  final double total;

  const SalesAnalysisTableRow({
    super.key,
    required this.number,
    required this.date,
    required this.paymentMethod,
    required this.items,
    required this.discount,
    required this.total,
  });

  // Function to show the items dialog
  void _showItemsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Items'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(items[index]));
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This Container defines the look of a single row
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0), // Increased vertical padding slightly
      margin: const EdgeInsets.only(bottom: 8.0), // Add space between rows
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0), // Add rounded corners to each row container
        border: Border.all(color: Colors.grey.shade200, width: 1.0), // Subtle border
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(flex: 1, child: _buildColumn(null, Text(number.toString()))),
    Expanded(flex: 2, child: _buildColumn(null, Text(DateFormat.Md().format(date)))),
    Expanded(flex: 4, child: _buildColumn(null, Text(paymentMethod))),
    Expanded(
      flex: 2,
      child: _buildColumn(
        null,
         TextButton(
                onPressed: () => _showItemsDialog(context),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor, // Use theme color
                  foregroundColor: Colors.white, // Text color for the button
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                  textStyle: const TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder( // Rounded corners for the button
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: const Text('Show'),
              ),  
      ),
    ),
    Expanded(flex: 2, child: _buildColumn(null, Text('${discount.toStringAsFixed(0)}%'))),
    Expanded(flex: 3, child: _buildColumn(null, Text(total.toStringAsFixed(1)))),
  ],
)

    );
  }

  // Helper method to build each data cell within a column
  // Header text is now optional
  Widget _buildColumn(String? header, Widget dataWidget) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // <-- changed from center
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (header != null) ...[
          Text(
            header,
            textAlign: TextAlign.left, // <-- changed from center
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),
        ],
        DefaultTextStyle(
          style: const TextStyle(fontSize: 12, color: Colors.black87),
          child: Align(
            alignment: Alignment.centerLeft, // <-- add Align wrapper
            child: dataWidget,
          ),
        ),
      ],
    ),
  );
}
}