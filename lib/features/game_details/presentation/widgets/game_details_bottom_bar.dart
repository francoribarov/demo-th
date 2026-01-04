import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

/// Bottom bar for the game details page with price and rent button.
class GameDetailsBottomBar extends StatelessWidget {
  /// Creates a [GameDetailsBottomBar].
  const GameDetailsBottomBar({
    required this.game,
    required this.onRent,
    super.key,
  });

  /// The game being displayed.
  final Game game;

  /// Callback when the rent button is pressed.
  final VoidCallback onRent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          top: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.1)),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacityValue(0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Desde',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.6),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      CurrencyFormatter.formatUYU(game.price),
                      style: AppTypography.price,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '/ día',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onRent,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text('Alquilar ahora'),
            ),
          ],
        ),
      ),
    );
  }
}
