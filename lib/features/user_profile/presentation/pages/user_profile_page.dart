import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/user_profile/presentation/bloc/user_profile_bloc.dart';

/// User profile page matching UserProfile.tsx
class UserProfilePage extends StatelessWidget {
  /// Creates the user profile page for a given game id.
  const UserProfilePage({required this.gameId, super.key});

  /// Game id used to load the owner profile details.
  final String gameId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
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
            appBar: AppBar(title: const Text('Propietario')),
            body: Center(
              child: Text(state.errorMessage ?? 'No se encontró el juego'),
            ),
          );
        }

        // Mock owner data (in a real app, this would come from a user repository)
        const ownerName = 'Martín Rodriguez';
        const location = 'Montevideo, Uruguay';
        const responseTime = 'menos de 1 hora';
        const memberSince = 'abril 2023';
        const completedRentals = 47;
        const rating = 4.8;
        const totalReviews = 32;

        // Rating breakdown (mock data)
        final ratingBreakdown = {5: 24, 4: 6, 3: 2, 2: 0, 1: 0};

        // Mock reviews
        final reviews = [
          (
            name: 'Laura P.',
            rating: 5.0,
            comment:
                'Excelente experiencia. El juego llegó en perfecto estado y Martín fue muy atento con todas mis consultas.',
            date: 'hace 2 semanas',
          ),
          (
            name: 'Diego M.',
            rating: 5.0,
            comment:
                'Muy recomendable. La comunicación fue rápida y el juego estaba impecable.',
            date: 'hace 1 mes',
          ),
          (
            name: 'Camila S.',
            rating: 4.0,
            comment:
                'Buen servicio, el juego estaba completo. La entrega demoró un poco pero todo bien.',
            date: 'hace 1 mes',
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.popOrGo('/game/$gameId'),
            ),
            title: const Text('Perfil del dueño'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.gameCream.withOpacityValue(0.5),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.gameBrown,
                        child: Text(
                          ownerName[0],
                          style: AppTypography.displayMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ownerName,
                              style: AppTypography.headlineMedium,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: AppColors.gameBrown,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  location,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.gameBrown.withOpacityValue(
                                      0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: AppColors.gameBrown,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Responde en $responseTime',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.gameBrown.withOpacityValue(
                                      0.7,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Stats
                Row(
                  children: [
                    const Expanded(
                      child: _StatCard(
                        icon: Icons.calendar_today,
                        value: memberSince,
                        label: 'Miembro desde',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.handshake,
                        value: completedRentals.toString(),
                        label: 'Alquileres completados',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Rating summary
                Text('VALORACIONES', style: AppTypography.sectionHeader),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(
                      color: AppColors.gameBrown.withOpacityValue(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Overall rating
                      Column(
                        children: [
                          Text(
                            rating.toStringAsFixed(1),
                            style: AppTypography.displayLarge,
                          ),
                          Row(
                            children: List.generate(5, (i) {
                              return Icon(
                                i < rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: AppColors.gameGold,
                                size: 20,
                              );
                            }),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$totalReviews reseñas',
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
                            final count = ratingBreakdown[stars] ?? 0;
                            final percentage = totalReviews > 0
                                ? count / totalReviews
                                : 0.0;
                            return _RatingBar(
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

                // Reviews
                Text('RESEÑAS', style: AppTypography.sectionHeader),
                const SizedBox(height: 12),
                ...reviews.map(
                  (review) => _ReviewCard(
                    name: review.name,
                    rating: review.rating,
                    comment: review.comment,
                    date: review.date,
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.gameRust),
          const SizedBox(height: 8),
          Text(value, style: AppTypography.titleMedium),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  const _RatingBar({
    required this.stars,
    required this.percentage,
    required this.count,
  });
  final int stars;
  final double percentage;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text('$stars', style: AppTypography.labelSmall),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.gameBrown.withOpacityValue(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.gameGold,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 24,
            child: Text(
              '$count',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({
    required this.name,
    required this.rating,
    required this.comment,
    required this.date,
  });
  final String name;
  final double rating;
  final String comment;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.gameCream,
                child: Text(
                  name[0].toUpperCase(),
                  style: AppTypography.labelMedium,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTypography.titleSmall),
                    Text(
                      date,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gameBrown.withOpacityValue(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < rating ? Icons.star : Icons.star_border,
                    color: AppColors.gameGold,
                    size: 14,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(comment, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
