import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

/// Step 1 of the create-game wizard: title and description.
class GameInfoStep extends StatelessWidget {
  const GameInfoStep({
    required this.title,
    required this.description,
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    this.titleError,
    this.descriptionError,
    super.key,
  });

  final String title;
  final String description;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final String? titleError;
  final String? descriptionError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Información del juego', style: AppTypography.headlineMedium),
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          'Ingresá los datos básicos del juego de mesa que querés agregar al catálogo.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppTheme.spacingSm),
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          decoration: BoxDecoration(
            color: AppColors.info.withOpacityValue(0.08),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: Border.all(color: AppColors.info.withOpacityValue(0.2)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 20,
                color: AppColors.info,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Expanded(
                child: Text(
                  'Este juego quedará disponible para que otros usuarios también lo publiquen.',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.info,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacing2xl),

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
      ],
    );
  }
}
