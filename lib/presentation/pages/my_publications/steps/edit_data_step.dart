import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart' as common_inputs;
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

/// Step for editing publication data (description and condition).
class EditDataStep extends StatelessWidget {
  /// Creates the edit data step.
  const EditDataStep({
    required this.description,
    required this.condition,
    required this.conditions,
    required this.onDescriptionChanged,
    required this.onConditionChanged,
    this.selectedGame,
    this.descriptionError,
    this.conditionError,
    super.key,
  });

  /// Current description.
  final String description;

  /// Current condition.
  final PublicationCondition? condition;

  /// List of condition options.
  final List<PublicationCondition> conditions;

  /// Selected game (read-only display).
  final Game? selectedGame;

  /// Callback when description changes.
  final ValueChanged<String> onDescriptionChanged;

  /// Callback when condition changes.
  final ValueChanged<PublicationCondition> onConditionChanged;

  /// Validation error for description from bloc.
  final String? descriptionError;

  /// Validation error for condition from bloc.
  final String? conditionError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Game info (read-only)
        if (selectedGame != null) ...[
          Text(
            'Juego',
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.foreground,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.muted.withOpacityValue(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  child: selectedGame!.images.isNotEmpty
                      ? Image.network(
                          selectedGame!.images.first,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, error, stackTrace) => const MediaPlaceholder(
                            width: 60,
                            height: 60,
                            borderRadius: BorderRadius.all(
                              Radius.circular(AppTheme.radiusSm),
                            ),
                            backgroundOpacity: 0.3,
                            icon: Icons.extension,
                            iconSize: 30,
                          ),
                        )
                      : const MediaPlaceholder(
                          width: 60,
                          height: 60,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppTheme.radiusSm),
                          ),
                          backgroundOpacity: 0.3,
                          icon: Icons.extension,
                          iconSize: 30,
                        ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedGame!.title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${selectedGame!.players} jugadores • ${selectedGame!.duration} min',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.lock_outline,
                  color: AppColors.mutedForeground,
                  size: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'El juego no se puede cambiar',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.mutedForeground,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),
        ],

        // Description
        Text(
          'Descripción',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.foreground,
          ),
        ),
        const SizedBox(height: 8),
        TextFormInputField(
          initialValue: description,
          maxLines: 4,
          maxLength: 500,
          hintText: 'Describe el estado y cualquier detalle importante...',
          variant: TextInputVisualVariant.subtle,
          validator: (_) => descriptionError,
          autovalidateMode: descriptionError != null ? AutovalidateMode.always : AutovalidateMode.onUserInteraction,
          onChanged: onDescriptionChanged,
        ),
        const SizedBox(height: 24),

        // Condition
        Text(
          'Estado del juego',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.foreground,
          ),
        ),
        const SizedBox(height: 8),
        if (conditionError != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
            child: Text(
              conditionError!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.destructive,
              ),
            ),
          ),
        ],
        ...conditions.map(
          (c) => Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
            child: _ConditionOption(
              condition: c,
              isSelected: condition == c,
              onTap: () => onConditionChanged(c),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConditionOption extends StatelessWidget {
  // Thin adapter to keep condition-specific styling and wording centralized.
  const _ConditionOption({
    required this.condition,
    required this.isSelected,
    required this.onTap,
  });

  final PublicationCondition condition;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return common_inputs.SelectableInputCard(
      onTap: onTap,
      isSelected: isSelected,
      indicatorMode: common_inputs.SelectableInputIndicatorMode.radio,
      indicatorPosition: common_inputs.SelectableInputIndicatorPosition.leading,
      title: condition.label,
      subtitle: condition.description,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      selectedBackgroundColor: AppColors.gameRust.withOpacityValue(0.1),
      unselectedBorderColor: AppColors.border,
      selectedTextColor: AppColors.gameRust,
      unselectedTextColor: AppColors.foreground,
    );
  }
}
