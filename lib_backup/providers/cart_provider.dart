import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};
  int get itemCount => _items.length;
  int get totalQuantity => _items.values.fold(0, (sum, item) => sum + item.quantity);
  bool get isCartEmpty => _items.isEmpty;
  double get totalAmount => _items.values.fold(0, (sum, item) => sum + item.totalPrice);
  List<CartItem> get cartItemsList => _items.values.toList();

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      final current = _items[product.id]!;
      _items[product.id] = CartItem(
        productId: current.productId,
        name: current.name,
        quantity: current.quantity + 1,
        price: current.price,
        imageUrl: current.imageUrl,
      );
    } else {
      _items[product.id] = CartItem(
        productId: product.id,
        name: product.name,
        quantity: 1,
        price: product.price,
        imageUrl: product.imageUrl,
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      final current = _items[productId]!;
      _items[productId] = CartItem(
        productId: current.productId,
        name: current.name,
        quantity: current.quantity + 1,
        price: current.price,
        imageUrl: current.imageUrl,
      );
      notifyListeners();
    }
  }

  void decreaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      final current = _items[productId]!;
      if (current.quantity > 1) {
        _items[productId] = CartItem(
          productId: current.productId,
          name: current.name,
          quantity: current.quantity - 1,
          price: current.price,
          imageUrl: current.imageUrl,
        );
        notifyListeners();
      } else {
        removeItem(productId);
      }
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}