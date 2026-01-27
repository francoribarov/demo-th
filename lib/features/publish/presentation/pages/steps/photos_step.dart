import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Step in the publish flow for uploading game photos.
class PhotosStep extends StatelessWidget {
  /// Creates a [PhotosStep].
  const PhotosStep({
    required this.images,
    required this.onImagesChanged,
    super.key,
  });

  /// List of current image URLs.
  final List<String> images;

  /// Callback when the image list is updated.
  final void Function(List<String>) onImagesChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fotos', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Agregá fotos del juego para que los inquilinos lo vean',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Photo upload placeholder
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Carga de imágenes próximamente'),
              ),
            );
          },
          child: Container(
            height: 200,
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
                  size: 48,
                  color: AppColors.gameBrown.withOpacityValue(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tocá para agregar fotos',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'La primera foto será la portada',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        if (images.isNotEmpty)
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
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () {
                        final newImages = List<String>.from(images)
                          ..removeAt(index);
                        onImagesChanged(newImages);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
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
                ],
              );
            },
          ),

        const SizedBox(height: 100),
      ],
    );
  }
}
