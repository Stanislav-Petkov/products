import 'package:products/feature/products/domain/models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts(int start, int count);
  Future<Product> addProduct(Product product);
  Future<Product?> updateFavorite(int id, bool isFavorite);
  Future<void> removeProduct(int id);
}
