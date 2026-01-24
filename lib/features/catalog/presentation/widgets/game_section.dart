import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/game_card.dart';

/// Variant for game section layout
enum GameSectionVariant {
  /// Grid layout (vertical stack)
  grid,

  /// Carousel layout (horizontal scroll)
  carousel,
}

/// A section displaying a group of games with a title and description.
class GameSection extends StatelessWidget {
  /// Creates a [GameSection].
  const GameSection({
    required this.title,
    required this.description,
    required this.games,
    required this.variant,
    this.onGameTap,
    this.onCategoryTap,
    super.key,
  });

  /// Title of the section.
  final String title;

  /// Description of the section.
  final String description;

  /// List of games to display.
  final List<Game> games;

  /// Layout variant (grid or carousel).
  final GameSectionVariant variant;

  /// Callback when a game is tapped.
  final void Function(Game)? onGameTap;

  /// Callback when a game category is tapped.
  final void Function(Game)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.headlineMedium),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (variant == GameSectionVariant.carousel)
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: games.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final game = games[index];
                return SizedBox(
                  width: 280,
                  child: GameCardHorizontal(
                    game: game,
                    onTap: () => onGameTap?.call(game),
                  ),
                );
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: games.map((game) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GameCard(
                    game: game,
                    onTap: () => onGameTap?.call(game),
                    onCategoryTap: () => onCategoryTap?.call(game),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
