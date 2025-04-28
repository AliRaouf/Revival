class SalesEntry {
  final int number;
  final DateTime date;
  final String paymentMethod;
  final List<String> items;
  final double discount;
  final double total;

  SalesEntry({
    required this.number,
    required this.date,
    required this.paymentMethod,
    required this.items,
    required this.discount,
    required this.total,
  });
}