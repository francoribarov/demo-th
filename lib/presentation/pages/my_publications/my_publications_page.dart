import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/my_publications_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/my_publications/my_publications_empty_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/my_publications/my_publications_error_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/my_publications/my_publications_grid.dart';
import 'package:mobile_table_hopping/presentation/widgets/my_publications/my_publications_loading_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/my_publications/rental_requests_view.dart';

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
          return const MyPublicationsLoadingView();
        }

        if (state.errorMessage != null && state.publications.isEmpty) {
          return MyPublicationsErrorView(
            message: state.errorMessage!,
            onRetry: () => context
                .read<MyPublicationsBloc>()
                .add(const MyPublicationsEvent.started()),
          );
        }

        if (state.publications.isEmpty) {
          return const MyPublicationsEmptyView();
        }

        return RefreshIndicator(
          color: AppColors.gameRust,
          onRefresh: () async {
            context
                .read<MyPublicationsBloc>()
                .add(const MyPublicationsEvent.refresh());
            await Future<void>.delayed(const Duration(milliseconds: 500));
          },
          child: MyPublicationsGrid(publications: state.publications),
        );
      },
    );
  }
}
