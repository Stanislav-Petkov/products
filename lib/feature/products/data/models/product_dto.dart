import 'package:equatable/equatable.dart';
import 'package:products/feature/products/domain/models/product.dart';

class ProductDto extends Equatable {
  final int id;
  final String? title;
  final String? description;
  final bool? isFavorite;

  const ProductDto({
    required this.id,
    this.title,
    this.description,
    this.isFavorite,
  });

  ProductDto copyWith({
    int? id,
    String? title,
    String? description,
    bool? isFavorite,
  }) =>
      ProductDto(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  Product toProduct() => Product(
        id: id,
        title: title ?? '',
        description: description ?? '',
        isFavorite: isFavorite ?? false,
      );

  factory ProductDto.fromProduct(Product product) => ProductDto(
        id: product.id,
        title: product.title,
        description: product.description,
        isFavorite: product.isFavorite,
      );

  @override
  List<Object?> get props => [id, title, description, isFavorite];
}
