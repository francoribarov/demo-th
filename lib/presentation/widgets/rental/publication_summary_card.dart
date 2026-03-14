import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';

class PublicationSummaryCard extends StatelessWidget {
  const PublicationSummaryCard({
    required this.publication,
    super.key,
  });

  final PublicationListing publication;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        AppTheme.spacingLg,
      ),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(
          AppTheme.radiusLg,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              AppTheme.radiusMd,
            ),
            child: CachedNetworkImage(
              imageUrl: publication.heroImage,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              placeholder: (context, url) => const ColoredBox(
                color: AppColors.gameCream,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.image_not_supported,
              ),
            ),
          ),
          const SizedBox(
            width: AppTheme.spacingMd,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  publication.title,
                  style: AppTypography.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: AppTheme.spacingXs,
                ),
                Text(
                  publication.categoryName,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: AppTheme.spacingXs,
                ),
                Text(
                  CurrencyFormatter.formatPricePerDay(
                    publication.price,
                  ),
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.gameRust,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
