import 'package:flutter/material.dart';
import 'package:products/feature/products/presentation/cubit/product_list_error.dart';
import 'package:products/feature/products/presentation/cubit/product_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/feature/products/presentation/cubit/product_list_cubit.dart';
import 'package:products/feature/products/presentation/widgets/add_product_dialog.dart';
import 'package:products/feature/products/presentation/widgets/product_loader.dart';
import 'package:products/feature/products/presentation/widgets/product_tile.dart';

class ProductGridPage extends StatefulWidget {
  const ProductGridPage({super.key});

  @override
  State<ProductGridPage> createState() => _ProductGridPageState();
}

class _ProductGridPageState extends State<ProductGridPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductListCubit>().loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<ProductListCubit, ProductListState>(
        listener: (context, state) {
          if (state.error != null) {
            _handleProductListError(context, state.error!);
          }
        },
        builder: (context, state) {
          if (state.products.isEmpty && state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              _buildProductGrid(state),
              if (state.isLoading) const ProductLoader(),
            ],
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) => AppBar(
        title: const Text('Products'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add') {
                showDialog(
                  context: context,
                  builder: (_) => AddProductDialog(),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'add',
                child: Text('Add Product'),
              ),
            ],
          ),
        ],
      );

  Widget _buildProductGrid(ProductListState state) => GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        controller: _scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];
          return Dismissible(
            key: ValueKey(product.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (_) async {
              await context.read<ProductListCubit>().removeProduct(product.id);
              return false;
            },
            child: ProductTile(product: product),
          );
        },
      );

  void _handleProductListError(BuildContext context, ProductListError error) {
    switch (error) {
      case ProductListError.markAsFavoriteError:
        _showSnackBar(context, message: 'Failed to mark as favorite');
        context.read<ProductListCubit>().clearError();
        break;
      case ProductListError.addProductError:
        _showSnackBar(context, message: 'Failed to add product');
        context.read<ProductListCubit>().clearError();
        break;
      case ProductListError.deleteProductError:
        _showSnackBar(context, message: 'Failed to delete product');
        context.read<ProductListCubit>().clearError();
        break;
      case ProductListError.loadMoreProductsError:
        _showDialog(context, message: 'Failed to load more products');
        break;
    }
  }

  void _showSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showDialog(BuildContext context, {required String message}) =>
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<ProductListCubit>().loadMore();
                context.read<ProductListCubit>().clearError();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductListCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
