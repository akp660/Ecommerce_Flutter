import '../data/api_service.dart';
import '../data/models/product_model.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository(this._apiService);

  Future<List<Product>> getProducts() async {
    try {
      return await _apiService.fetchProducts();
    } catch (e) {
      rethrow;
    }
  }
}
