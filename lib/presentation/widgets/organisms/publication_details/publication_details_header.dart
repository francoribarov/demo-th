import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/sliver_page_app_bar.dart';

class PublicationDetailsHeader extends StatelessWidget {
  const PublicationDetailsHeader({
    required this.publication,
    required this.isWishlisted,
    required this.onBack,
    required this.onToggleWishlist,
    required this.onShare,
    super.key,
  });

  final PublicationListing publication;
  final bool isWishlisted;
  final VoidCallback onBack;
  final VoidCallback onToggleWishlist;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return SliverPageAppBar(
      onLeadingPressed: onBack,
      actions: [
        AppBarIconAction(
          icon: isWishlisted ? Icons.favorite : Icons.favorite_border,
          iconColor: isWishlisted ? AppColors.destructive : AppColors.gameBrown,
          tooltip: isWishlisted ? 'Quitar de favoritos' : 'Añadir a favoritos',
          withCircularBackground: true,
          onPressed: onToggleWishlist,
        ),
        AppBarIconAction(
          icon: Icons.share,
          tooltip: 'Compartir',
          withCircularBackground: true,
          onPressed: onShare,
        ),
      ],
      background: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: publication.heroImage,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const ColoredBox(color: AppColors.gameCream),
            errorWidget: (context, url, error) => const MediaPlaceholder(
              icon: Icons.image_not_supported,
              backgroundColor: AppColors.gameCream,
              iconColor: AppColors.gameBrown,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.shadow.withOpacityValue(0.35),
                  const Color(0x00000000),
                  AppColors.background.withOpacityValue(0.95),
                ],
                stops: const [0, 0.55, 1],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
