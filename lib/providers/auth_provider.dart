import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    setLoading(true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Mock login - in real app, this would be an API call
    if (email == 'test@example.com' && password == 'password') {
      _currentUser = User(
        id: '1',
        name: 'John Doe',
        email: email,
        profileImage:
            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
        favoriteCoffeeIds: ['1', '3'],
      );
      setLoading(false);
      return true;
    }

    setLoading(false);
    return false;
  }

  Future<bool> signup(String name, String email, String password) async {
    setLoading(true);

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Mock signup - in real app, this would be an API call
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      favoriteCoffeeIds: [],
    );

    setLoading(false);
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void toggleFavorite(String coffeeId) {
    if (_currentUser == null) return;

    final favorites = List<String>.from(_currentUser!.favoriteCoffeeIds);
    if (favorites.contains(coffeeId)) {
      favorites.remove(coffeeId);
    } else {
      favorites.add(coffeeId);
    }

    _currentUser = _currentUser!.copyWith(favoriteCoffeeIds: favorites);
    notifyListeners();
  }

  bool isFavorite(String coffeeId) {
    return _currentUser?.favoriteCoffeeIds.contains(coffeeId) ?? false;
  }
}
