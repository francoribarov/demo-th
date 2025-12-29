import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/di/injection.config.dart';

/// Service locator for dependency injection.
final GetIt getIt = GetIt.instance;

/// Registers all injectable dependencies.
@InjectableInit()
Future<void> configureDependencies() async {
  // Initialize injectable dependencies (includes async pre-resolved deps)
  await getIt.init();
}
