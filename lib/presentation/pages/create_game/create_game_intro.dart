import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

/// Entry point screen shown before the create-game wizard starts.
///
/// Explains why and when the user should create a new game,
/// and sets expectations that it will be shared with other users.
class CreateGameIntro extends StatelessWidget {
  const CreateGameIntro({
    required this.onStart,
    required this.onCancel,
    super.key,
  });

  final VoidCallback onStart;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onCancel,
        ),
        title: const Text('Crear juego'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppTheme.spacing2xl),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(AppTheme.spacing2xl),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gameRust.withOpacityValue(0.12),
                                AppColors.gameGold.withOpacityValue(0.08),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.extension_outlined,
                            size: 56,
                            color: AppColors.gameRust,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing3xl),
                      Text(
                        '¿No encontraste tu juego?',
                        style: AppTypography.headlineMedium,
                      ),
                      const SizedBox(height: AppTheme.spacingMd),
                      Text(
                        'Si tu juego de mesa no está en nuestro catálogo, '
                        'podés agregarlo vos mismo. '
                        'Solo necesitás completar unos pocos datos.',
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.7),
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacing3xl),
                      const _InfoRow(
                        icon: Icons.people_outline,
                        title: 'Compartido con todos',
                        description:
                            'El juego que crees quedará disponible para que '
                            'otros usuarios también lo publiquen.',
                      ),
                      const SizedBox(height: AppTheme.spacingLg),
                      const _InfoRow(
                        icon: Icons.timer_outlined,
                        title: 'Rápido y simple',
                        description:
                            'Solo necesitamos nombre, descripción, '
                            'y algunos detalles técnicos.',
                      ),
                      const SizedBox(height: AppTheme.spacingLg),
                      const _InfoRow(
                        icon: Icons.picture_as_pdf_outlined,
                        title: 'Reglas opcionales',
                        description:
                            'Podés subir un PDF con las reglas para '
                            'que los jugadores las consulten.',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingLg),
              AppPrimaryButton(
                label: 'Comenzar',
                onPressed: onStart,
                minimumSize: const Size(double.infinity, 52),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              AppSecondaryButton(
                label: 'Cancelar',
                onPressed: onCancel,
                minimumSize: const Size(double.infinity, 48),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          decoration: BoxDecoration(
            color: AppColors.gameRust.withOpacityValue(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22, color: AppColors.gameRust),
        ),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.titleSmall),
              const SizedBox(height: 2),
              Text(
                description,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
