import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'dart:collection';
import 'package:products/feature/products/domain/models/product.dart';
import 'product_list_error.dart';

@immutable
class ProductListState extends Equatable {
  final UnmodifiableListView<Product> products;
  final bool isLoading;
  final ProductListError? error;

  ProductListState({
    List<Product>? products,
    this.isLoading = false,
    this.error,
  }) : products = UnmodifiableListView(products ?? const []);

  ProductListState copyWith({
    List<Product>? products,
    bool? isLoading,
    ProductListError? error,
  }) {
    return ProductListState(
      products:
          products != null ? UnmodifiableListView(products) : this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error];
}
