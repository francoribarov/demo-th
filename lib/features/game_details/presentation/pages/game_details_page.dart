import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/game_atoms.dart';
import 'package:mobile_table_hopping/features/game_details/presentation/bloc/game_details_bloc.dart';
import 'package:mobile_table_hopping/features/game_details/presentation/widgets/availability_checker.dart';
import 'package:mobile_table_hopping/features/game_details/presentation/widgets/game_detail_row.dart';
import 'package:mobile_table_hopping/features/game_details/presentation/widgets/game_details_bottom_bar.dart';
import 'package:mobile_table_hopping/features/game_details/presentation/widgets/game_recommendation_card.dart';
import 'package:mobile_table_hopping/features/game_details/presentation/widgets/game_review_card.dart';

/// Game details page matching ProductDetail.tsx
class GameDetailsPage extends StatefulWidget {
  /// Creates a [GameDetailsPage] for the provided game id.
  const GameDetailsPage({required this.gameId, super.key});

  /// Game id used to load the game details.
  final String gameId;

  @override
  State<GameDetailsPage> createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameDetailsBloc, GameDetailsState>(
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
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.popOrGo(AppRoutes.home),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMessage ?? 'Juego no encontrado',
                    style: AppTypography.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.goHome(),
                    child: const Text('Volver al inicio'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // Image header
              SliverAppBar(
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
                        state.isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: state.isWishlisted ? Colors.red : AppColors.gameBrown,
                      ),
                    ),
                    onPressed: () => context.read<GameDetailsBloc>().add(
                      const GameDetailsEvent.toggleWishlist(),
                    ),
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
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(content: Text('Compartir próximamente')),
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: game.images.isNotEmpty ? game.images.first : '',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const ColoredBox(color: AppColors.gameCream),
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
              ),

              // Content
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacityValue(0.06),
                          blurRadius: 16,
                          offset: const Offset(0, -6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Category and rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.gameCream,
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radius2xl,
                                      ),
                                    ),
                                    child: Text(
                                      game.categories.isNotEmpty ? game.categories.first.name : 'Varios',
                                      style: AppTypography.categoryChip,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.card,
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radius2xl,
                                      ),
                                      border: Border.all(
                                        color: AppColors.gameBrown.withOpacityValue(0.12),
                                      ),
                                    ),
                                    child: GameRatingBadge(
                                      rating: game.rating,
                                      reviewCount: game.reviewsCount,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Title
                              Text(
                                game.title,
                                style: AppTypography.displaySmall,
                              ),

                              const SizedBox(height: 12),

                              // Owner card
                              GestureDetector(
                                onTap: () => context.goToGameOwner(widget.gameId),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppColors.card.withOpacityValue(0.9),
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radiusLg,
                                    ),
                                    border: Border.all(
                                      color: AppColors.gameBrown.withOpacityValue(0.08),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacityValue(
                                          0.04,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: AppColors.gameBrown,
                                        child: Text(
                                          'M',
                                          style: AppTypography.titleMedium.copyWith(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Martín R.',
                                              style: AppTypography.titleSmall,
                                            ),
                                            Text(
                                              'Montevideo • Responde en menos de 1h',
                                              style: AppTypography.bodySmall.copyWith(
                                                color: AppColors.gameBrown.withOpacityValue(0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: AppColors.gameBrown,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Tabs
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.gameCream.withOpacityValue(
                                    0.7,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius2xl,
                                  ),
                                ),
                                child: TabBar(
                                  controller: _tabController,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  labelStyle: AppTypography.labelLarge,
                                  unselectedLabelStyle: AppTypography.labelLarge,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: AppColors.gameBrown,
                                  dividerColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                    color: AppColors.gameRust,
                                    borderRadius: BorderRadius.circular(
                                      AppTheme.radius2xl,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.gameRust.withOpacityValue(
                                          0.35,
                                        ),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  indicatorPadding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  tabs: const [
                                    Tab(text: 'Detalles'),
                                    Tab(text: 'Reseñas'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Tab content
                        AnimatedBuilder(
                          animation: _tabController,
                          builder: (context, _) => IndexedStack(
                            index: _tabController.index,
                            children: [
                              // Details tab
                              Padding(
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
                                      game.description,
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
                                            value: '${game.duration} min',
                                          ),
                                          const Divider(height: 24),
                                          GameDetailRow(
                                            icon: Icons.people_outline,
                                            label: 'Jugadores',
                                            value: game.players,
                                          ),
                                          const Divider(height: 24),
                                          GameDetailRow(
                                            icon: Icons.psychology_outlined,
                                            label: 'Dificultad',
                                            value: game.difficulty,
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    // Rules link
                                    OutlinedButton.icon(
                                      onPressed: () => context.goToGameRules(
                                        widget.gameId,
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
                                      game: game,
                                      startDate: state.checkStartDate,
                                      endDate: state.checkEndDate,
                                      result: state.availabilityResult,
                                      onRangeSelected: (start, end) => context.read<GameDetailsBloc>().add(
                                        GameDetailsEvent.checkDateRangeChanged(
                                          start,
                                          end,
                                        ),
                                      ),
                                      onCheck: () => context.read<GameDetailsBloc>().add(
                                        const GameDetailsEvent.checkAvailabilityPressed(),
                                      ),
                                    ),

                                    const SizedBox(height: 32),

                                    // Recommendations
                                    if (state.recommendations.isNotEmpty) ...[
                                      Text(
                                        'También te puede interesar',
                                        style: AppTypography.headlineMedium,
                                      ),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        height: 200,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.recommendations.length,
                                          separatorBuilder: (_, _) => const SizedBox(width: 12),
                                          itemBuilder: (context, index) {
                                            final rec = state.recommendations[index];
                                            return GameRecommendationCard(
                                              game: rec,
                                              onTap: () => context.goToGame(
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
                              ),

                              // Reviews tab
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Rating summary
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: AppColors.card,
                                        borderRadius: BorderRadius.circular(
                                          AppTheme.radiusLg,
                                        ),
                                        border: Border.all(
                                          color: AppColors.gameBrown.withOpacityValue(0.08),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                game.rating.toStringAsFixed(1),
                                                style: AppTypography.displayMedium,
                                              ),
                                              Row(
                                                children: List.generate(5, (i) {
                                                  return Icon(
                                                    i < game.rating.floor() ? Icons.star : Icons.star_border,
                                                    color: AppColors.gameGold,
                                                    size: 16,
                                                  );
                                                }),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${game.reviewsCount} reseñas',
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

                                    const SizedBox(height: 24),

                                    // Reviews list
                                    ...game.reviewsList.map((review) {
                                      return GameReviewCard(review: review);
                                    }),

                                    // See all reviews
                                    OutlinedButton(
                                      onPressed: () => context.goToGameReviews(
                                        widget.gameId,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        minimumSize: const Size(
                                          double.infinity,
                                          48,
                                        ),
                                      ),
                                      child: const Text(
                                        'Ver todas las reseñas',
                                      ),
                                    ),

                                    const SizedBox(height: 100),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: GameDetailsBottomBar(
            game: game,
            onRent: () => context.goToRental(
              widget.gameId,
              startDate: state.checkStartDate,
              endDate: state.checkEndDate,
              ownerId: game.ownerId,
              deposit: game.deposit,
            ),
          ),
        );
      },
    );
  }
}
