class CartItem {
  final String productId;
  final String name;
  int quantity;
  final double price;
  final String imageUrl;

  CartItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 1,
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
