import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:products/core/injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
