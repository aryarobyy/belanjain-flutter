class ProductModel {
  final String productId;
  final String title;
  final String imageUrl;
  final String desc;
  final String category;
  final double price;

  ProductModel({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.desc,
    required this.category,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['id']?.toString() ?? "",
      title: json['title'] ?? "",
      imageUrl: json['image'] ?? "",
      desc: json['desc'] ?? "",
      category: json['category'] ?? "",
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'title': title,
      'image': imageUrl,
      'desc': desc,
      'category': category,
      'price': price,
    };
  }

  ProductModel copyWith({
    String? productId,
    String? title,
    String? imageUrl,
    String? desc,
    String? category,
    double? price,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      desc: desc ?? this.desc,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }
}
