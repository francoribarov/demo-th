import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/app_alert_dialog.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/rental_requests_bloc.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/rental_request_card.dart';

class RentalRequestsView extends StatelessWidget {
  const RentalRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalRequestsBloc, RentalRequestsState>(
      listenWhen: (prev, curr) =>
          curr.mapOrNull(success: (s) => s.feedbackMessage) != null &&
          prev.mapOrNull(success: (s) => s.feedbackMessage) == null,
      listener: (context, state) {
        final message = state.mapOrNull(success: (s) => s.feedbackMessage);
        if (message == null) return;

        final isError = message.startsWith('Error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: isError
                ? AppColors.destructive
                : AppColors.success,
          ),
        );
        context.read<RentalRequestsBloc>().add(
          const RentalRequestsEvent.messageDismissed(),
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (message) => Center(child: Text('Error: $message')),
          success: (requests, processingRequestId, feedbackMessage) {
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
                  onAccept: () => _confirmAccept(
                    context,
                    request.id,
                    request.requester.username,
                  ),
                  onReject: () => _confirmReject(
                    context,
                    request.id,
                    request.requester.username,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _confirmAccept(
    BuildContext context,
    String requestId,
    String username,
  ) async {
    final confirmed = await AppAlertDialog.showConfirm(
      context,
      title: '¿Aceptar solicitud?',
      content: '¿Confirmas que quieres aceptar la solicitud de $username?',
      confirmText: 'Aceptar',
    );
    if ((confirmed ?? false) && context.mounted) {
      context.read<RentalRequestsBloc>().add(
        RentalRequestsEvent.accepted(requestId),
      );
    }
  }

  Future<void> _confirmReject(
    BuildContext context,
    String requestId,
    String username,
  ) async {
    final confirmed = await AppAlertDialog.showConfirm(
      context,
      title: '¿Rechazar solicitud?',
      content: '¿Confirmas que quieres rechazar la solicitud de $username?',
      confirmText: 'Rechazar',
      isDestructive: true,
    );
    if ((confirmed ?? false) && context.mounted) {
      context.read<RentalRequestsBloc>().add(
        RentalRequestsEvent.rejected(requestId),
      );
    }
  }
}
