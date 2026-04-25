import 'package:flutter/foundation.dart';
import '../services/firestore_service.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<Product> _products = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void loadProducts() {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    _firestoreService.getProducts().listen(
      (products) {
        _products = products;
        _isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
