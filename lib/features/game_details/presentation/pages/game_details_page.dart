import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/game_details/presentation/bloc/game_details_bloc.dart';

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
            body: Center(child: CircularProgressIndicator(color: AppColors.gameRust)),
          );
        }

        final game = state.game;
        if (game == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.popOrGo(AppRoutes.home)),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage ?? 'Juego no encontrado', style: AppTypography.headlineMedium),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () => context.goHome(), child: const Text('Volver al inicio')),
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
                expandedHeight: 300,
                pinned: true,
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withOpacityValue(0.9), shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back, color: AppColors.gameBrown),
                  ),
                  onPressed: () => context.popOrGo(AppRoutes.home),
                ),
                actions: [
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withOpacityValue(0.9), shape: BoxShape.circle),
                      child: Icon(
                        state.isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: state.isWishlisted ? Colors.red : AppColors.gameBrown,
                      ),
                    ),
                    onPressed: () => context.read<GameDetailsBloc>().add(const GameDetailsEvent.toggleWishlist()),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withOpacityValue(0.9), shape: BoxShape.circle),
                      child: const Icon(Icons.share, color: AppColors.gameBrown),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Compartir próximamente')));
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: game.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const ColoredBox(color: AppColors.gameCream),
                    errorWidget: (context, url, error) =>
                        const ColoredBox(color: AppColors.gameCream, child: Icon(Icons.image_not_supported)),
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category and rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.gameCream,
                                  borderRadius: BorderRadius.circular(AppTheme.radius2xl),
                                ),
                                child: Text(game.category, style: AppTypography.categoryChip),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: AppColors.gameGold, size: 20),
                                  const SizedBox(width: 4),
                                  Text(game.rating.toStringAsFixed(1), style: AppTypography.titleMedium),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${game.reviews})',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.gameBrown.withOpacityValue(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Title
                          Text(game.title, style: AppTypography.displaySmall),

                          const SizedBox(height: 8),

                          // Owner card
                          GestureDetector(
                            onTap: () => context.goToGameOwner(widget.gameId),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.gameCream.withOpacityValue(0.5),
                                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppColors.gameBrown,
                                    child: Text('M', style: AppTypography.titleMedium.copyWith(color: Colors.white)),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Martín R.', style: AppTypography.titleSmall),
                                        Text(
                                          'Montevideo • Responde en menos de 1h',
                                          style: AppTypography.bodySmall.copyWith(
                                            color: AppColors.gameBrown.withOpacityValue(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right, color: AppColors.gameBrown),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Tabs
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.gameCream.withOpacityValue(0.5),
                              borderRadius: BorderRadius.circular(AppTheme.radius2xl),
                            ),
                            child: TabBar(
                              controller: _tabController,
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Description
                                Text(game.description, style: AppTypography.bodyLarge),

                                const SizedBox(height: 24),

                                // Game info
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.card,
                                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                    border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
                                  ),
                                  child: Column(
                                    children: [
                                      _DetailRow(icon: Icons.timer_outlined, label: 'Duración', value: game.duration),
                                      const Divider(height: 24),
                                      _DetailRow(icon: Icons.people_outline, label: 'Jugadores', value: game.players),
                                      const Divider(height: 24),
                                      _DetailRow(
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
                                  onPressed: () => context.goToGameRules(widget.gameId),
                                  icon: const Icon(Icons.menu_book_outlined),
                                  label: const Text('Ver reglas y tutorial'),
                                  style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                                ),

                                const SizedBox(height: 24),

                                // Availability check
                                _AvailabilityChecker(
                                  game: game,
                                  startDate: state.checkStartDate,
                                  endDate: state.checkEndDate,
                                  result: state.availabilityResult,
                                  onStartDateSelected: (date) =>
                                      context.read<GameDetailsBloc>().add(GameDetailsEvent.checkStartDateChanged(date)),
                                  onEndDateSelected: (date) =>
                                      context.read<GameDetailsBloc>().add(GameDetailsEvent.checkEndDateChanged(date)),
                                  onCheck: () => context.read<GameDetailsBloc>().add(
                                    const GameDetailsEvent.checkAvailabilityPressed(),
                                  ),
                                ),

                                const SizedBox(height: 32),

                                // Recommendations
                                if (state.recommendations.isNotEmpty) ...[
                                  Text('También te puede interesar', style: AppTypography.headlineMedium),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.recommendations.length,
                                      separatorBuilder: (_, _) => const SizedBox(width: 12),
                                      itemBuilder: (context, index) {
                                        final rec = state.recommendations[index];
                                        return _RecommendationCard(
                                          game: rec,
                                          onTap: () => context.goToGame(rec.id.toString()),
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Rating summary
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.gameCream.withOpacityValue(0.5),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                                  ),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(game.rating.toStringAsFixed(1), style: AppTypography.displayMedium),
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
                                            '${game.reviews} reseñas',
                                            style: AppTypography.bodySmall.copyWith(
                                              color: AppColors.gameBrown.withOpacityValue(0.7),
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
                                  return _ReviewCard(review: review);
                                }),

                                // See all reviews
                                OutlinedButton(
                                  onPressed: () => context.goToGameReviews(widget.gameId),
                                  style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                                  child: const Text('Ver todas las reseñas'),
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
            ],
          ),
          bottomNavigationBar: _BottomBar(
            game: game,
            onRent: () =>
                context.goToRental(widget.gameId, startDate: state.checkStartDate, endDate: state.checkEndDate),
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.gameBrown),
        const SizedBox(width: 12),
        Text(label, style: AppTypography.bodyMedium),
        const Spacer(),
        Text(value, style: AppTypography.titleSmall),
      ],
    );
  }
}

