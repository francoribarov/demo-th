import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/publication_details_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/publication_details/availability_checker.dart';
import 'package:mobile_table_hopping/presentation/widgets/publication_details/game_recommendation_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/publication_details/publication_detail_row.dart';

class PublicationDetailsTabContent extends StatelessWidget {
  const PublicationDetailsTabContent({
    required this.gameDetail,
    required this.publication,
    required this.checkStartDate,
    required this.checkEndDate,
    required this.availabilityResult,
    required this.recommendations,
    super.key,
  });

  final Game gameDetail;
  final PublicationListing publication;
  final String checkStartDate;
  final String checkEndDate;
  final bool? availabilityResult;
  final List<PublicationListing> recommendations;

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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(
                AppTheme.radiusLg,
              ),
              border: Border.all(
                color: AppColors.gameBrown.withOpacityValue(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacityValue(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
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
          OutlinedButton.icon(
            onPressed: () => context.goToGameRules(
              publication.id,
            ),
            icon: const Icon(
              Icons.menu_book_outlined,
            ),
            label: const Text(
              'Ver reglas y tutorial',
            ),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                48,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Availability check
          AvailabilityChecker(
            publication: publication,
            startDate: checkStartDate,
            endDate: checkEndDate,
            result: availabilityResult,
            onRangeSelected: (start, end) =>
                context.read<PublicationDetailsBloc>().add(
                      PublicationDetailsEvent.checkDateRangeChanged(
                        start ?? '',
                        end ?? '',
                      ),
                    ),
            onCheck: () => context.read<PublicationDetailsBloc>().add(
                  const PublicationDetailsEvent.checkAvailabilityPressed(),
                ),
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
                    onTap: () => context.goToPublication(
                      rec.id,
                    ),
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
