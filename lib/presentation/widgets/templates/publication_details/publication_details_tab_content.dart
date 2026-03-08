import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/publication_details/game_recommendation_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/publication_details/publication_detail_row.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/publication_details/availability_checker.dart';

class PublicationDetailsTabContent extends StatelessWidget {
  const PublicationDetailsTabContent({
    required this.gameDetail,
    required this.publication,
    required this.checkStartDate,
    required this.checkEndDate,
    required this.availabilityResult,
    required this.recommendations,
    required this.onDateRangeSelected,
    required this.onCheckAvailability,
    required this.onViewRules,
    required this.onOpenRecommendation,
    super.key,
  });

  final Game gameDetail;
  final PublicationListing publication;
  final String checkStartDate;
  final String checkEndDate;
  final bool? availabilityResult;
  final List<PublicationListing> recommendations;
  final void Function(String? startDate, String? endDate) onDateRangeSelected;
  final VoidCallback onCheckAvailability;
  final VoidCallback onViewRules;
  final ValueChanged<PublicationListing> onOpenRecommendation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descripción',
            style: AppTypography.sectionHeader,
          ),
          const SizedBox(height: 8),
          Text(
            gameDetail.description,
            style: AppTypography.bodyLarge,
          ),

          const SizedBox(height: 24),

          // Game info
          SurfaceCard(
            padding: const EdgeInsets.all(16),
            borderColor: AppColors.gameBrown.withOpacityValue(0.1),
            boxShadow: AppTheme.shadowMd,
            child: Column(
              children: [
                GameDetailRow(
                  icon: Icons.timer_outlined,
                  label: 'Duración',
                  value: '${gameDetail.duration} min',
                ),
                const Divider(height: 24),
                GameDetailRow(
                  icon: Icons.people_outline,
                  label: 'Jugadores',
                  value: gameDetail.players,
                ),
                const Divider(height: 24),
                GameDetailRow(
                  icon: Icons.psychology_outlined,
                  label: 'Dificultad',
                  value: gameDetail.difficulty,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Rules link
          AppSecondaryButton(
            onPressed: onViewRules,
            icon: Icons.menu_book_outlined,
            label: 'Ver reglas y tutorial',
            minimumSize: const Size(
              double.infinity,
              48,
            ),
          ),

          const SizedBox(height: 24),

          // Availability check
          AvailabilityChecker(
            publication: publication,
            startDate: checkStartDate,
            endDate: checkEndDate,
            result: availabilityResult,
            onRangeSelected: onDateRangeSelected,
            onCheck: onCheckAvailability,
          ),

          const SizedBox(height: 32),

          // Recommendations
          if (recommendations.isNotEmpty) ...[
            Text(
              'También te puede interesar',
              style: AppTypography.headlineMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recommendations.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final rec = recommendations[index];
                  return GameRecommendationCard(
                    publication: rec,
                    onTap: () => onOpenRecommendation(rec),
                  );
                },
              ),
            ),
          ],

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
