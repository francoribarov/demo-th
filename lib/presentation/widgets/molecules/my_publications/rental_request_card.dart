import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

class RentalRequestCard extends StatelessWidget {
  const RentalRequestCard({
    required this.request,
    required this.dateRangeText,
    required this.durationText,
    required this.showActions,
    required this.onAccept,
    required this.onReject,
    this.statusLabel,
    this.statusIsSuccess = true,
    this.isProcessing = false,
    this.overlappingCount = 0,
    super.key,
  });

  /// The rental request for display data (requester, game, price).
  final RentalRequest request;

  /// Pre-formatted date range string, e.g. "01/06/2025 - 05/06/2025".
  final String dateRangeText;

  /// Pre-formatted duration label shown next to the total
  /// price, e.g. "5 días".
  final String durationText;

  /// Whether to show accept/reject action buttons
  /// (true when request is pending).
  final bool showActions;

  /// Label for the status badge shown when [showActions] is false.
  final String? statusLabel;

  /// Whether the status badge uses the success colour scheme.
  final bool statusIsSuccess;

  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isProcessing;

  /// Number of other pending requests with overlapping dates for the same game.
  final int overlappingCount;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLg,
        vertical: AppTheme.spacingSm,
      ),
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      borderRadius: BorderRadius.circular(AppTheme.radiusXl),
      borderColor: AppColors.gameBrown.withOpacityValue(0.1),
      boxShadow: AppTheme.shadowMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.gameCream,
                backgroundImage: request.requester.imageUrl != null
                    ? NetworkImage(request.requester.imageUrl!)
                    : null,
                child: request.requester.imageUrl == null
                    ? Text(
                        request.requester.username[0].toUpperCase(),
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.gameBrown,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: AppTheme.spacingMd),
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
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.formatUYU(request.totalPrice),
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.gameRust,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Total ($durationText)',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            'Fechas: $dateRangeText',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          if (showActions && overlappingCount > 0) ...[
            const SizedBox(height: AppTheme.spacingSm),
            _OverlapBadge(count: overlappingCount),
          ],
          const SizedBox(height: AppTheme.spacingLg),
          if (showActions) ...[
            if (isProcessing)
              const SizedBox(
                height: 48,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.gameRust),
                ),
              )
            else
              Row(
                children: [
                  Expanded(
                    child: AppSecondaryButton(
                      onPressed: onReject,
                      label: 'Rechazar',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Expanded(
                    child: AppPrimaryButton(
                      onPressed: onAccept,
                      label: 'Aceptar',
                    ),
                  ),
                ],
              ),
          ] else if (statusLabel != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              decoration: BoxDecoration(
                color: statusIsSuccess
                    ? AppColors.successSurface
                    : AppColors.errorSurface,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Text(
                statusLabel!,
                textAlign: TextAlign.center,
                style: AppTypography.labelLarge.copyWith(
                  color: statusIsSuccess
                      ? AppColors.gameSage
                      : AppColors.destructive,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _OverlapBadge extends StatelessWidget {
  const _OverlapBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final noun = count == 1
        ? 'solicitud superpuesta'
        : 'solicitudes superpuestas';
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacityValue(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        border: Border.all(
          color: AppColors.warning.withOpacityValue(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 14,
            color: AppColors.warning,
          ),
          const SizedBox(width: AppTheme.spacingXs),
          Text(
            '$count $noun',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.gameBrown,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
