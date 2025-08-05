import 'coffee.dart';

class CartItem {
  final Coffee coffee;
  final int quantity;
  final String size;
  final String milk;
  final double totalPrice;

  CartItem({
    required this.coffee,
    required this.quantity,
    required this.size,
    required this.milk,
  }) : totalPrice = coffee.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'coffee': coffee,
      'quantity': quantity,
      'size': size,
      'milk': milk,
      'totalPrice': totalPrice,
    };
  }
}
