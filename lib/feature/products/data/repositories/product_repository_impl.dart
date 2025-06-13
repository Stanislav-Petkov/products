import 'package:injectable/injectable.dart';
import 'package:products/feature/products/data/data_sources/product_data_source.dart';
import 'package:products/feature/products/data/models/product_dto.dart';
import 'package:products/feature/products/domain/repositories/product_repository.dart';
import 'package:products/feature/products/domain/models/product.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this.dataSource);

  final ProductDataSource dataSource;

  @override
  Future<List<Product>> fetchProducts(int start, int count) async {
    final dtos = await dataSource.fetchProducts(start, count);
    return dtos.map((dto) => dto.toProduct()).toList();
  }

  @override
  Future<Product> addProduct(Product product) async {
    final dto = ProductDto.fromProduct(product);
    final addedDto = await dataSource.addProduct(dto);
    return addedDto.toProduct();
  }

  @override
  Future<Product?> updateFavorite(int id, bool isFavorite) async {
    final updatedDto = await dataSource.updateFavorite(id, isFavorite);
    return updatedDto?.toProduct();
  }

  @override
  Future<void> removeProduct(int id) async => dataSource.removeProduct(id);
}
