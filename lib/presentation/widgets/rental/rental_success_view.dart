import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';

class RentalSuccessView extends StatelessWidget {
  const RentalSuccessView({
    required this.publication,
    required this.onBackHome,
    super.key,
  });

  final PublicationListing publication;
  final VoidCallback onBackHome;

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
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 64,
                  color: Colors.green[600],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '¡Solicitud enviada!',
                style: AppTypography.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Tu solicitud de alquiler de ${publication.title} fue enviada. '
                'El propietario deberá aceptarla.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Te notificaremos cuando el propietario acepte tu solicitud.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: onBackHome,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