class _AvailabilityChecker extends StatelessWidget {
  const _AvailabilityChecker({
    required this.game,
    required this.onStartDateSelected,
    required this.onEndDateSelected,
    required this.onCheck,
    this.startDate,
    this.endDate,
    this.result,
  });
  final Game game;
  final String? startDate;
  final String? endDate;
  final bool? result;
  final void Function(String) onStartDateSelected;
  final void Function(String) onEndDateSelected;
  final VoidCallback onCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.event_available, color: AppColors.gameRust),
              const SizedBox(width: 8),
              Text('Consultá disponibilidad', style: AppTypography.titleMedium),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _DateButton(
                  label: 'Inicio',
                  value: startDate,
                  onTap: () async {
                    final date = await _selectDate(context);
                    if (date != null) onStartDateSelected(date);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _DateButton(
                  label: 'Fin',
                  value: endDate,
                  onTap: () async {
                    final date = await _selectDate(context);
                    if (date != null) onEndDateSelected(date);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: startDate != null && endDate != null ? onCheck : null,
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
            child: const Text('Verificar disponibilidad'),
          ),
          if (result != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: result! ? Colors.green[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    result! ? Icons.check_circle : Icons.cancel,
                    color: result! ? Colors.green[700] : Colors.red[600],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      result! ? '¡Disponible para esas fechas!' : 'No disponible para esas fechas',
                      style: AppTypography.bodyMedium.copyWith(color: result! ? Colors.green[700] : Colors.red[600]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<String?> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.gameRust,
              onSurface: AppColors.gameBrown,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      return DateFormatter.toIsoString(picked);
    }
    return null;
  }
}

class _DateButton extends StatelessWidget {
  const _DateButton({required this.label, required this.onTap, this.value});
  final String label;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTypography.labelSmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.6))),
            const SizedBox(height: 4),
            Text(
              value ?? 'Seleccionar',
              style: AppTypography.bodyMedium.copyWith(
                color: value != null ? AppColors.gameBrown : AppColors.gameBrown.withOpacityValue(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.review});
  final GameReview review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                child: Text(review.name[0], style: AppTypography.labelMedium),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.name, style: AppTypography.titleSmall),
                    Text(
                      review.role,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.6)),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(i < review.rating ? Icons.star : Icons.star_border, color: AppColors.gameGold, size: 14);
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(review.comment, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({required this.game, required this.onTap});
  final Game game;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(imageUrl: game.image, height: 100, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(game.title, style: AppTypography.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 12, color: AppColors.gameGold),
                      const SizedBox(width: 2),
                      Text(game.rating.toStringAsFixed(1), style: AppTypography.labelSmall),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.game, required this.onRent});
  final Game game;
  final VoidCallback onRent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.1))),
        boxShadow: [BoxShadow(color: Colors.black.withOpacityValue(0.1), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Desde',
                  style: AppTypography.labelSmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.6)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(CurrencyFormatter.formatUYU(game.price), style: AppTypography.price),
                    const SizedBox(width: 4),
                    Text(
                      '/ día',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: onRent,
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
              child: const Text('Alquilar ahora'),
            ),
          ],
        ),
      ),
    );
  }
}
