import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/my_publications_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/rental_requests/rental_requests_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/badged_tab_label.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/tabbed_page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/my_publications_empty_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/my_publications_error_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/my_publications_grid.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/my_publications_loading_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/my_publications/owner_rentals_error_view.dart';
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
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const TabbedPageAppBar(
          title: Text('Mis Publicaciones'),
          tabs: [
            // Solicitudes tab — shows badge with pending count
            BlocBuilder<RentalRequestsBloc, RentalRequestsState>(
              builder: (context, state) {
                final count =
                    state.mapOrNull(success: (s) => s.requests.length) ?? 0;
                return Tab(
                  child: BadgedTabLabel(label: 'Solicitudes', count: count),
                );
              },
            ),
            const Tab(text: 'Alquileres'),
            const Tab(text: 'Publicaciones'),
          ],
        ),
        body: const TabBarView(
          children: [
            _RentalRequestsTab(),
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

// ---------------------------------------------------------------------------
// Publications tab
// ---------------------------------------------------------------------------

class _PublicationsTab extends StatelessWidget {
  const _PublicationsTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPublicationsBloc, MyPublicationsState>(
      builder: (context, state) {
        if (state.isLoading) return const MyPublicationsLoadingView();

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
            onEditPublication: (id) => context.goToEditPublication(id),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Owner rentals tab
// ---------------------------------------------------------------------------

class _OwnerRentalsTab extends StatelessWidget {
  const _OwnerRentalsTab();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerRentalsBloc, OwnerRentalsState>(
      listenWhen: (prev, curr) =>
          (curr.successMessage != null && prev.successMessage == null) ||
          (curr.errorMessage != null &&
              prev.errorMessage == null &&
              !curr.isLoading),
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        if (state.successMessage != null) {
          messenger.showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: AppColors.statusAccepted,
            ),
          );
          context.read<OwnerRentalsBloc>().add(
            const OwnerRentalsEvent.messageDismissed(),
          );
        }
        if (state.errorMessage != null && !state.isLoading) {
          messenger.showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: AppColors.statusRejected,
            ),
          );
          context.read<OwnerRentalsBloc>().add(
            const OwnerRentalsEvent.messageDismissed(),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.gameRust),
          );
        }

        final isEmpty =
            state.activeRentals.isEmpty &&
            state.upcomingRentals.isEmpty &&
            state.returnedRentals.isEmpty;

        if (state.errorMessage != null && isEmpty) {
          return OwnerRentalsErrorView(
            message: state.errorMessage!,
            onRetry: () => context.read<OwnerRentalsBloc>().add(
              const OwnerRentalsEvent.refresh(),
            ),
          );
        }

        return OwnerRentalsList(
          returnedRentals: state.returnedRentals,
          activeRentals: state.activeRentals,
          upcomingRentals: state.upcomingRentals,
          dropOffTickets: state.dropOffTickets,
          onConfirmReturn: (rentalId) => context.read<OwnerRentalsBloc>().add(
            OwnerRentalsEvent.confirmReturn(rentalId),
          ),
          onReportReturn: (_) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Todavía no se implementó.'),
              backgroundColor: AppColors.statusPending,
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Rental requests tab
// ---------------------------------------------------------------------------

class _RentalRequestsTab extends StatelessWidget {
  const _RentalRequestsTab();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalRequestsBloc, RentalRequestsState>(
      listenWhen: (prev, curr) =>
          curr.mapOrNull(success: (s) => s.feedbackNotice) != null &&
          prev.mapOrNull(success: (s) => s.feedbackNotice) == null,
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
          initial: _loadingView,
          loading: _loadingView,
          failure: (message) => RentalRequestsView(
            isLoading: false,
            errorMessage: message,
            requests: const [],
            processingRequestId: null,
            onAcceptRequest: (_) {},
            onRejectRequest: (_) {},
          ),
          success: (requests, processingRequestId, _) => RentalRequestsView(
            isLoading: false,
            requests: requests,
            processingRequestId: processingRequestId,
            onAcceptRequest: (id) => context.read<RentalRequestsBloc>().add(
              RentalRequestsEvent.accepted(id),
            ),
            onRejectRequest: (id) => context.read<RentalRequestsBloc>().add(
              RentalRequestsEvent.rejected(id),
            ),
          ),
        );
      },
    );
  }

  Widget _loadingView() => RentalRequestsView(
    isLoading: true,
    requests: const [],
    processingRequestId: null,
    onAcceptRequest: (_) {},
    onRejectRequest: (_) {},
  );

  void _showNotice(BuildContext context, FeedbackNotice notice) {
    switch (notice.severity) {
      case FeedbackSeverity.success:
        FeedbackMessenger.showSuccess(context, message: notice.message);
      case FeedbackSeverity.error:
        FeedbackMessenger.showError(context, message: notice.message);
      case FeedbackSeverity.warning:
        FeedbackMessenger.showWarning(context, message: notice.message);
      case FeedbackSeverity.info:
        FeedbackMessenger.showInfo(context, message: notice.message);
    }
  }
}
