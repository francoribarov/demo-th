import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';

class RentalRequestCard extends StatelessWidget {
  const RentalRequestCard({
    required this.request,
    required this.onAccept,
    required this.onReject,
    this.isProcessing = false,
    super.key,
  });

  final RentalRequest request;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isProcessing;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final range =
        '${dateFormat.format(request.startDate)} - ${dateFormat.format(request.endDate)}';
    final duration = request.endDate.difference(request.startDate).inDays;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: request.requester.imageUrl != null
                      ? NetworkImage(request.requester.imageUrl!)
                      : null,
                  child: request.requester.imageUrl == null
                      ? Text(request.requester.username[0].toUpperCase())
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.requester.username,
                        style: AppTypography.titleMedium,
                      ),
                      Text(
                        'Quiere alquilar ${request.game.title}',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${request.totalPrice}',
                      style: AppTypography.titleLarge.copyWith(
                        color: AppColors.gameRust,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Total ($duration días)',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('Fechas: $range', style: AppTypography.bodyMedium),
            const SizedBox(height: 16),
            if (request.status == RentalRequestStatus.pending) ...[
              if (isProcessing)
                const SizedBox(
                  height: 48,
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReject,
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          maximumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('Rechazar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: onAccept,
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          maximumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('Aceptar'),
                      ),
                    ),
                  ],
                ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: request.status == RentalRequestStatus.accepted
                      ? AppColors.successSurface
                      : AppColors.errorSurface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  request.status == RentalRequestStatus.accepted
                      ? 'Aceptada'
                      : 'Rechazada',
                  textAlign: TextAlign.center,
                  style: AppTypography.labelLarge.copyWith(
                    color: request.status == RentalRequestStatus.accepted
                        ? AppColors.gameSage
                        : AppColors.destructive,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
