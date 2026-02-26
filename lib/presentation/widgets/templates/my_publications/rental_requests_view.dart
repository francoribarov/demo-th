import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/my_publications/rental_request_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/confirm_action_dialog.dart';

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
      return const StateFeedbackView(variant: StateFeedbackVariant.loading);
    }
    if (errorMessage != null) {
      return StateFeedbackView(
        variant: StateFeedbackVariant.error,
        message: 'Error: $errorMessage',
      );
    }
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: AppColors.gameBrown.withOpacityValue(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay solicitudes pendientes',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.gameBrown,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tus solicitudes de alquiler aparecerán aquí',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.7),
              ),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];
        return RentalRequestCard(
          request: request,
          isProcessing: processingRequestId == request.id,
          onAccept: () => _confirmAccept(context, request),
          onReject: () => _confirmReject(context, request),
        );
      },
    );
  }

  Future<void> _confirmAccept(
    BuildContext context,
    RentalRequest request,
  ) async {
    final confirmed = await ConfirmActionDialog.show(
      context: context,
      title: '¿Aceptar solicitud?',
      message:
          '¿Confirmas que quieres aceptar la solicitud de ${request.requester.username}?',
      confirmLabel: 'Aceptar',
      cancelLabel: 'Cancelar',
    );
    if (confirmed && context.mounted) {
      onAcceptRequest(request.id);
    }
  }

  Future<void> _confirmReject(
    BuildContext context,
    RentalRequest request,
  ) async {
    final confirmed = await ConfirmActionDialog.show(
      context: context,
      title: '¿Rechazar solicitud?',
      message:
          '¿Confirmas que quieres rechazar la solicitud de ${request.requester.username}?',
      confirmLabel: 'Rechazar',
      cancelLabel: 'Cancelar',
      isDestructive: true,
    );
    if (confirmed && context.mounted) {
      onRejectRequest(request.id);
    }
  }
}
