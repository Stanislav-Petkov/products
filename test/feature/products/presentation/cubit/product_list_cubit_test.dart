import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:products/feature/products/presentation/cubit/product_list_cubit.dart';
import 'package:products/feature/products/presentation/cubit/product_list_error.dart';
import 'package:products/feature/products/presentation/cubit/product_list_state.dart';
import 'package:products/feature/products/domain/models/product.dart';
import 'package:products/feature/products/domain/repositories/product_repository.dart';
import 'package:products/feature/products/presentation/cubit/product_list_state.dart';

class MockProductRepository extends Mock implements ProductRepository {}

class FakeProduct extends Fake implements Product {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeProduct());
  });
  late ProductListCubit cubit;
  late MockProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
    cubit = ProductListCubit(repository);
  });

  group('ProductListCubit', () {
    const testProduct = Product(id: 0, title: 'Test', description: 'Test Desc');

    blocTest<ProductListCubit, ProductListState>(
      'emits state with new product when addProduct succeeds',
      build: () {
        when(() => repository.addProduct(any())).thenAnswer((_) async {});
        return cubit;
      },
      act: (cubit) => cubit.addProduct('Test', 'Test Desc'),
      expect: () => [
        isA<ProductListState>().having((s) => s.isLoading, 'isLoading', true),
        isA<ProductListState>()
            .having((s) => s.products.length, 'products.length', 1)
            .having((s) => s.isLoading, 'isLoading', false),
      ],
      verify: (_) {
        verify(() => repository.addProduct(any())).called(1);
      },
    );

    blocTest<ProductListCubit, ProductListState>(
      'emits loading and loaded state with products when loadMore succeeds',
      build: () {
        when(() => repository.fetchProducts(any(), any()))
            .thenAnswer((_) async => [testProduct]);
        return cubit;
      },
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        isA<ProductListState>().having((s) => s.isLoading, 'isLoading', true),
        isA<ProductListState>()
            .having((s) => s.products.length, 'products.length', 1)
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.error, 'error', null),
      ],
      verify: (_) {
        verify(() => repository.fetchProducts(0, 10)).called(1);
      },
    );

    blocTest<ProductListCubit, ProductListState>(
      'emits error state when loadMore fails',
      build: () {
        when(() => repository.fetchProducts(any(), any()))
            .thenThrow(Exception('fetch failed'));
        return cubit;
      },
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        isA<ProductListState>().having((s) => s.isLoading, 'isLoading', true),
        isA<ProductListState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.error, 'error',
                ProductListError.loadMoreProductsError),
      ],
      verify: (_) {
        verify(() => repository.fetchProducts(0, 10)).called(1);
      },
    );

    blocTest<ProductListCubit, ProductListState>(
      'emits state with product removed when removeProduct succeeds',
      build: () {
        when(() => repository.removeProduct(any())).thenAnswer((_) async {});
        cubit.emit(cubit.state.copyWith(products: [testProduct]));
        return cubit;
      },
      act: (cubit) => cubit.removeProduct(0),
      expect: () => [
        isA<ProductListState>().having((s) => s.isLoading, 'isLoading', true),
        isA<ProductListState>()
            .having((s) => s.products.isEmpty, 'products.isEmpty', true)
            .having((s) => s.isLoading, 'isLoading', false),
      ],
      verify: (_) {
        verify(() => repository.removeProduct(0)).called(1);
      },
    );

    blocTest<ProductListCubit, ProductListState>(
      'emits state with toggled favorite when toggleFavorite succeeds',
      build: () {
        when(() => repository.updateFavorite(0, true)).thenAnswer((_) async {});
        cubit.emit(cubit.state.copyWith(products: [testProduct]));
        return cubit;
      },
      act: (cubit) => cubit.toggleFavorite(0),
      expect: () => [
        isA<ProductListState>().having((s) => s.isLoading, 'isLoading', true),
        isA<ProductListState>()
            .having((s) => s.products.first.isFavorite, 'isFavorite', true)
            .having((s) => s.isLoading, 'isLoading', false),
      ],
      verify: (_) {
        verify(() => repository.updateFavorite(0, true)).called(1);
      },
    );
  });
}
