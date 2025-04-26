class OrderInfo {
  final String id;
  final String invoice;
  final String order;
  final String orderCode;
  final String quote;
  final String customerName;

  OrderInfo({
    required this.id,
    required this.invoice,
    required this.order,
    required this.orderCode,
    required this.quote,
    required this.customerName,
  });
}
class Item {
  final String itemCode;
  final String itemName;
  final int quantity;
  final double price;
  final double totalPrice;

  Item({
    required this.itemCode,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });
}