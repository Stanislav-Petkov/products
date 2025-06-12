import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/feature/products/domain/models/product.dart';
import 'package:products/feature/products/presentation/cubit/product_list_cubit.dart';
import 'package:products/feature/products/presentation/cubit/product_list_state.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<ProductListCubit, ProductListState>(
            builder: (context, state) {
              final current = state.products
                  .firstWhere((p) => p.id == product.id, orElse: () => product);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(current.title,
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  Text(current.description,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          current.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: current.isFavorite ? Colors.red : null,
                        ),
                        onPressed: () {
                          context
                              .read<ProductListCubit>()
                              .toggleFavorite(current.id);
                        },
                      ),
                      Text(current.isFavorite ? 'Favorite' : 'Not favorite'),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      );
}
