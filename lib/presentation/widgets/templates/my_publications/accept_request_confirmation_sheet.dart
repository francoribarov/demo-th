import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';

/// Bottom sheet that confirms accepting a rental request and warns about
/// overlapping requests that will be automatically rejected.
class AcceptRequestConfirmationSheet extends StatelessWidget {
  const AcceptRequestConfirmationSheet({
    required this.request,
    required this.overlappingRequests,
    super.key,
  });

  final RentalRequest request;
  final List<RentalRequest> overlappingRequests;

  static final _dateFormat = DateFormat('dd/MM/yyyy');

  static Future<bool> show({
    required BuildContext context,
    required RentalRequest request,
    required List<RentalRequest> overlappingRequests,
  }) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppTheme.radius3xl)),
      ),
      builder: (_) => AcceptRequestConfirmationSheet(
        request: request,
        overlappingRequests: overlappingRequests,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final hasOverlaps = overlappingRequests.isNotEmpty;
    final duration = request.endDate.difference(request.startDate).inDays;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppTheme.spacing2xl,
          AppTheme.spacingSm,
          AppTheme.spacing2xl,
          AppTheme.spacing2xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppTheme.spacingLg),
                decoration: BoxDecoration(
                  color: AppColors.muted,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
              ),
            ),
            Text('Aceptar solicitud', style: AppTypography.headlineMedium),
            const SizedBox(height: AppTheme.spacingLg),

            _RequestSummaryTile(
              request: request,
              dateFormat: _dateFormat,
              duration: duration,
            ),

            if (hasOverlaps) ...[
              const SizedBox(height: AppTheme.spacingLg),
              _OverlapWarningSection(
                overlappingRequests: overlappingRequests,
                dateFormat: _dateFormat,
              ),
            ],

            const SizedBox(height: AppTheme.spacing2xl),

            Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    onPressed: () =>
                        Navigator.of(context).pop(false),
                    label: 'Volver',
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMd),
                Expanded(
                  flex: hasOverlaps ? 2 : 1,
                  child: AppPrimaryButton(
                    onPressed: () =>
                        Navigator.of(context).pop(true),
                    label: hasOverlaps
                        ? 'Aceptar y rechazar '
                            '${overlappingRequests.length}'
                        : 'Confirmar alquiler',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestSummaryTile extends StatelessWidget {
  const _RequestSummaryTile({
    required this.request,
    required this.dateFormat,
    required this.duration,
  });

  final RentalRequest request;
  final DateFormat dateFormat;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: AppColors.gameBrown.withOpacityValue(0.1),
        ),
      ),
      child: Row(
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
                const SizedBox(
                  height: AppTheme.spacingXs,
                ),
                Text(
                  request.game.title,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(
                  height: AppTheme.spacingXs,
                ),
                Text(
                  '${dateFormat.format(request.startDate)}'
                  ' – '
                  '${dateFormat.format(request.endDate)}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textMuted,
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
                '$duration días',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverlapWarningSection extends StatelessWidget {
  const _OverlapWarningSection({
    required this.overlappingRequests,
    required this.dateFormat,
  });

  final List<RentalRequest> overlappingRequests;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    final count = overlappingRequests.length;
    final noun = count == 1 ? 'solicitud' : 'solicitudes';

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLg),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacityValue(0.08),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: AppColors.warning.withOpacityValue(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.warning,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Expanded(
                child: Text(
                  '$count $noun con fechas superpuestas '
                  '${count == 1 ? 'será rechazada' : 'serán rechazadas'} '
                  'automáticamente:',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.gameBrown,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),
          ...overlappingRequests.map(
            (r) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppTheme.spacingSm,
                left: 28,
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.warning,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Expanded(
                    child: Text(
                      '${r.requester.username}  ·  '
                      '${dateFormat.format(r.startDate)} – '
                      '${dateFormat.format(r.endDate)}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
