import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/validators/publish/publication_validator.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/publish/game_selector.dart';

/// Step in the publish flow for entering basic game data.
class DataStep extends StatelessWidget {
  /// Creates a [DataStep].
  const DataStep({
    required this.formVersion,
    required this.gameId,
    required this.description,
    required this.condition,
    required this.conditions,
    required this.allGames,
    required this.filteredGames,
    required this.isLoadingGames,
    required this.onGameIdChanged,
    required this.onGameSearchChanged,
    required this.onGameSearchCleared,
    required this.onDescriptionChanged,
    required this.onConditionChanged,
    super.key,
  });

  /// Incremented when the form is reset to clear internal controller states.
  final int formVersion;

  /// Current game ID (String UUID).
  final String gameId;

  /// Current description value.
  final String description;

  /// Current game condition.
  final PublicationCondition? condition;

  /// List of available conditions.
  final List<PublicationCondition> conditions;
  final List<Game> allGames;
  final List<Game> filteredGames;
  final bool isLoadingGames;

  /// Callback when game ID changes.
  final void Function(String) onGameIdChanged;
  final ValueChanged<String> onGameSearchChanged;
  final VoidCallback onGameSearchCleared;

  /// Callback when description changes.
  final void Function(String) onDescriptionChanged;

  /// Callback when condition changes.
  final void Function(PublicationCondition) onConditionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Datos del juego', style: AppTypography.headlineMedium),
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          'Contanos sobre el juego que querés publicar',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing2xl),

        // Game Selector
        GameSelector(
          selectedGameId: gameId.isEmpty ? null : gameId,
          allGames: allGames,
          filteredGames: filteredGames,
          isLoadingGames: isLoadingGames,
          onSearchChanged: onGameSearchChanged,
          onSearchCleared: onGameSearchCleared,
          onGameSelected: (game) {
            onGameIdChanged(game.id);
          },
        ),
        const SizedBox(height: AppTheme.spacingLg),

        // Description
        TextFormInputField(
          key: ValueKey('publish_description_${formVersion}_$gameId'),
          initialValue: description,
          maxLines: 3,
          maxLength: 500,
          labelText: 'Descripción *',
          hintText: 'Contanos qué hace especial a este juego...',
          onChanged: onDescriptionChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            final result = PublicationValidator.validateDescription(
              value ?? '',
            );
            return result.isValid ? null : result.message;
          },
        ),
        const SizedBox(height: AppTheme.spacing2xl),

        // Condition
        Text('Estado del juego', style: AppTypography.titleMedium),
        const SizedBox(height: AppTheme.spacingMd),
        FormField<PublicationCondition>(
          initialValue: condition,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null) {
              return 'Debes seleccionar el estado del juego';
            }
            return null;
          },
          builder: (field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...conditions.map(
                  (c) => Padding(
                    padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
                    child: SelectableInputCard(
                      onTap: () {
                        field.didChange(c);
                        onConditionChanged(c);
                      },
                      isSelected: field.value == c,
                      indicatorMode: SelectableInputIndicatorMode.radio,
                      indicatorPosition:
                          SelectableInputIndicatorPosition.leading,
                      title: c.label,
                      subtitle: c.description,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      selectedBackgroundColor: AppColors.gameRust
                          .withOpacityValue(0.1),
                      unselectedBorderColor: AppColors.border,
                      selectedTextColor: AppColors.gameRust,
                      unselectedTextColor: AppColors.foreground,
                    ),
                  ),
                ),
                if (field.hasError)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppTheme.spacingXs,
                      left: AppTheme.spacingMd,
                    ),
                    child: Text(
                      field.errorText!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.destructive,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
