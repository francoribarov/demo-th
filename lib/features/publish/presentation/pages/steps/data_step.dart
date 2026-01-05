import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';

/// Step in the publish flow for entering basic game data.
class DataStep extends StatelessWidget {
  /// Creates a [DataStep].
  const DataStep({
    required this.formVersion,
    required this.title,
    required this.publisher,
    required this.category,
    required this.description,
    required this.duration,
    required this.players,
    required this.difficulty,
    required this.categories,
    required this.difficulties,
    required this.onTitleChanged,
    required this.onPublisherChanged,
    required this.onCategoryChanged,
    required this.onDescriptionChanged,
    required this.onDurationChanged,
    required this.onPlayersChanged,
    required this.onDifficultyChanged,
    super.key,
  });

  /// Incremented when the form is reset to clear internal controller states.
  final int formVersion;

  /// Current title value.
  final String title;

  /// Current publisher value.
  final String publisher;

  /// Current category value.
  final String category;

  /// Current description value.
  final String description;

  /// Current duration value.
  final String duration;

  /// Current players value.
  final String players;

  /// Current difficulty value.
  final String difficulty;

  /// List of available categories.
  final List<String> categories;

  /// List of available difficulty labels.
  final List<String> difficulties;

  /// Callback when title changes.
  final void Function(String) onTitleChanged;

  /// Callback when publisher changes.
  final void Function(String) onPublisherChanged;

  /// Callback when category changes.
  final void Function(String) onCategoryChanged;

  /// Callback when description changes.
  final void Function(String) onDescriptionChanged;

  /// Callback when duration changes.
  final void Function(String) onDurationChanged;

  /// Callback when players changes.
  final void Function(String) onPlayersChanged;

  /// Callback when difficulty changes.
  final void Function(String) onDifficultyChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Datos del juego', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Contanos sobre el juego que querés publicar',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Title
        TextFormField(
          key: ValueKey('publish_title_$formVersion'),
          initialValue: title,
          decoration: const InputDecoration(labelText: 'Nombre del juego *', hintText: 'Ej: Catan, Pandemic, Azul...'),
          onChanged: onTitleChanged,
        ),
        const SizedBox(height: 16),

        // Publisher
        TextFormField(
          key: ValueKey('publish_publisher_$formVersion'),
          initialValue: publisher,
          decoration: const InputDecoration(labelText: 'Editorial', hintText: 'Ej: Devir, Z-Man Games...'),
          onChanged: onPublisherChanged,
        ),
        const SizedBox(height: 16),

        // Category
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Categoría'),
          initialValue: category,
          items: categories.map((c) {
            return DropdownMenuItem(value: c, child: Text(c));
          }).toList(),
          onChanged: (v) => onCategoryChanged(v ?? category),
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
        const SizedBox(height: 24),

        Text('Información técnica', style: AppTypography.titleMedium),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                key: ValueKey('publish_players_$formVersion'),
                initialValue: players,
                decoration: const InputDecoration(labelText: 'Jugadores', hintText: 'Ej: 2-4'),
                onChanged: onPlayersChanged,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                key: ValueKey('publish_duration_$formVersion'),
                initialValue: duration,
                decoration: const InputDecoration(labelText: 'Duración', hintText: 'Ej: 45 min'),
                onChanged: onDurationChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Dificultad'),
          initialValue: difficulty,
          items: difficulties.map((d) {
            return DropdownMenuItem(value: d, child: Text(d));
          }).toList(),
          onChanged: (v) => onDifficultyChanged(v ?? difficulty),
        ),
      ],
    );
  }
}
