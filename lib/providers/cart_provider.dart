import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/coffee.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addItem(
    Coffee coffee, {
    String size = 'Medium',
    String milk = 'Regular',
  }) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.coffee.id == coffee.id && item.size == size && item.milk == milk,
    );

    if (existingIndex >= 0) {
      _items[existingIndex] = CartItem(
        coffee: _items[existingIndex].coffee,
        quantity: _items[existingIndex].quantity + 1,
        size: _items[existingIndex].size,
        milk: _items[existingIndex].milk,
      );
    } else {
      _items.add(CartItem(coffee: coffee, quantity: 1, size: size, milk: milk));
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.coffee.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    final index = _items.indexWhere((item) => item.coffee.id == itemId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index] = CartItem(
          coffee: _items[index].coffee,
          quantity: quantity,
          size: _items[index].size,
          milk: _items[index].milk,
        );
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
