class Product {
  final String id;
  final String name;
  final double price;
  final String category;
  final String imageUrl;
  final String description;
  final double rating;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.description,
    this.rating = 4.5,
    this.stock = 10,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      rating: (data['rating'] ?? 4.5).toDouble(),
      stock: data['stock'] ?? 10,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'description': description,
      'rating': rating,
      'stock': stock,
    };
  }
}