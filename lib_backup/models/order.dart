import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cart_item.dart';

// Rename the class to avoid conflict with Firebase Order
class AppOrder {
  final String id;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final List<CartItem> items;
  final double total;
  final String status;
  final DateTime createdAt;
  final String? notes;

  AppOrder({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    this.notes,
  });

  factory AppOrder.fromFirestore(Map<String, dynamic> data, String id) {
    List<CartItem> items = [];
    if (data['items'] != null) {
      items = (data['items'] as List).map((item) {
        return CartItem.fromMap(item as Map<String, dynamic>);
      }).toList();
    }

    return AppOrder(
      id: id,
      customerName: data['customerName'] ?? '',
      customerPhone: data['customerPhone'] ?? '',
      customerAddress: data['customerAddress'] ?? '',
      items: items,
      total: (data['total'] ?? 0).toDouble(),
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'notes': notes,
    };
  }

  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year} ${createdAt.hour}:${createdAt.minute.toString().padLeft(2, "0")}';
  }

  Color get statusColor {
    switch (status) {
      case 'pending': return Colors.orange;
      case 'processing': return Colors.blue;
      case 'shipped': return Colors.purple;
      case 'delivered': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }
}