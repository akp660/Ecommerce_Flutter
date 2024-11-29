import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/product_model.dart';

class ApiService {
  final String baseUrl = 'https://api.escuelajs.co/api/v1/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
