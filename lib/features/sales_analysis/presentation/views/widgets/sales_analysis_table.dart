// views/widgets/sales_analysis_table.dart
import 'package:flutter/material.dart';
// Ensure these imports point to the correct locations in your project
import 'package:revival/features/sales_analysis/domain/entity/sales_entry.dart';
import 'package:revival/features/sales_analysis/presentation/views/widgets/sales_analysis_table_row.dart';

class SalesAnalysisTable extends StatelessWidget {
  final List<SalesEntry> entries;

  const SalesAnalysisTable({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    // Wrap the Column with a Container to add borders
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade400,
            width: 1.0,
          ), // Top border
          bottom: BorderSide(
            color: Colors.grey.shade400,
            width: 1.0,
          ), // Bottom border
        ),
      ),
      child: Column(
        children: [
          _buildHeaderRow(), // Add the header row
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade400,
          ), // Divider below header
          // Use ListView.separated for dividers between rows
          ListView.separated(
            shrinkWrap:
                true, // Important to prevent infinite height error in Column
            physics:
                NeverScrollableScrollPhysics(), // Disable scrolling if it's inside another scroll view
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
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
            },
            separatorBuilder:
                (context, index) => Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey.shade300,
                ), // Optional divider between rows
          ),
          // If you don't use ListView.separated, you can map like before but might need explicit dividers
          /*
          Column(
            children: entries.map((entry) {
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
            }).toList(),
          ),
          */
        ],
      ),
    );
  }

  // Helper widget to build the static header row
  Widget _buildHeaderRow() {
    // Mimics the structure of the data row for alignment
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline, // <-- ADDED
        // Change crossAxisAlignment to baseline
        textBaseline:
            TextBaseline
                .alphabetic, // <-- ADDED (Required for baseline alignment)
        children: [
          // Use the same flex factors as the data rows
          Flexible(flex: 1, child: _buildHeaderColumn('No')),
          Flexible(flex: 2, child: _buildHeaderColumn('Date')),
          Flexible(flex: 4, child: _buildHeaderColumn('Payment')),
          Flexible(flex: 2, child: _buildHeaderColumn('Items')),
          Flexible(flex: 3, child: _buildHeaderColumn('Discount')),
          Flexible(flex: 3, child: _buildHeaderColumn('Total')),
        ],
      ),
    );
  }

  // Specific helper for header columns
  Widget _buildHeaderColumn(String header) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: Text(
        header,
        // Change alignment to start (left for LTR languages)
        textAlign: TextAlign.start, // <-- CHANGED
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
