import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order.dart';
import '../models/product.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get products stream
  Stream<List<Product>> getProducts() {
    return _firestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
              .toList();
        });
  }

  // Get orders stream - using AppOrder
  Stream<List<AppOrder>> getOrders() {
    return _firestore
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return AppOrder.fromFirestore(data, doc.id);
          }).toList();
        });
  }

  // Add order
  Future<void> addOrder(AppOrder order) async {
    try {
      await _firestore.collection('orders').add(order.toMap());
    } catch (e) {
      print('Error adding order: $e');
      throw e;
    }
  }

  // Update order status
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'status': status,
      });
    } catch (e) {
      print('Error updating order status: $e');
      throw e;
    }
  }
}