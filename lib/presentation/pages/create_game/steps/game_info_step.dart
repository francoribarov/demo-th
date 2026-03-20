import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/media_upload_tile.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/removable_photo_tile.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

/// Step 1: Title, description, and images.
class GameInfoStep extends StatelessWidget {
  const GameInfoStep({
    required this.title,
    required this.description,
    required this.images,
    required this.isUploadingImages,
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    required this.onAddImages,
    required this.onRemoveImage,
    this.titleError,
    this.descriptionError,
    super.key,
  });

  final String title;
  final String description;
  final List<String> images;
  final bool isUploadingImages;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onAddImages;
  final ValueChanged<int> onRemoveImage;
  final String? titleError;
  final String? descriptionError;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Qué juego querés agregar?',
            style: AppTypography.headlineMedium,
          ),
          const SizedBox(height: AppTheme.spacingXs),
          Text(
            'Ingresá el nombre, una descripción y fotos del juego.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXl),

          TextFormInputField(
            key: ValueKey('create_game_title_$title'),
            initialValue: title,
            labelText: 'Nombre del juego *',
            hintText: 'Ej: Catan, Dixit, Azul...',
            onChanged: onTitleChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (_) => titleError,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: AppTheme.spacingLg),

          TextFormInputField(
            key: ValueKey('create_game_desc_${title.hashCode}'),
            initialValue: description,
            maxLines: 4,
            maxLength: 500,
            labelText: 'Descripción *',
            hintText: 'Describí de qué se trata el juego...',
            onChanged: onDescriptionChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (_) => descriptionError,
          ),
          const SizedBox(height: AppTheme.spacing2xl),

          Text('Fotos del juego', style: AppTypography.titleMedium),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Las fotos ayudan a otros usuarios a reconocer el juego.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          MediaUploadTile(
            onTap: onAddImages,
            title: 'Tocá para agregar fotos',
            subtitle: 'La primera foto será la portada',
            isUploading: isUploadingImages,
            height: 160,
          ),

          if (images.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacingLg),
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
          ],

          const SizedBox(height: AppTheme.spacingScrollBottom),
        ],
      ),
    );
  }
}
