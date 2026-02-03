import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

class PublicationDetailsErrorView extends StatelessWidget {
  const PublicationDetailsErrorView({
    required this.errorMessage,
    super.key,
  });

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.popOrGo(AppRoutes.home),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage ?? 'Juego no encontrado',
              style: AppTypography.headlineMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goHome(),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
