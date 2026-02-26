import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';

class MyPublicationsEmptyView extends StatelessWidget {
  const MyPublicationsEmptyView({
    required this.onPublish,
    super.key,
  });

  final VoidCallback onPublish;

  @override
  Widget build(BuildContext context) {
    return StateFeedbackView(
      variant: StateFeedbackVariant.empty,
      leading: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.gameCream,
              AppColors.gameGold.withOpacityValue(0.3),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.gameGold.withOpacityValue(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Icon(
          Icons.storefront_outlined,
          size: 56,
          color: AppColors.gameBrown,
        ),
      ),
      title: 'Aún no tienes publicaciones',
      message:
          '¡Publica tu primer juego de mesa y comienza a ganar dinero compartiéndolo con otros jugadores!',
      primaryActionLabel: 'Publicar mi primer juego',
      onPrimaryAction: onPublish,
      primaryActionStyle: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gameRust,
        foregroundColor: AppColors.primaryForeground,
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        ),
        elevation: 4,
      ),
      titleStyle: AppTypography.titleLarge.copyWith(
        color: AppColors.foreground,
      ),
      messageStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.mutedForeground,
      ),
    );
  }
}
