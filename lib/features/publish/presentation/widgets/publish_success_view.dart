import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// View shown after a game has been successfully published.
class PublishSuccessView extends StatelessWidget {
  /// Creates a [PublishSuccessView].
  const PublishSuccessView({
    required this.onBackHome,
    required this.onPublishAnother,
    super.key,
  });

  /// Callback to navigate back home.
  final VoidCallback onBackHome;

  /// Callback to start another publishing flow.
  final VoidCallback onPublishAnother;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.green[50], shape: BoxShape.circle,),
                child: Icon(Icons.check_circle,
                    size: 64, color: Colors.green[600],),
              ),
              const SizedBox(height: 32),
              Text('¡Juego publicado!',
                  style: AppTypography.displaySmall,
                  textAlign: TextAlign.center,),
              const SizedBox(height: 16),
              Text(
                'Tu publicación ya está disponible para alquilar.',
                style: AppTypography.bodyLarge
                    .copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: onBackHome,
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),),
                child: const Text('Volver al inicio'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onPublishAnother,
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),),
                child: const Text('Publicar otro juego'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
