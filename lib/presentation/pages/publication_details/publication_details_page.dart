import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/blocs/auth/auth_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/publication_details_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/publication_details/publication_details_bottom_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/publication_details/publication_details_header.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/publication_details/publication_details_info_header.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/feedback_messenger.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publication_details/publication_details_error_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publication_details/publication_details_loading_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publication_details/publication_details_tab_content.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publication_details/publication_reviews_tab_content.dart';

/// Game details page matching ProductDetail.tsx
class PublicationDetailsPage extends StatefulWidget {
  /// Creates a [PublicationDetailsPage] for the provided publication id.
  const PublicationDetailsPage({required this.publicationId, super.key});

  /// Publication id used to load the details.
  final String publicationId;

  @override
  State<PublicationDetailsPage> createState() => _PublicationDetailsPageState();
}

class _PublicationDetailsPageState extends State<PublicationDetailsPage>
    with SingleTickerProviderStateMixin {
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
    return BlocBuilder<PublicationDetailsBloc, PublicationDetailsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const PublicationDetailsLoadingView();
        }

        final publication = state.publication;
        final gameDetail = state.gameDetail;

        if (publication == null || gameDetail == null) {
          return PublicationDetailsErrorView(
            errorMessage: state.errorMessage,
            onBack: () => context.popOrGo(AppRoutes.home),
            onGoHome: context.goHome,
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // Image header
              PublicationDetailsHeader(
                publication: publication,
                isWishlisted: state.isWishlisted,
                onBack: () => context.popOrGo(AppRoutes.home),
                onToggleWishlist: () => context
                    .read<PublicationDetailsBloc>()
                    .add(const PublicationDetailsEvent.toggleWishlist()),
                onShare: () => FeedbackMessenger.showInfo(
                  context,
                  message: 'Compartir próximamente',
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -24),
                  child: Column(
                    children: [
                      PublicationDetailsInfoHeader(
                        publication: publication,
                        gameDetail: gameDetail,
                        tabController: _tabController,
                        onOwnerTap: () => context.goToGameOwner(publication.id),
                      ),
                      ColoredBox(
                        color: AppColors.background,
                        child: AnimatedBuilder(
                          animation: _tabController,
                          builder: (context, _) => IndexedStack(
                            index: _tabController.index,
                            children: [
                              // Details tab
                              PublicationDetailsTabContent(
                                gameDetail: gameDetail,
                                publication: publication,
                                checkStartDate: state.checkStartDate,
                                checkEndDate: state.checkEndDate,
                                availabilityResult: state.availabilityResult,
                                recommendations: state.recommendations,
                                onDateRangeSelected: (start, end) {
                                  context.read<PublicationDetailsBloc>().add(
                                    PublicationDetailsEvent.checkDateRangeChanged(
                                      start ?? '',
                                      end ?? '',
                                    ),
                                  );
                                },
                                onCheckAvailability: () {
                                  context.read<PublicationDetailsBloc>().add(
                                    const PublicationDetailsEvent.checkAvailabilityPressed(),
                                  );
                                },
                                onViewRules: () =>
                                    context.goToGameRules(publication.id),
                                onOpenRecommendation:
                                    (recommendedPublication) =>
                                        context.goToPublication(
                                          recommendedPublication.id,
                                        ),
                              ),
                              // Reviews tab
                              PublicationReviewsTabContent(
                                gameDetail: gameDetail,
                                onViewAllReviews: () => context.goToGameReviews(
                                  widget.publicationId,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: PublicationDetailsBottomBar(
            publication: publication,
            onRent: () {
              final authBloc = context.read<AuthBloc>();
              if (!authBloc.state.isAuthenticated) {
                final currentPath = publicationDetailsPath(
                  widget.publicationId,
                );
                context.goToLogin(from: currentPath);
                return;
              }

              context.goToRental(
                widget.publicationId,
                startDate: state.checkStartDate,
                endDate: state.checkEndDate,
                ownerId: publication.ownerId,
                deposit: publication.deposit,
              );
            },
          ),
        );
      },
    );
  }
}
