import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

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
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          top: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.1)),
        ),
        boxShadow: AppTheme.shadowUp,
      ),
      child: SafeArea(
        child: Row(
          children: [
            GamePriceLabel(price: publication.price),
            const Spacer(),
            AppPrimaryButton(
              label: 'Alquilar ahora',
              onPressed: onRent,
            ),
          ],
        ),
      ),
    );
  }
}
