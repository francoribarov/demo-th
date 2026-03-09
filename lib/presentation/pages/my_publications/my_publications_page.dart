import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/my_publications_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_event.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_state.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/rental_requests/rental_requests_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/tabbed_page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/my_publications_empty_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/my_publications_error_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/my_publications_grid.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/my_publications_loading_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/owner_rentals_list.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/feedback_messenger.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/my_publications/rental_requests_view.dart';

/// Page displaying the current user's publications and rental requests.
class MyPublicationsPage extends StatelessWidget {
  const MyPublicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const TabbedPageAppBar(
          title: Text('Mis Publicaciones'),
          tabs: [
            Tab(text: 'Solicitudes'),
            Tab(text: 'Alquileres'),
            Tab(text: 'Publicaciones'),
          ],
        ),
        body: const TabBarView(
          children: [
            _RentalRequestsTab(),
            _OwnerRentalsTab(),
            _PublicationsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.goToPublish(),
          backgroundColor: AppColors.gameRust,
          foregroundColor: AppColors.primaryForeground,
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
            onRetry: () => context.read<MyPublicationsBloc>().add(
              const MyPublicationsEvent.started(),
            ),
          );
        }

        if (state.publications.isEmpty) {
          return MyPublicationsEmptyView(
            onPublish: () => context.goToPublish(),
          );
        }

        return RefreshIndicator(
          color: AppColors.gameRust,
          onRefresh: () async {
            context.read<MyPublicationsBloc>().add(
              const MyPublicationsEvent.refresh(),
            );
            await Future<void>.delayed(const Duration(milliseconds: 500));
          },
          child: MyPublicationsGrid(
            publications: state.publications,
            onEditPublication: (publicationId) =>
                context.goToEditPublication(publicationId),
          ),
        );
      },
    );
  }
}

class _OwnerRentalsTab extends StatelessWidget {
  const _OwnerRentalsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerRentalsBloc, OwnerRentalsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gameRust),
          );
        }

        if (state.errorMessage != null && state.activeRentals.isEmpty && state.upcomingRentals.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.gameRust,
                ),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage!,
                  style: const TextStyle(color: AppColors.gameBrown),
                ),
                TextButton(
                  onPressed: () => context.read<OwnerRentalsBloc>().add(
                    const OwnerRentalsEvent.refresh(),
                  ),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        return OwnerRentalsList(
          activeRentals: state.activeRentals,
          upcomingRentals: state.upcomingRentals,
        );
      },
    );
  }
}

class _RentalRequestsTab extends StatelessWidget {
  const _RentalRequestsTab();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalRequestsBloc, RentalRequestsState>(
      listenWhen: (previous, current) =>
          current.mapOrNull(success: (s) => s.feedbackNotice) != null &&
          previous.mapOrNull(success: (s) => s.feedbackNotice) == null,
      listener: (context, state) {
        final notice = state.mapOrNull(success: (s) => s.feedbackNotice);
        if (notice == null) return;
        _showNotice(context, notice);
        context.read<RentalRequestsBloc>().add(
          const RentalRequestsEvent.messageDismissed(),
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => RentalRequestsView(
            isLoading: true,
            requests: const [],
            processingRequestId: null,
            onAcceptRequest: (_) {},
            onRejectRequest: (_) {},
          ),
          loading: () => RentalRequestsView(
            isLoading: true,
            requests: const [],
            processingRequestId: null,
            onAcceptRequest: (_) {},
            onRejectRequest: (_) {},
          ),
          failure: (message) => RentalRequestsView(
            isLoading: false,
            errorMessage: message,
            requests: const [],
            processingRequestId: null,
            onAcceptRequest: (_) {},
            onRejectRequest: (_) {},
          ),
          success: (requests, processingRequestId, feedbackNotice) =>
              RentalRequestsView(
                isLoading: false,
                requests: requests,
                processingRequestId: processingRequestId,
                onAcceptRequest: (requestId) {
                  context.read<RentalRequestsBloc>().add(
                    RentalRequestsEvent.accepted(requestId),
                  );
                },
                onRejectRequest: (requestId) {
                  context.read<RentalRequestsBloc>().add(
                    RentalRequestsEvent.rejected(requestId),
                  );
                },
              ),
        );
      },
    );
  }

  void _showNotice(BuildContext context, FeedbackNotice notice) {
    switch (notice.severity) {
      case FeedbackSeverity.success:
        FeedbackMessenger.showSuccess(context, message: notice.message);
        return;
      case FeedbackSeverity.error:
        FeedbackMessenger.showError(context, message: notice.message);
        return;
      case FeedbackSeverity.warning:
        FeedbackMessenger.showWarning(context, message: notice.message);
        return;
      case FeedbackSeverity.info:
        FeedbackMessenger.showInfo(context, message: notice.message);
        return;
    }
  }
}
