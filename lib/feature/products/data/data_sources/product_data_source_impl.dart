import 'package:injectable/injectable.dart';
import 'package:products/feature/products/data/data_sources/product_data_source.dart';
import 'package:products/feature/products/data/models/product_dto.dart';

@LazySingleton(as: ProductDataSource)
class ProductDataSourceImpl implements ProductDataSource {
  final List<ProductDto> _products = [];

  ProductDataSourceImpl() {
    _seedProducts(1, 10);
  }

  void _seedProducts(int startId, int count) {
    _products.addAll(List.generate(
        count,
        (i) => ProductDto(
              id: startId + i,
              title: 'Sample Product ${startId + i}',
              description: 'Description for sample product ${startId + i}',
              isFavorite: false,
            )));
  }

  @override
  Future<List<ProductDto>> fetchProducts(int start, int count) async {
    await Future.delayed(const Duration(milliseconds: 500));
    while (_products.length < start + count) {
      final lastId = _products.isNotEmpty ? _products.last.id : 0;
      _seedProducts(lastId + 1, 10);
    }
    final end =
        (start + count) > _products.length ? _products.length : (start + count);
    if (start >= _products.length) return [];
    return _products.sublist(start, end);
  }

  @override
  Future<void> addProduct(ProductDto dto) async {
    final lastId = _products.isNotEmpty ? _products.last.id : 0;
    final newDto = dto.copyWith(id: lastId + 1);
    _products.add(newDto);
  }

  @override
  Future<void> updateFavorite(int id, bool isFavorite) async {
    final index = _products.indexWhere((dto) => dto.id == id);
    if (index != -1) {
      _products[index] = _products[index].copyWith(isFavorite: isFavorite);
    }
  }

  @override
  Future<void> removeProduct(int id) async {
    _products.removeWhere((dto) => dto.id == id);
  }
}
