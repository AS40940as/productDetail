import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  final String apiUrl = 'https://jsonplaceholder.org/posts';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data = productFromJson(response.body);
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
