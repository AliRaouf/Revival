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
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      // Row structure remains similar, ensure flex factors match the header
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Match header alignment
        // Change crossAxisAlignment to baseline
        crossAxisAlignment: CrossAxisAlignment.start, // <-- CHANGED
        textBaseline:
            TextBaseline
                .alphabetic, // <-- ADDED (Required for baseline alignment)
        children: [
          // Use the same flex factors as the header for alignment
          // Wrap the content in _buildColumn helper for consistent padding/styling
          Flexible(flex: 1, child: _buildColumn(Text(number.toString()))),
          Flexible(
            flex: 3,
            child: _buildColumn(Text(DateFormat.Md().format(date))),
          ), // Adjust date format if needed
          Flexible(flex: 3, child: _buildColumn(Text(paymentMethod))),
          Flexible(
            flex: 2,
            // The button might need alignment adjustment depending on its internal baseline
            // If the button looks misaligned, you might wrap _buildColumn's child:
            // child: Baseline(baseline: YOUR_VALUE, baselineType: TextBaseline.alphabetic, child: TextButton(...))
            child: _buildColumn(
              TextButton(
                onPressed: () => _showItemsDialog(context),
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 6,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.center,
                  textStyle: const TextStyle(
                    fontSize: 12,
                  ), // Ensure button text size is consistent
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: const Text('Show'),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: _buildColumn(Text('${discount.toStringAsFixed(0)}%')),
          ),
          Flexible(
            flex: 3,
            child: _buildColumn(Text(total.toStringAsFixed(1))),
          ), // Adjust total format if needed
        ],
      ),
    );
  }

  // Helper method adjusted to remove optional header parameter as it's not used here
  Widget _buildColumn(Widget dataWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ), // Keep consistent padding
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 12, color: Colors.black87),
        // Change alignment to start (left for LTR languages)
        textAlign: TextAlign.start, // <-- CHANGED
        child: dataWidget,
      ),
    );
  }
}
