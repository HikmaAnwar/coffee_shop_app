import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../models/cart_item.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(List<CartItem> items, double totalAmount, {String? notes}) {
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items), // Create a copy of the items list
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      notes: notes,
    );

    _orders.insert(0, order); // Add to beginning of list
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus status) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      final order = _orders[index];
      _orders[index] = Order(
        id: order.id,
        items: order.items,
        totalAmount: order.totalAmount,
        orderDate: order.orderDate,
        status: status,
        notes: order.notes,
      );
      notifyListeners();
    }
  }

  List<Order> getOrdersByStatus(OrderStatus status) {
    return _orders.where((order) => order.status == status).toList();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
