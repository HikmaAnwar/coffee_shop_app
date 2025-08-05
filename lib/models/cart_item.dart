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

  factory CartItem.fromJson(Map<String, dynamic> json) {
    // Handle the case where coffee might be a Map or already a Coffee object
    Coffee coffee;
    if (json['coffee'] is Map<String, dynamic>) {
      coffee = Coffee.fromJson(json['coffee']);
    } else {
      coffee = json['coffee'] as Coffee;
    }

    return CartItem(
      coffee: coffee,
      quantity: json['quantity'] ?? 1,
      size: json['size'] ?? 'Medium',
      milk: json['milk'] ?? 'Regular',
    );
  }
}
