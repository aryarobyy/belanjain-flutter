import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productId;
  final String title;
  final String imageUrl;
  final String desc;
  final String category;
  final DateTime price;

  ProductModel({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.desc,
    required this.category,
    required this.price,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data,) {
    if (!data.containsKey('email')) {
      throw ArgumentError('Email is required');
    }

    return ProductModel(
      productId: data['id'] ?? "",
      title: data['title'] ?? "",
      imageUrl: data['image'] ?? "",
      desc: data['desc'] ?? "",
      category: data['category'] ?? "",
      price: data['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': productId,
      'name': title,
      'image': imageUrl,
      'desc': desc,
      'category': category,
      'price': price,
    };
  }

  ProductModel copyWith({
    String? productId,
    String? name,
    String? imageUrl,
    String? desc,
    String? category,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      title: name ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      desc: desc ?? this.desc,
      category: category ?? this.category,
      price: price,
    );
  }
}