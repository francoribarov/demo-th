import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/game_card.dart';

/// Section displaying games available for rent today.
class AvailableTodaySection extends StatelessWidget {
  /// Creates an [AvailableTodaySection].
  const AvailableTodaySection({
    required this.games,
    required this.onSeeMore,
    required this.onGameTap,
    super.key,
  });

  /// List of games available today.
  final List<Game> games;

  /// Callback when "See more" is pressed.
  final VoidCallback onSeeMore;

  /// Callback when a game is tapped.
  final void Function(Game) onGameTap;

  @override
  Widget build(BuildContext context) {
    if (games.isEmpty) return const SizedBox.shrink();

    final now = DateTime.now();
    final todayLabel = DateFormatter.formatFullDate(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¡Alquilá para hoy!', style: AppTypography.headlineMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Listos para $todayLabel.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.7),
                    ),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: onSeeMore,
                icon: const Icon(Icons.chevron_right, size: 18),
                label: const Text('Ver más'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: games.take(8).length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final game = games[index];
              return SizedBox(
                width: 280,
                child: GameCardHorizontal(
                  game: game,
                  onTap: () => onGameTap(game),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
