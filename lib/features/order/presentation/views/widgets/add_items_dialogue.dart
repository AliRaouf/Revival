import 'package:flutter/material.dart';

const Color primaryDarkBlue = Color(0xFF17405E);

void showAddItemDialog(BuildContext context, String customerName) {
  final itemCode = TextEditingController();
  final desc = TextEditingController();
  final qty = TextEditingController();
  final unit = TextEditingController();
  final disc = TextEditingController();
  String total = '0.00', discounted = '0.00', whCode = 'WH-001';

  void calc() {
    final q = int.tryParse(qty.text) ?? 0;
    final u = double.tryParse(unit.text) ?? 0.0;
    final d = double.tryParse(disc.text) ?? 0.0;
    total = (q * u).toStringAsFixed(2);
    discounted = (q * u - d).toStringAsFixed(2);
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder:
        (_) => Dialog(
          backgroundColor: Color(0xFFF9FAFB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 80),
          child: FractionallySizedBox(
            widthFactor: MediaQuery.of(context).size.width < 500 ? 0.9 : 0.4,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      customerName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryDarkBlue,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Grid-like rows
                    ...[
                      _buildRow(
                        'Item Code',
                        _styledField(
                          label: 'Item Code',
                          controller: itemCode,
                          keyboardType: '', // example icon
                        ),
                      ),
                      _buildRow(
                        'Description',
                        _styledField(
                          label: 'Description',
                          controller: desc,
                          keyboardType: '',
                        ),
                      ),
                      _buildRow(
                        'Quantity',
                        _styledField(
                          label: 'Qty',
                          controller: qty,
                          onChanged: (_) => calc(),
                          keyboardType: 'number',
                        ),
                      ),
                      _buildRow(
                        'Unit Price',
                        _styledField(
                          label: 'Unit Price',
                          controller: unit,
                          onChanged: (_) => calc(),
                          keyboardType: 'number',
                        ),
                      ),
                      _buildRow(
                        'Description',
                        _styledField(
                          label: 'Discount',
                          controller: disc,
                          onChanged: (p0) => calc(),
                          keyboardType: 'number',
                        ),
                      ),
                      Divider(),
                      _rowDisplay('Total:', total),
                      _rowDisplay('After Discount:', discounted),
                      _rowDisplay('Warehouse:', whCode),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryDarkBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Add Item',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xffF9F9F9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
  );
}

Widget _buildRow(String label, Widget field) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 80,
            maxWidth: 120,
          ), // keeps spacing consistent
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: primaryDarkBlue,
            ),
          ),
        ),
        const SizedBox(width: 4), // space between label and field
        Expanded(child: field),
      ],
    ),
  );
}

Widget _rowDisplay(String label, String value) => Padding(
  padding: EdgeInsets.symmetric(vertical: 6),
  child: Row(
    children: [
      SizedBox(
        width: 120,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, color: primaryDarkBlue),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
    ],
  ),
);
Widget _styledField({
  required String keyboardType,
  required String label,
  required TextEditingController controller,
  bool readOnly = false,
  void Function(String)? onChanged,
}) {
  final field = TextField(
    style: TextStyle(fontSize: 16, color: Colors.black),
    keyboardType:
        keyboardType == 'number' ? TextInputType.number : TextInputType.text,
    controller: controller,
    readOnly: readOnly,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      filled: true, // filled bg
      fillColor:
          Colors.white, // soft background :contentReference[oaicite:7]{index=7}
      isDense: true, // compact height
      contentPadding: EdgeInsets.symmetric(
        // comfy padding :contentReference[oaicite:8]{index=8}
        horizontal: 12,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        // rounded outline :contentReference[oaicite:9]{index=9}
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );

  // add subtle elevation/shadow :contentReference[oaicite:11]{index=11}
  return Material(
    elevation: 2,
    shadowColor: Colors.black26,
    borderRadius: BorderRadius.circular(12),
    child: field,
  );
}
