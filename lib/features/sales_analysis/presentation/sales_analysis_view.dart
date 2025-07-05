import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/core/utils/toast_utils.dart';
import 'package:revival/features/ar_invoice/presentation/views/single_invoice.dart';
import 'package:revival/features/sales_analysis/presentation/widgets/sales_analysis_table.dart';
import 'package:revival/shared/utils.dart';

class SalesAnalysisView extends StatefulWidget {
  const SalesAnalysisView({super.key});

  @override
  State<SalesAnalysisView> createState() => _SalesAnalysisViewState();
}

class _SalesAnalysisViewState extends State<SalesAnalysisView> {
  @override
  Widget build(BuildContext context) {
    final utilities = Utilities(context);
    final stDateController = TextEditingController();
    final endDateController = TextEditingController();
    final customerController = TextEditingController();
    Future<void> _onRefresh() async {
      ToastUtils.showInfoToast(context, 'Refresh button tapped!');
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () => _onRefresh(),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => context.push('/dashboard'),
        ),
        title: const Text('Sales Analysis'),
      ),

      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Container(
          height: double.infinity,
          color: scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: utilities.vSpace(1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 4,
                        child: TextField(
                          controller: stDateController,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 2),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 14),
                              ),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                stDateController.text = DateFormat()
                                    .add_yMd()
                                    .format(selectedDate);
                              }
                            });
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Start Date',
                            hintText: DateFormat().add_yMd().format(
                              DateTime.now().subtract(const Duration(days: 2)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      Flexible(flex: 1, child: Text("To")),
                      Flexible(
                        flex: 4,
                        child: TextField(
                          controller: endDateController,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2025),
                              lastDate: DateTime(2026),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                endDateController.text = DateFormat()
                                    .add_yMd()
                                    .format(selectedDate);
                              }
                            });
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'End Date',
                            hintText: DateFormat().add_yMd().format(
                              DateTime.now(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: utilities.vSpace(1)),
                  TextField(
                    controller: customerController,
                    decoration: koutlineInputDecoration.copyWith(
                      labelText: 'CustomerName',
                      hintText: 'CustomerName',
                      prefixIcon: const Icon(Icons.search, color: primaryColor),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          customerController.clear();
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: utilities.vSpace(1)),
                  SalesAnalysisTable(entries: utilities.fakeSalesData),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
