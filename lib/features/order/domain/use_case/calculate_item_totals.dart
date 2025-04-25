class CalculateItemTotals {
final int quantity;
final double price;
final double discount;

CalculateItemTotals({
  required this.quantity,
  required this.price,
  required this.discount,
});
  
  double calculateCurrentTotal() {
  return quantity * price;
  }

  double calculateCurrentDiscountedTotal() {
  return calculateCurrentTotal() - discount;
  }
}
