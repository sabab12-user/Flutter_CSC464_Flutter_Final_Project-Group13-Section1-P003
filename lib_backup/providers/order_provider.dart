import 'package:flutter/foundation.dart';
import '../services/firestore_service.dart';
import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<AppOrder> _orders = [];
  String _filterStatus = 'all';
  String _errorMessage = '';
  bool _isLoading = false;

  List<AppOrder> get orders {
    if (_filterStatus == 'all') {
      return _orders;
    }
    return _orders.where((order) => order.status == _filterStatus).toList();
  }

  String get filterStatus => _filterStatus;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  void loadOrders() {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    _firestoreService.getOrders().listen(
      (orders) {
        _orders = orders;
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

  Future<bool> placeOrder(AppOrder order) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    
    try {
      await _firestoreService.addOrder(order);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void setFilter(String status) {
    _filterStatus = status;
    notifyListeners();
  }

  Future<bool> updateOrderStatus(String orderId, String status) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      await _firestoreService.updateOrderStatus(orderId, status);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}