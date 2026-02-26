import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Step for editing publication photos.
class EditPhotosStep extends StatelessWidget {
  /// Creates the edit photos step.
  const EditPhotosStep({
    required this.images,
    required this.isUploading,
    required this.onImagesChanged,
    required this.onAddImage,
    super.key,
  });

  /// Current list of image URLs.
  final List<String> images;

  /// Whether an image is currently being uploaded.
  final bool isUploading;

  /// Callback when images change.
  final ValueChanged<List<String>> onImagesChanged;

  /// Callback to add new images.
  final VoidCallback onAddImage;

  void _addImage(BuildContext context) {
    onAddImage();
  }

  void _removeImage(int index) {
    final updatedImages = [...images]..removeAt(index);
    onImagesChanged(updatedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fotos del juego',
          style: AppTypography.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Las fotos muestran el estado actual de tu juego.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.mutedForeground,
          ),
        ),
        const SizedBox(height: 24),

        // Add photo button
        GestureDetector(
          onTap: () => _addImage(context),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.gameCream.withOpacityValue(0.5),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border:
                  Border.all(color: AppColors.gameBrown.withOpacityValue(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 40,
                  color: AppColors.gameBrown.withOpacityValue(0.5),
                ),
                const SizedBox(height: 8),
                Text(
                  'Agregar foto',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Current photos grid
        if (images.isNotEmpty) ...[
          Text(
            'Fotos actuales (${images.length})',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return _PhotoTile(
                imageUrl: images[index],
                onRemove: () => _removeImage(index),
                isFirst: index == 0,
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: AppColors.mutedForeground,
              ),
              const SizedBox(width: 8),
              Text(
                'La primera foto será la imagen principal',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.mutedForeground,
                ),
              ),
            ],
          ),
        ] else
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.muted.withOpacityValue(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.photo_library_outlined,
                  size: 48,
                  color: AppColors.mutedForeground,
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay fotos todavía',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.mutedForeground,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.imageUrl,
    required this.onRemove,
    required this.isFirst,
  });

  final String imageUrl;
  final VoidCallback onRemove;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, error, stackTrace) => ColoredBox(
              color: AppColors.muted.withOpacityValue(0.2),
              child: const Center(
                child: Icon(
                  Icons.broken_image,
                  color: AppColors.mutedForeground,
                ),
              ),
            ),
          ),
        ),

        // Remove button
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: ColoredBox(
              color: Colors.black54,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),

        // Main photo badge
        if (isFirst)
          Positioned(
            bottom: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.gameRust,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Text(
                'Principal',
                style: AppTypography.labelSmall.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
