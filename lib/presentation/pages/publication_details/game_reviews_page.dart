import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/molecules/review_widgets.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_reviews_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/rating_summary_card.dart';

/// Game reviews page matching GameReviews.tsx
class GameReviewsPage extends StatelessWidget {
  /// Creates a [GameReviewsPage] for the provided game id.
  const GameReviewsPage({required this.gameId, super.key});

  /// Game id used to load the reviews.
  final String gameId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameReviewsBloc, GameReviewsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.gameRust),
            ),
          );
        }

        final game = state.game;
        if (game == null) {
          return Scaffold(
            appBar: AppBar(
              leading: AppBarIconAction(
                icon: Icons.arrow_back,
                onPressed: () => context.popOrGo(
                  AppRoutes.publicationDetailsPath(gameId),
                ),
              ),
            ),
            body: Center(
              child: Text(state.errorMessage ?? 'Juego no encontrado'),
            ),
          );
        }

        final reviews = state.filteredReviews;

        // Calculate rating breakdown
        final ratingCounts = <int, int>{};
        for (final review in game.reviews) {
          final stars = review.rating.floor();
          ratingCounts[stars] = (ratingCounts[stars] ?? 0) + 1;
        }

        return Scaffold(
          appBar: AppBar(
            leading: AppBarIconAction(
              icon: Icons.arrow_back,
              onPressed: () => context.popOrGo(
                AppRoutes.publicationDetailsPath(gameId),
              ),
            ),
            title: Text('Reseñas de ${game.title}'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating summary
                RatingSummaryCard(
                  rating: game.rating,
                  reviewsCount: game.reviewsCount,
                  ratingBreakdown: ratingCounts,
                ),

                const SizedBox(height: 24),

                // Filters
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SelectableChip(
                          label: 'Todas',
                          isSelected: state.filterRating == null,
                          onTap: () => context.read<GameReviewsBloc>().add(
                            const GameReviewsEvent.filterRatingChanged(null),
                          ),
                        ),
                      ),
                      ...List.generate(5, (i) {
                        final stars = 5 - i;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: SelectableChip(
                            label: '$stars ⭐',
                            isSelected: state.filterRating == stars,
                            onTap: () => context.read<GameReviewsBloc>().add(
                              GameReviewsEvent.filterRatingChanged(stars),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  '${reviews.length} ${reviews.length == 1 ? 'reseña' : 'reseñas'}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),

                const SizedBox(height: 16),

                if (reviews.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'No hay reseñas con este filtro',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ),
                  )
                else
                  ...reviews.map(
                    (review) => ReviewCard(
                      name: review.name,
                      rating: review.rating,
                      comment: review.comment,
                      date: '', // Role removed
                    ),
                  ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }
}
