class Order {
  final String id;
  final String orderCode;
  final String customerName;
  final String documentDate;
  final String deliveryDate;
  final List<Item> items;
  final String totalValue;
  Order({
    required this.id,
    required this.orderCode,
    required this.customerName,
    required this.documentDate,
    required this.deliveryDate,
    required this.items,
    required this.totalValue,
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