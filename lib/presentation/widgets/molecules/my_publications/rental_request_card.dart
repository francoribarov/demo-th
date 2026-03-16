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

  final RentalRequest request;

  /// Pre-formatted date range string,
  /// e.g. "01/06/2025 - 05/06/2025".
  final String dateRangeText;

  /// Pre-formatted duration label,
  /// e.g. "5 días".
  final String durationText;

  /// Whether to show accept/reject buttons
  /// (true when pending).
  final bool showActions;

  /// Status badge label when not pending.
  final String? statusLabel;

  /// Whether the status badge uses success
  /// colour scheme.
  final bool statusIsSuccess;

  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isProcessing;

  /// Overlapping pending request count for
  /// the same game.
  final int overlappingCount;

  @override
  Widget build(BuildContext context) {
    final username = request.requester.username;

    return SurfaceCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLg,
        vertical: AppTheme.spacingSm,
      ),
      padding: const EdgeInsets.all(
        AppTheme.spacingLg,
      ),
      borderRadius: BorderRadius.circular(
        AppTheme.radiusXl,
      ),
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
                    ? NetworkImage(
                        request.requester.imageUrl!,
                      )
                    : null,
                child: request.requester.imageUrl == null
                    ? Text(
                        _safeInitial(
                          username,
                        ),
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.gameBrown,
                        ),
                      )
                    : null,
              ),
              const SizedBox(
                width: AppTheme.spacingMd,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: AppTypography.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Quiere alquilar '
                      '${request.game.title}',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.formatUYU(
                      request.totalPrice,
                    ),
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
          const SizedBox(
            height: AppTheme.spacingMd,
          ),
          Text(
            'Fechas: $dateRangeText',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          if (showActions && overlappingCount > 0) ...[
            const SizedBox(
              height: AppTheme.spacingSm,
            ),
            _OverlapBadge(
              count: overlappingCount,
            ),
          ],
          const SizedBox(
            height: AppTheme.spacingLg,
          ),
          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 250,
            ),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _buildBottomSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    if (showActions) {
      if (isProcessing) {
        return SizedBox(
          key: ValueKey(
            'processing-${request.id}',
          ),
          height: 48,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.gameRust,
            ),
          ),
        );
      }
      return Row(
        key: ValueKey(
          'actions-${request.id}',
        ),
        children: [
          Expanded(
            child: AppSecondaryButton(
              onPressed: onReject,
              label: 'Rechazar',
            ),
          ),
          const SizedBox(
            width: AppTheme.spacingMd,
          ),
          Expanded(
            child: AppPrimaryButton(
              onPressed: onAccept,
              label: 'Aceptar',
            ),
          ),
        ],
      );
    }

    if (statusLabel != null) {
      return Container(
        key: ValueKey(
          'status-${request.id}-$statusLabel',
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(
          AppTheme.spacingSm,
        ),
        decoration: BoxDecoration(
          color: statusIsSuccess
              ? AppColors.successSurface
              : AppColors.errorSurface,
          borderRadius: BorderRadius.circular(
            AppTheme.radiusSm,
          ),
        ),
        child: Text(
          statusLabel!,
          textAlign: TextAlign.center,
          style: AppTypography.labelLarge.copyWith(
            color: statusIsSuccess ? AppColors.gameSage : AppColors.destructive,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return const SizedBox.shrink(
      key: ValueKey('empty'),
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
        color: AppColors.gameGold.withOpacityValue(0.1),
        borderRadius: BorderRadius.circular(
          AppTheme.radiusFull,
        ),
        border: Border.all(
          color: AppColors.gameGold.withOpacityValue(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 14,
            color: AppColors.gameBrown,
          ),
          const SizedBox(
            width: AppTheme.spacingXs,
          ),
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

String _safeInitial(String text) {
  if (text.isEmpty) return '?';
  return text[0].toUpperCase();
}
