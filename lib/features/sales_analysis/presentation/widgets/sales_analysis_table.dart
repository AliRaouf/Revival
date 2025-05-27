// lib/features/sales_analysis/presentation/widgets/sales_analysis_table.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart'; // Your theme file
import 'package:revival/features/sales_analysis/domain/entity/sales_entry.dart';

class SalesAnalysisTable extends StatelessWidget {
  final List<SalesEntry> entries;

  const SalesAnalysisTable({super.key, required this.entries});

  // Define column widths.
  // Using a mix of FlexColumnWidth for responsiveness and IntrinsicColumnWidth for the button.
  static const Map<int, TableColumnWidth> _columnWidths = {
    0: FlexColumnWidth(1.0), // No
    1: FlexColumnWidth(2.0), // Date
    2: FlexColumnWidth(3.5), // Payment Method
    3: IntrinsicColumnWidth(), // Items (button) - sizes to content
    4: FlexColumnWidth(2.5), // Discount
    5: FlexColumnWidth(2.5), // Total
  };

  // Helper to show the items dialog (adapted from SalesAnalysisTableRow)
  void _showItemsDialog(BuildContext context, List<String> items, ThemeData theme) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Items'.tr()),
          content: SizedBox(
            width: double.maxFinite, // Use available width
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index], style: theme.textTheme.bodyMedium),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'.tr()),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDialogBorderRadius), // From your theme
          ),
        );
      },
    );
  }

  // Helper to build styled header cells
  Widget _buildHeaderCell(String text, ThemeData theme, {TextAlign textAlign = TextAlign.start}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12.0),
      child: Text(
        text,
        textAlign: textAlign,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface.withOpacity(0.8),
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // Helper to build styled data cells
  Widget _buildDataCell(Widget child, ThemeData theme, {TextAlign textAlign = TextAlign.start, TableCellVerticalAlignment verticalAlignment = TableCellVerticalAlignment.middle}) {
    return TableCell(
      verticalAlignment: verticalAlignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
        child: DefaultTextStyle(
          style: theme.textTheme.bodyMedium ?? const TextStyle(),
          textAlign: textAlign,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (entries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No sales data available.'.tr(), // Or your preferred empty state message
            style: theme.textTheme.titleMedium,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: theme.dividerColor, width: 1.0),
          // bottom: BorderSide(color: theme.dividerColor, width: 1.0), // Keep if you want bottom border for the whole table
        ),
      ),
      child: Table(
        columnWidths: _columnWidths,
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder(
          horizontalInside: BorderSide(color: theme.dividerColor.withOpacity(0.5), width: 0.5),
          // verticalInside: BorderSide(color: theme.dividerColor.withOpacity(0.5), width: 0.5), // Optional: for vertical cell borders
        ),
        children: [
          // Header Row
          TableRow(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3), // Subtle header background
            ),
            children: [
              _buildHeaderCell('No'.tr(), theme),
              _buildHeaderCell('Date'.tr(), theme),
              _buildHeaderCell('Payment Method'.tr(), theme),
              _buildHeaderCell('Items'.tr(), theme, textAlign: TextAlign.center), // Center align header for button column
              _buildHeaderCell('Discount'.tr(), theme, textAlign: TextAlign.end), // Align numeric headers to end
              _buildHeaderCell('Total'.tr(), theme, textAlign: TextAlign.end), // Align numeric headers to end
            ],
          ),
          // Data Rows
          ...entries.map((entry) {
            return TableRow(
              key: ValueKey(entry.number),
              children: [
                _buildDataCell(Text(entry.number.toString()), theme),
                _buildDataCell(Text(DateFormat.Md(context.locale.toString()).format(entry.date)), theme), // Localized date format
                _buildDataCell(
                  Text(entry.paymentMethod, overflow: TextOverflow.ellipsis),
                  theme,
                ),
                _buildDataCell(
                  Center( // Center the button in its cell
                    child: TextButton(
                      onPressed: () => _showItemsDialog(context, entry.items, theme),
                      style: TextButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.center,
                        textStyle: theme.textTheme.labelSmall?.copyWith(fontSize: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kDefaultBorderRadius / 2),
                        ),
                      ),
                      child: Text('Show'.tr()),
                    ),
                  ),
                  theme,
                ),
                _buildDataCell(
                  Text('${entry.discount.toStringAsFixed(0)}%'),
                  theme,
                  textAlign: TextAlign.center, // Align numeric data to end
                ),
                _buildDataCell(
                  Text(
                    entry.total.toStringAsFixed(context.locale.languageCode == 'ar' ? 1 : 2), // Adjust precision based on locale
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  theme,
                  textAlign: TextAlign.end, // Align numeric data to end
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}