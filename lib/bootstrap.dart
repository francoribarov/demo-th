import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart';

/// Bootstrap the application.
Future<void> bootstrap() async {
  // Initialize dependency injection
  await configureDependencies();

  // Run the app
  runApp(const TableHoppingApp());
}

/// Main application widget.
class TableHoppingApp extends StatelessWidget {
  /// Creates the root application widget.
  const TableHoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: getIt<AuthBloc>()),
        BlocProvider<CatalogBloc>(create: (_) => getIt<CatalogBloc>()..add(const LoadGames())),
      ],
      child: MaterialApp.router(
        title: 'Table Hopping',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        builder: (context, child) {
          // Apply global text scale factor limit for accessibility
          return MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(MediaQuery.of(context).textScaler.scale(1).clamp(0.8, 1.3))),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
