import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';

class MyRentalCard extends StatelessWidget {
  const MyRentalCard({
    required this.rental,
    this.onDropOff,
    this.showDropOffButton = true,
    this.showOwnerActionButtons = false,
    this.onConfirmOwner,
    this.onReportOwner,
    super.key,
  });

  final RentalRequest rental;
  final VoidCallback? onDropOff;
  final bool showDropOffButton;
  final bool showOwnerActionButtons;
  final VoidCallback? onConfirmOwner;
  final VoidCallback? onReportOwner;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final range =
        '${dateFormat.format(rental.startDate)} - ${dateFormat.format(rental.endDate)}';
    final duration = rental.endDate.difference(rental.startDate).inDays;

    final canDropOff =
        showDropOffButton && rental.status == RentalRequestStatus.active;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.gameBrown.withValues(alpha: 0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.background,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: rental.game.images.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: rental.game.images.first,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, err) => const Icon(
                            Icons.broken_image,
                            color: AppColors.gameBrown,
                          ),
                        )
                      : const Icon(Icons.casino, color: AppColors.gameBrown),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rental.game.title,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Alquiler a: ${rental.requester.username}',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${rental.totalPrice}',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.gameRust,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '($duration días)',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.gameBrown,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: AppColors.gameBrown,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      range,
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
                _StatusBadge(status: rental.status),
              ],
            ),
            if (canDropOff) ...[
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: onDropOff,
                  icon: const Icon(Icons.outbox_rounded, size: 20),
                  label: const Text('Devolver juego'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gameRust,
                    foregroundColor: AppColors.primaryForeground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ],
            if (showOwnerActionButtons &&
                rental.status == RentalRequestStatus.returned) ...[
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: onReportOwner,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: AppColors.primaryForeground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text('Reportar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: onConfirmOwner,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.primaryForeground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text('Confirmar'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final RentalRequestStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case RentalRequestStatus.pending:
        color = AppColors.statusPending;
        label = 'Pendiente';
      case RentalRequestStatus.accepted:
        color = AppColors.statusAccepted;
        label = 'Aceptado';
      case RentalRequestStatus.rejected:
        color = AppColors.statusRejected;
        label = 'Rechazado';
      case RentalRequestStatus.active:
        color = AppColors.statusActive;
        label = 'Activo';
      case RentalRequestStatus.returned:
        color = AppColors.statusReturned;
        label = 'Devuelto';
      case RentalRequestStatus.finished:
        color = AppColors.statusFinished;
        label = 'Completado';
      case RentalRequestStatus.cancelled:
        color = AppColors.statusRejected;
        label = 'Cancelado';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
