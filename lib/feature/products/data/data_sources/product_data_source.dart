import 'package:products/feature/products/data/models/product_dto.dart';

abstract class ProductDataSource {
  Future<List<ProductDto>> fetchProducts(int start, int count);
  Future<void> addProduct(ProductDto product);
  Future<void> updateFavorite(int id, bool isFavorite);
  Future<void> removeProduct(int id);
}
