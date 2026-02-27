import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/app_secondary_button.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/catalog/publication_card.dart';

/// Section displaying publications available for rent today.
class AvailableTodaySection extends StatelessWidget {
  /// Creates an [AvailableTodaySection].
  const AvailableTodaySection({
    required this.publications,
    required this.onSeeMore,
    required this.onPublicationTap,
    super.key,
  });

  /// List of publications available today.
  final List<PublicationListing> publications;

  /// Callback when "See more" is pressed.
  final VoidCallback onSeeMore;

  /// Callback when a publication is tapped.
  final void Function(PublicationListing) onPublicationTap;

  @override
  Widget build(BuildContext context) {
    if (publications.isEmpty) return const SizedBox.shrink();

    final now = DateTime.now();
    final todayLabel = DateFormatter.formatFullDate(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Alquilá para hoy!',
                    style: AppTypography.headlineMedium,
                  ),
                  const SizedBox(height: AppTheme.spacingXs),
                  Text(
                    'Listos para $todayLabel.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
              AppSecondaryButton(
                label: 'Ver más',
                icon: Icons.chevron_right,
                onPressed: onSeeMore,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacingLg),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
            itemCount: publications.take(8).length,
            separatorBuilder: (_, _) => const SizedBox(width: AppTheme.spacingMd),
            itemBuilder: (context, index) {
              final publication = publications[index];
              return SizedBox(
                width: 280,
                child: PublicationCardHorizontal(
                  publication: publication,
                  onTap: () => onPublicationTap(publication),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
