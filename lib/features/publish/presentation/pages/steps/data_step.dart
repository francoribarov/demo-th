import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/publish/presentation/widgets/game_selector.dart';

/// Step in the publish flow for entering basic game data.
class DataStep extends StatelessWidget {
  /// Creates a [DataStep].
  const DataStep({
    required this.formVersion,
    required this.gameId,
    required this.description,
    required this.onGameIdChanged,
    required this.onDescriptionChanged,
    super.key,
  });

  /// Incremented when the form is reset to clear internal controller states.
  final int formVersion;

  /// Current game ID (String UUID).
  final String gameId;

  /// Current description value.
  final String description;

  /// Callback when game ID changes.
  final void Function(String) onGameIdChanged;

  /// Callback when description changes.
  final void Function(String) onDescriptionChanged;

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
            onDescriptionChanged(game.description);
          },
        ),
        const SizedBox(height: 16),

        // Description
        TextFormField(
          key: ValueKey('publish_description_$formVersion'),
          initialValue: description,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Descripción *',
            hintText: 'Contanos qué hace especial a este juego...',
          ),
          onChanged: onDescriptionChanged,
        ),
      ],
    );
  }
}
