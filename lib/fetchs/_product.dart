import 'dart:convert';

import 'package:belanjain/models/product_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


final String productUrl = dotenv.env['PRODUCT_API'] ?? " ";

class ProductService {
  Future<List<ProductModel>> getProducts() async {
    final res = await http.get(Uri.parse(productUrl));

    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

}