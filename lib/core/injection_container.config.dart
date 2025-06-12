// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../feature/products/data/data_sources/product_data_source.dart' as _i3;
import '../feature/products/data/data_sources/product_data_source_impl.dart'
    as _i4;
import '../feature/products/data/repositories/product_repository_impl.dart'
    as _i6;
import '../feature/products/domain/repositories/product_repository.dart' as _i5;
import '../feature/products/presentation/cubit/product_list_cubit.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.ProductDataSource>(() => _i4.ProductDataSourceImpl());
    gh.lazySingleton<_i5.ProductRepository>(
        () => _i6.ProductRepositoryImpl(gh<_i3.ProductDataSource>()));
    gh.factory<_i7.ProductListCubit>(
        () => _i7.ProductListCubit(gh<_i5.ProductRepository>()));
    return this;
  }
}
