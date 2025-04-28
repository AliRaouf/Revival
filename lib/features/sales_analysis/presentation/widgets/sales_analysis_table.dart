// lib/widgets/sales_analysis_table.dart (or your preferred location)
import 'package:flutter/material.dart';
// Ensure these imports point to the correct locations in your project
import 'package:revival/features/sales_analysis/domain/entity/sales_entry.dart';
import 'package:revival/features/sales_analysis/presentation/widgets/sales_analysis_table_row.dart';

class SalesAnalysisTable extends StatelessWidget {
  final List<SalesEntry> entries;

  const SalesAnalysisTable({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    // Use a Column to place the Header above the list of rows
    return Column(
      // *** REMOVED mainAxisSize: MainAxisSize.min HERE ***
      children: [
        _buildHeaderRow(), // Add the header row
        const SizedBox(height: 8), // Space between header and first data row
        // Column containing the mapped rows
        Column(
          children:
              entries.map((entry) {
                // Create a SalesAnalysisTableRow for each entry
                return SalesAnalysisTableRow(
                  key: ValueKey(entry.number),
                  number: entry.number,
                  date: entry.date,
                  paymentMethod: entry.paymentMethod,
                  items: entry.items,
                  discount: entry.discount,
                  total: entry.total,
                );
              }).toList(), // Convert the mapped Iterable to a List of Widgets
        ),
      ],
    );
  }

  // Helper widget to build the static header row - Remains the same
  Widget _buildHeaderRow() {
    // Mimics the structure of the data row for alignment
    return Container(
  width: double.infinity, // ensure full width
  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(8.0),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center, // make sure items don't squeeze
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(flex: 1, child: _buildHeaderColumn('No')),        // changed to Expanded
      Expanded(flex: 2, child: _buildHeaderColumn('Date')),
      Expanded(flex: 4, child: _buildHeaderColumn('Payment Method')),
      Expanded(flex: 2, child: _buildHeaderColumn('Items')),
      Expanded(flex: 2, child: _buildHeaderColumn('Discount')),
      Expanded(flex: 3, child: _buildHeaderColumn('Total')),
    ],
  ),
); }

  // Specific helper for header columns for clarity and distinct styling - Remains the same
  Widget _buildHeaderColumn(String header) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: Align(
      alignment: Alignment.centerLeft, // <-- Add Align
      child: Text(
        header,
        textAlign: TextAlign.left, // <-- changed from center
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade700,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
}