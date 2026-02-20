import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/widgets/game_atoms.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

/// Bottom bar for the game details page with price and rent button.
class PublicationDetailsBottomBar extends StatelessWidget {
  /// Creates a [PublicationDetailsBottomBar].
  const PublicationDetailsBottomBar({
    required this.publication,
    required this.onRent,
    super.key,
  });

  /// The publication being displayed.
  final PublicationListing publication;

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
            GamePriceLabel(price: publication.price),
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
