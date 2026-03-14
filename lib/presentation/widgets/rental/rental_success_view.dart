import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/app_buttons.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

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
          padding: const EdgeInsets.all(
            AppTheme.spacing3xl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacityValue(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 64,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(
                height: AppTheme.spacing3xl,
              ),
              Text(
                '¡Solicitud enviada!',
                style: AppTypography.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppTheme.spacingLg,
              ),
              Text(
                'Tu pedido de ${publication.title} '
                'fue enviado al propietario.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppTheme.spacingSm,
              ),
              Text(
                'Te avisamos apenas lo confirme.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: AppTheme.spacing4xl,
              ),
              AppPrimaryButton(
                onPressed: onBackHome,
                expand: true,
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
