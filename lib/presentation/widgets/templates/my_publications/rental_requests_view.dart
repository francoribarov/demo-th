import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/my_publications/rental_request_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/confirm_action_dialog.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/my_publications/accept_request_confirmation_sheet.dart';

class RentalRequestsView extends StatelessWidget {
  const RentalRequestsView({
    required this.isLoading,
    required this.requests,
    required this.processingRequestId,
    required this.onAcceptRequest,
    required this.onRejectRequest,
    super.key,
    this.errorMessage,
  });

  final bool isLoading;
  final String? errorMessage;
  final List<RentalRequest> requests;
  final String? processingRequestId;
  final ValueChanged<String> onAcceptRequest;
  final ValueChanged<String> onRejectRequest;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const StateFeedbackView(
        variant: StateFeedbackVariant.loading,
      );
    }
    if (errorMessage != null) {
      return StateFeedbackView(
        variant: StateFeedbackVariant.error,
        message: 'Error: $errorMessage',
      );
    }
    if (requests.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing3xl,
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.gameCream,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mail_outline_rounded,
                  size: 40,
                  color: AppColors.gameBrown,
                ),
              ),
              const SizedBox(
                height: AppTheme.spacingLg,
              ),
              Text(
                'Sin solicitudes por ahora',
                style: AppTypography.titleLarge
                    .copyWith(
                  color: AppColors.gameBrown,
                ),
              ),
              const SizedBox(
                height: AppTheme.spacingSm,
              ),
              Text(
                'Cuando alguien quiera alquilar '
                'uno de tus juegos, '
                'la solicitud aparecerá acá.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium
                    .copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      );
    }
    final dateFormat = DateFormat('dd/MM/yyyy');
    final pendingRequests = requests
        .where(
          (r) =>
              r.status ==
              RentalRequestStatus.pending,
        )
        .toList();
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        final duration = request.endDate
            .difference(request.startDate)
            .inDays;
        final isPending = request.status ==
            RentalRequestStatus.pending;
        final isAccepted = request.status ==
            RentalRequestStatus.accepted;
        final overlapping = isPending
            ? pendingRequests
                .where(
                  (r) => request.overlapsWith(r),
                )
                .toList()
            : <RentalRequest>[];
        return RentalRequestCard(
          key: ValueKey(request.id),
          request: request,
          dateRangeText:
              '${dateFormat.format(request.startDate)}'
              ' - '
              '${dateFormat.format(request.endDate)}',
          durationText: '$duration días',
          showActions: isPending,
          statusLabel: isPending
              ? null
              : (isAccepted
                  ? 'Aceptada'
                  : 'Rechazada'),
          statusIsSuccess: isAccepted,
          isProcessing:
              processingRequestId == request.id,
          overlappingCount: overlapping.length,
          onAccept: () => _confirmAccept(
            context,
            request,
            overlapping,
          ),
          onReject: () => _confirmReject(
            context,
            request,
          ),
        );
      },
    );
  }

  Future<void> _confirmAccept(
    BuildContext context,
    RentalRequest request,
    List<RentalRequest> overlapping,
  ) async {
    final confirmed =
        await AcceptRequestConfirmationSheet.show(
      context: context,
      request: request,
      overlappingRequests: overlapping,
    );
    if (confirmed && context.mounted) {
      onAcceptRequest(request.id);
    }
  }

  Future<void> _confirmReject(
    BuildContext context,
    RentalRequest request,
  ) async {
    final confirmed =
        await ConfirmActionDialog.show(
      context: context,
      title: '¿Rechazar solicitud?',
      message:
          '¿Seguro que querés rechazar la '
          'solicitud de '
          '${request.requester.username}?',
      confirmLabel: 'Rechazar',
      cancelLabel: 'Volver',
      isDestructive: true,
    );
    if (confirmed && context.mounted) {
      onRejectRequest(request.id);
    }
  }
}
