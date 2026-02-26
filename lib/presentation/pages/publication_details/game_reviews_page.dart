import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/molecules/review_widgets.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_reviews_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/selectable_chip.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';

/// Game reviews page matching GameReviews.tsx
class GameReviewsPage extends StatefulWidget {
  /// Creates a [GameReviewsPage] for the provided game id.
  const GameReviewsPage({required this.gameId, super.key});

  /// Game id used to load the reviews.
  final String gameId;

  @override
  State<GameReviewsPage> createState() => _GameReviewsPageState();
}

class _GameReviewsPageState extends State<GameReviewsPage> {
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
          final publicationPath = publicationDetailsPath(widget.gameId);
          return Scaffold(
            appBar: PageAppBar(
              title: const Text('Reseñas'),
              onLeadingPressed: () => context.popOrGo(publicationPath),
            ),
            body: Center(
              child: Text(state.errorMessage ?? 'Juego no encontrado'),
            ),
          );
        }

        final reviews = state.filteredReviews;
        final publicationPath = publicationDetailsPath(widget.gameId);

        // Calculate rating breakdown
        final ratingCounts = <int, int>{};
        for (final review in game.reviews) {
          final stars = review.rating.floor();
          ratingCounts[stars] = (ratingCounts[stars] ?? 0) + 1;
        }

        return Scaffold(
          appBar: PageAppBar(
            title: Text('Reseñas de ${game.title}'),
            onLeadingPressed: () => context.popOrGo(publicationPath),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating summary
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.gameCream.withOpacityValue(0.5),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                  child: Row(
                    children: [
                      // Overall rating
                      Column(
                        children: [
                          Text(
                            game.rating.toStringAsFixed(1),
                            style: AppTypography.displayLarge,
                          ),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < game.rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: AppColors.gameGold,
                                size: 20,
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${game.reviewsCount} reseñas',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gameBrown.withOpacityValue(0.7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 32),
                      // Rating breakdown
                      Expanded(
                        child: Column(
                          children: List.generate(5, (i) {
                            final stars = 5 - i;
                            final count = ratingCounts[stars] ?? 0;
                            final percentage = game.reviews.isNotEmpty
                                ? count / game.reviews.length
                                : count /
                                      game.reviews.length.clamp(
                                        1,
                                        double.infinity,
                                      );
                            return ReviewRatingBar(
                              stars: stars,
                              percentage: percentage,
                              count: count,
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
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
                    color: AppColors.gameBrown.withOpacityValue(0.7),
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
                          color: AppColors.gameBrown.withOpacityValue(0.7),
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
