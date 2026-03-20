import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/media_upload_tile.dart';

/// Step 3: PDF rules upload (optional).
class GameRulesStep extends StatelessWidget {
  const GameRulesStep({
    required this.rulesUrl,
    required this.isUploading,
    required this.onPickPdf,
    required this.onRemovePdf,
    super.key,
  });

  final String rulesUrl;
  final bool isUploading;
  final VoidCallback onPickPdf;
  final VoidCallback onRemovePdf;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reglas del juego', style: AppTypography.headlineMedium),
          const SizedBox(height: AppTheme.spacingXs),
          Text(
            'Subí un PDF con las reglas para que los jugadores puedan '
            'consultarlas antes de alquilar.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.gameCream.withOpacityValue(0.5),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(
                color: AppColors.gameBrown.withOpacityValue(0.15),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  size: 20,
                  color: AppColors.gameGold,
                ),
                const SizedBox(width: AppTheme.spacingSm),
                Expanded(
                  child: Text(
                    'Este paso es opcional. Podés agregar las reglas más adelante.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing2xl),

          if (rulesUrl.isEmpty)
            MediaUploadTile(
              onTap: onPickPdf,
              title: 'Tocá para subir un PDF',
              subtitle: 'Formato PDF, máximo 10 MB',
              icon: Icons.picture_as_pdf_outlined,
              isUploading: isUploading,
              height: 180,
            )
          else
            _UploadedPdfCard(
              rulesUrl: rulesUrl,
              onRemove: onRemovePdf,
              onReplace: onPickPdf,
            ),

          const SizedBox(height: AppTheme.spacingScrollBottom),
        ],
      ),
    );
  }
}

class _UploadedPdfCard extends StatelessWidget {
  const _UploadedPdfCard({
    required this.rulesUrl,
    required this.onRemove,
    required this.onReplace,
  });

  final String rulesUrl;
  final VoidCallback onRemove;
  final VoidCallback onReplace;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.successSurface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: AppColors.success.withOpacityValue(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacityValue(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.picture_as_pdf,
              color: AppColors.success,
              size: 28,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PDF de reglas subido',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Archivo listo para publicar',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.6),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onReplace,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reemplazar',
            color: AppColors.gameBrown,
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Eliminar',
            color: AppColors.destructive,
          ),
        ],
      ),
    );
  }
}
