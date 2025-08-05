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

  // Add this factory method
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      coffee: Coffee.fromJson(json['coffee']),
      quantity: json['quantity'],
      size: json['size'],
      milk: json['milk'],
    );
  }
}
