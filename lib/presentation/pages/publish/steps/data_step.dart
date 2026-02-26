import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/domain/validators/publish/publication_validator.dart';
import 'package:mobile_table_hopping/presentation/widgets/publish/game_selector.dart';

/// Step in the publish flow for entering basic game data.
class DataStep extends StatelessWidget {
  /// Creates a [DataStep].
  const DataStep({
    required this.formVersion,
    required this.gameId,
    required this.description,
    required this.condition,
    required this.conditions,
    required this.onGameIdChanged,
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

  /// Callback when game ID changes.
  final void Function(String) onGameIdChanged;

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
        const SizedBox(height: 8),
        Text(
          'Contanos sobre el juego que querés publicar',
          style: AppTypography.bodyMedium
              .copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Game Selector
        GameSelector(
          selectedGameId: gameId.isEmpty ? null : gameId,
          onGameSelected: (game) {
            onGameIdChanged(game.id);
          },
        ),
        const SizedBox(height: 16),

        // Description
        TextFormField(
          key: ValueKey('publish_description_${formVersion}_$gameId'),
          initialValue: description,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Descripción *',
            hintText: 'Contanos qué hace especial a este juego...',
          ),
          onChanged: onDescriptionChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            final result =
                PublicationValidator.validateDescription(value ?? '');
            return result.isValid ? null : result.message;
          },
        ),
        const SizedBox(height: 24),

        // Condition
        Text('Estado del juego', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        DropdownButtonFormField<PublicationCondition>(
          initialValue: condition,
          decoration: InputDecoration(
            hintText: 'Seleccioná el estado',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.gameBrown.withOpacityValue(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.gameBrown.withOpacityValue(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.gameRust,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: AppColors.card,
          ),
          items: conditions.map((c) {
            return DropdownMenuItem<PublicationCondition>(
              value: c,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.label, style: AppTypography.bodyMedium),
                  Text(
                    c.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.7),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onConditionChanged(value);
            }
          },
          selectedItemBuilder: (context) {
            return conditions.map((c) {
              return Text(c.label, style: AppTypography.bodyMedium);
            }).toList();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null) {
              return 'Debes seleccionar el estado del juego';
            }
            return null;
          },
        ),
      ],
    );
  }
}
