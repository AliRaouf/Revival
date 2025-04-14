import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final screenHeight = mq.size.height;
    final textScale = mq.textScaleFactor;
    final isTablet = screenWidth > 600;
    const double bottomSheetHeight = 100;

    TextEditingController nameController = TextEditingController();
    TextEditingController dateController = TextEditingController(
      text: DateFormat("yyyy-MM-dd").format(DateTime.now()),
    );

    return Scaffold(
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            top: BorderSide(color: Color(0xFF17405E), width: 4),
            bottom: BorderSide.none,
            left: BorderSide.none,
            right: BorderSide.none,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        width: screenWidth,
        height: bottomSheetHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "VAT : 10%",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 12 * textScale,
                color: Color(0xff4B5563),
              ),
            ),
            Text(
              "Discounted Amount : 500 EGP",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 12 * textScale,
                color: Color(0xff4B5563),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Grand Total : 1,000,000 EGP",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 16 * textScale,
                color: Color(0xff17405E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xFFF9FAFB),
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    0,
                    16,
                    bottomSheetHeight + 16,
                  ),
                  child: Column(
                    children: [
                      // Client Info Card
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFF3F4F6),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isTablet ? 20 : 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Client Name",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xFF374151),
                                      fontSize: 15.3 * textScale,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFD1D5DB),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Text(
                                    "Order Date",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xFF374151),
                                      fontSize: 15.3 * textScale,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                controller: dateController,
                                readOnly: true,
                                onTap: () async {
                                  final DateTime? pickedDate =
                                      await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2026),
                                      );
                                  if (pickedDate != null) {
                                    final formattedDate = DateFormat(
                                      'd/M/yyyy',
                                    ).format(pickedDate);
                                    dateController.text = formattedDate;
                                  }
                                },
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: Color(0xff17405E),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFD1D5DB),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Items Section
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isTablet ? 20 : 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Items",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.copyWith(
                                      color: const Color(0xFF17405E),
                                      fontSize: 15.3 * textScale,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              // List of item containers
                              ...List.generate(7, (_) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: ItemContainer(
                                    screenWidth: screenWidth,
                                    textScale: textScale,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }
}

class ItemContainer extends StatelessWidget {
  const ItemContainer({
    super.key,
    required this.screenWidth,
    required this.textScale,
  });

  final double screenWidth;
  final double textScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      decoration: ShapeDecoration(
        color: const Color(0xFFF9FAFB),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFF3F4F6)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Orange Juice Suntop",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF17405E),
                    fontSize: 15.3 * textScale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xff17405E),
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
            Text(
              "0033x",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff4B5563),
                fontFamily: "Inter",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B5563),
                          fontFamily: "Inter",
                        ),
                      ),
                      Text(
                        "100",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        "Unit Price",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B5563),
                          fontFamily: "Inter",
                        ),
                      ),
                      Text(
                        "15.00 EGP",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Text(
                        "Discount",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff4B5563),
                          fontFamily: "Inter",
                        ),
                      ),
                      Text(
                        "20%",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xff000000),
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Text(
                  "Total : ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff4B5563),
                    fontFamily: "Inter",
                  ),
                ),
                Text(
                  "150.00 EGP",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff000000),
                    fontFamily: "Inter",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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

Widget _buildHeader(BuildContext context) {
  final textScale = MediaQuery.of(context).textScaleFactor;
  return Container(
    color: const Color(0xFF17405E),
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
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
                child: Icon(Icons.arrow_back, color: Colors.white, size: 24),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Create Order',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontSize: 17 * textScale,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(right: 16),
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
