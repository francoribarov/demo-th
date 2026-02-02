import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/publication_card.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/my_publications_bloc.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/rental_requests_view.dart';

/// Page displaying the current user's publications and rental requests.
class MyPublicationsPage extends StatelessWidget {
  const MyPublicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Mis Publicaciones'),
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.foreground,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(64),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.gameBrown.withOpacityValue(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                ),
                child: TabBar(
                  tabs: const [
                    Tab(text: 'Solicitudes'),
                    Tab(text: 'Publicaciones'),
                  ],
                  indicator: BoxDecoration(
                    color: AppColors.gameRust,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: AppColors.gameBrown,
                  dividerColor: Colors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            RentalRequestsView(),
            _PublicationsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.goToPublish(),
          backgroundColor: AppColors.gameRust,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text('Nueva Publicación'),
        ),
      ),
    );
  }
}

class _PublicationsTab extends StatelessWidget {
  const _PublicationsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPublicationsBloc, MyPublicationsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const _LoadingView();
        }

        if (state.errorMessage != null && state.publications.isEmpty) {
          return _ErrorView(
            message: state.errorMessage!,
            onRetry: () => context
                .read<MyPublicationsBloc>()
                .add(const MyPublicationsEvent.started()),
          );
        }

        if (state.publications.isEmpty) {
          return const _EmptyView();
        }

        return RefreshIndicator(
          color: AppColors.gameRust,
          onRefresh: () async {
            context
                .read<MyPublicationsBloc>()
                .add(const MyPublicationsEvent.refresh());
            await Future<void>.delayed(const Duration(milliseconds: 500));
          },
          child: _PublicationsGrid(publications: state.publications),
        );
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: AppColors.gameRust,
          ),
          const SizedBox(height: 16),
          Text(
            'Cargando tus publicaciones...',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacityValue(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 48,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Oops! Algo salió mal',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gameRust,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gameCream,
                    AppColors.gameGold.withOpacityValue(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gameGold.withOpacityValue(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.storefront_outlined,
                size: 56,
                color: AppColors.gameBrown,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Aún no tienes publicaciones',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.foreground,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '¡Publica tu primer juego de mesa y comienza a ganar dinero compartiéndolo con otros jugadores!',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.mutedForeground,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => context.goToPublish(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gameRust,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                ),
                elevation: 4,
              ),
              icon: const Icon(Icons.add),
              label: const Text(
                'Publicar mi primer juego',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PublicationsGrid extends StatelessWidget {
  const _PublicationsGrid({required this.publications});

  final List<PublicationListing> publications;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gameRust.withOpacityValue(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radius2xl),
                  ),
                  child: Text(
                    '${publications.length} publicacion${publications.length == 1 ? '' : 'es'}',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.gameRust,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.35,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final publication = publications[index];
                return PublicationCard(
                  publication: publication,
                  onTap: () => context.goToEditPublication(publication.id),
                );
              },
              childCount: publications.length,
            ),
          ),
        ),
      ],
    );
  }
}
