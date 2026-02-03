import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/my_publications_bloc.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/my_publications_empty_view.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/my_publications_error_view.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/my_publications_grid.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/my_publications_loading_view.dart';

/// Page displaying the current user's publications.
class MyPublicationsPage extends StatelessWidget {
  const MyPublicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mis Publicaciones'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.foreground,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<MyPublicationsBloc, MyPublicationsState>(
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
              // Wait a bit for the refresh to complete
              await Future<void>.delayed(const Duration(milliseconds: 500));
            },
            child: MyPublicationsGrid(publications: state.publications),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.goToPublish(),
        backgroundColor: AppColors.gameRust,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Publicación'),
      ),
    );
  }
}
