import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';

class PublicationDetailsHeader extends StatelessWidget {
  const PublicationDetailsHeader({
    required this.publication,
    required this.isWishlisted,
    required this.onToggleWishlist,
    required this.onShare,
    super.key,
  });

  final PublicationListing publication;
  final bool isWishlisted;
  final VoidCallback onToggleWishlist;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacityValue(0.9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.gameBrown,
          ),
        ),
        onPressed: () => context.popOrGo(AppRoutes.home),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacityValue(0.9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isWishlisted ? Icons.favorite : Icons.favorite_border,
              color: isWishlisted ? Colors.red : AppColors.gameBrown,
            ),
          ),
          onPressed: onToggleWishlist,
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacityValue(0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.share,
              color: AppColors.gameBrown,
            ),
          ),
          onPressed: onShare,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: publication.heroImage,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const ColoredBox(color: AppColors.gameCream),
              errorWidget: (context, url, error) => const ColoredBox(
                color: AppColors.gameCream,
                child: Icon(Icons.image_not_supported),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacityValue(0.35),
                    Colors.transparent,
                    AppColors.background.withOpacityValue(0.95),
                  ],
                  stops: const [0, 0.55, 1],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
