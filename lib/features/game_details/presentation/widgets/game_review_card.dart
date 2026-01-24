import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/widgets/review_widgets.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';

/// A card displaying a single game review.
class GameReviewCard extends StatelessWidget {
  /// Creates a [GameReviewCard].
  const GameReviewCard({required this.review, super.key});

  /// The review to display.
  final GameReview review;

  @override
  Widget build(BuildContext context) {
    return ReviewCard(
      name: review.name ?? 'Anónimo',
      rating: review.rating,
      comment: review.comment,
      dateOrRole: '', // Role removed from entity
    );
  }
}
