import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/feature/products/domain/repositories/product_repository.dart';
import 'feature/products/presentation/cubit/product_list_cubit.dart';
import 'feature/products/presentation/pages/product_grid_page.dart';
import 'core/injection_container.dart';

Future<void> main() async {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductListCubit(getIt<ProductRepository>()),
      child: const MaterialApp(
        home: ProductGridPage(),
      ),
    );
  }
}
