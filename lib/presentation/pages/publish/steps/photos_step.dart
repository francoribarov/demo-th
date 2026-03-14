import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/media_upload_tile.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/removable_photo_tile.dart';

/// Step in the publish flow for uploading game photos.
class PhotosStep extends StatelessWidget {
  /// Creates a [PhotosStep].
  const PhotosStep({
    required this.images,
    required this.onAddImage,
    required this.onRemoveImage,
    this.isUploading = false,
    super.key,
  });

  /// List of current image URLs.
  final List<String> images;

  /// Callback to add new images.
  final VoidCallback onAddImage;

  /// Callback to remove an image at index.
  final void Function(int index) onRemoveImage;

  /// Whether images are currently uploading.
  final bool isUploading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fotos', style: AppTypography.headlineMedium),
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          'Agregá fotos del juego para que los inquilinos lo vean',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing2xl),

        // Photo upload placeholder
        MediaUploadTile(
          onTap: onAddImage,
          title: 'Tocá para agregar fotos',
          subtitle: 'La primera foto será la portada',
          isUploading: isUploading,
        ),

        const SizedBox(height: AppTheme.spacing2xl),

        if (images.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppTheme.spacingMd,
              mainAxisSpacing: AppTheme.spacingMd,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return RemovablePhotoTile(
                imageUrl: images[index],
                onRemove: () => onRemoveImage(index),
                isPrimary: index == 0,
              );
            },
          ),

        const SizedBox(height: AppTheme.spacingScrollBottom),
      ],
    );
  }
}
