import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/publication_card.dart';

/// Variant for publication section layout.
enum PublicationSectionVariant {
  /// Grid layout (vertical stack).
  grid,

  /// Carousel layout (horizontal scroll).
  carousel,
}

/// A section displaying a group of publications with a title and description.
class PublicationSection extends StatelessWidget {
  /// Creates a [PublicationSection].
  const PublicationSection({
    required this.title,
    required this.description,
    required this.publications,
    required this.variant,
    this.onPublicationTap,
    this.onCategoryTap,
    super.key,
  });

  /// Title of the section.
  final String title;

  /// Description of the section.
  final String description;

  /// List of publications to display.
  final List<PublicationListing> publications;

  /// Layout variant (grid or carousel).
  final PublicationSectionVariant variant;

  /// Callback when a publication is tapped.
  final void Function(PublicationListing)? onPublicationTap;

  /// Callback when a publication category is tapped.
  final void Function(PublicationListing)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    if (publications.isEmpty) return const SizedBox.shrink();

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
        if (variant == PublicationSectionVariant.carousel)
          SizedBox(
            height: 280, // Height for PublicationCardHorizontal or Vertical?
            // Actually PublicationCardHorizontal is compact, but carousel usually implies full cards.
            // Let's use horizontal scrolling row of *Vertical* cards for carousel,
            // or modify PublicationCardHorizontal to be bigger.
            // Based on design, carousels usually show vertical cards.
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: publications.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final publication = publications[index];
                return SizedBox(
                  width: 280,
                  child: PublicationCard(
                    publication: publication,
                    onTap: () => onPublicationTap?.call(publication),
                    onCategoryTap: () => onCategoryTap?.call(publication),
                  ),
                );
              },
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: publications.map((publication) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PublicationCard(
                    publication: publication,
                    onTap: () => onPublicationTap?.call(publication),
                    onCategoryTap: () => onCategoryTap?.call(publication),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
