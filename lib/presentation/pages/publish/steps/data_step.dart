import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/validators/publish/publication_validator.dart';
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

        // Condition Selector
        FormField<PublicationCondition>(
          initialValue: condition,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return null;
          },
          builder: (field) {
            return InkWell(
              key: ValueKey('publish_condition_${formVersion}_$gameId'),
              onTap: () async {
                FocusScope.of(context).unfocus();
                
                final selected = await showModalBottomSheet<PublicationCondition>(
                  context: context,
                  backgroundColor: AppColors.card,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppTheme.radius2xl),
                    ),
                  ),
                  builder: (context) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingLg),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                              child: Text(
                                'Estado del juego',
                                style: AppTypography.titleSmall.copyWith(
                                  color: AppColors.gameBrown,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingMd),
                            ...conditions.map((c) {
                              final isSelected = field.value == c;
                              return InkWell(
                                onTap: () => Navigator.pop(context, c),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.spacingLg,
                                    vertical: AppTheme.spacingMd,
                                  ),
                                  color: isSelected
                                      ? const Color(0xFFE5E5E5)
                                      : Colors.transparent,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              c.label,
                                              style: AppTypography.bodyLarge.copyWith(
                                                color: AppColors.gameBrown,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              c.description,
                                              style: AppTypography.bodySmall.copyWith(
                                                color: AppColors.textTertiary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isSelected)
                                        const Icon(
                                          Icons.check_circle,
                                          color: AppColors.gameRust,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                );

                if (selected != null) {
                  field.didChange(selected);
                  onConditionChanged(selected);
                }
              },
              borderRadius: BorderRadius.circular(AppTheme.radius2xl),
              child: InputDecorator(
                decoration: buildTextInputDecoration(
                  variant: TextInputVisualVariant.surface,
                  hintText: 'Selecciona el estado...',
                ).copyWith(
                  errorText: field.errorText,
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.textTertiary,
                  ),
                ),
                isEmpty: field.value == null,
                child: field.value == null
                    ? const SizedBox.shrink()
                    : Text(
                        field.value!.label,
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.gameBrown,
                        ),
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
