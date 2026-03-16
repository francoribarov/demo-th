import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/label_value_row.dart';

/// Bottom sheet confirming rental request acceptance.
/// When overlapping requests exist, warns the publisher
/// that they will be auto-rejected.
class AcceptRequestConfirmationSheet
    extends StatelessWidget {
  const AcceptRequestConfirmationSheet({
    required this.request,
    required this.overlappingRequests,
    super.key,
  });

  final RentalRequest request;
  final List<RentalRequest> overlappingRequests;

  static final _dateFormat =
      DateFormat('dd/MM/yyyy');

  static Future<bool> show({
    required BuildContext context,
    required RentalRequest request,
    required List<RentalRequest> overlappingRequests,
  }) async {
    final result =
        await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) =>
          AcceptRequestConfirmationSheet(
        request: request,
        overlappingRequests: overlappingRequests,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final hasOverlaps =
        overlappingRequests.isNotEmpty;
    final duration = request.endDate
        .difference(request.startDate)
        .inDays;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.sizeOf(context).height * 0.85,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppTheme.spacing2xl,
            AppTheme.spacingXs,
            AppTheme.spacing2xl,
            AppTheme.spacing2xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Aceptar solicitud',
                style:
                    AppTypography.headlineMedium,
              ),
              const SizedBox(
                height: AppTheme.spacingLg,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _RequestSummary(
                        request: request,
                        dateFormat: _dateFormat,
                        duration: duration,
                      ),
                      if (hasOverlaps) ...[
                        const SizedBox(
                          height:
                              AppTheme.spacingLg,
                        ),
                        _OverlapWarning(
                          overlappingRequests:
                              overlappingRequests,
                          dateFormat: _dateFormat,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: AppTheme.spacing2xl,
              ),
              const _ActionButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestSummary extends StatelessWidget {
  const _RequestSummary({
    required this.request,
    required this.dateFormat,
    required this.duration,
  });

  final RentalRequest request;
  final DateFormat dateFormat;
  final int duration;

  @override
  Widget build(BuildContext context) {
    final hasImage =
        request.game.images.isNotEmpty;

    return SurfaceCard(
      variant: SurfaceCardVariant.subtle,
      padding: const EdgeInsets.all(
        AppTheme.spacingLg,
      ),
      borderRadius: BorderRadius.circular(
        AppTheme.radiusLg,
      ),
      child: Column(
        children: [
          Row(
            children: [
              if (hasImage)
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    AppTheme.radiusMd,
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        request.game.images.first,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorWidget:
                        (_, __, ___) =>
                            _GamePlaceholder(
                      title: request.game.title,
                    ),
                  ),
                )
              else
                _GamePlaceholder(
                  title: request.game.title,
                ),
              const SizedBox(
                width: AppTheme.spacingMd,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.game.title,
                      style:
                          AppTypography.titleMedium,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: AppTheme.spacingXs,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              AppColors.gameCream,
                          backgroundImage: request
                                      .requester
                                      .imageUrl !=
                                  null
                              ? NetworkImage(
                                  request.requester
                                      .imageUrl!,
                                )
                              : null,
                          child: request
                                      .requester
                                      .imageUrl ==
                                  null
                              ? Text(
                                  _safeInitial(
                                    request
                                        .requester
                                        .username,
                                  ),
                                  style:
                                      AppTypography
                                          .labelSmall
                                          .copyWith(
                                    color: AppColors
                                        .gameBrown,
                                    fontSize: 9,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(
                          width:
                              AppTheme.spacingXs,
                        ),
                        Flexible(
                          child: Text(
                            request
                                .requester
                                .username,
                            style: AppTypography
                                .bodySmall
                                .copyWith(
                              color: AppColors
                                  .textTertiary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow
                                .ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppTheme.spacingMd,
          ),
          Divider(
            height: 1,
            color: AppColors.gameBrown
                .withOpacityValue(0.1),
          ),
          const SizedBox(
            height: AppTheme.spacingMd,
          ),
          LabelValueRow(
            leadingIcon:
                Icons.calendar_today_outlined,
            label: 'Fechas',
            value:
                '${dateFormat.format(request.startDate)}'
                ' – '
                '${dateFormat.format(request.endDate)}',
          ),
          const SizedBox(
            height: AppTheme.spacingSm,
          ),
          LabelValueRow(
            leadingIcon: Icons.schedule_outlined,
            label: 'Duración',
            value: '$duration días',
          ),
          const SizedBox(
            height: AppTheme.spacingSm,
          ),
          LabelValueRow(
            leadingIcon:
                Icons.attach_money_outlined,
            label: 'Total',
            value: CurrencyFormatter.formatUYU(
              request.totalPrice,
            ),
            valueColor: AppColors.gameRust,
            valueStyle:
                AppTypography.titleMedium.copyWith(
              color: AppColors.gameRust,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _GamePlaceholder extends StatelessWidget {
  const _GamePlaceholder({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.gameCream,
        borderRadius: BorderRadius.circular(
          AppTheme.radiusMd,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        _safeInitial(title),
        style: AppTypography.titleLarge.copyWith(
          color: AppColors.gameBrown,
        ),
      ),
    );
  }
}

class _OverlapWarning extends StatelessWidget {
  const _OverlapWarning({
    required this.overlappingRequests,
    required this.dateFormat,
  });

  final List<RentalRequest> overlappingRequests;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    final count = overlappingRequests.length;
    final noun = count == 1
        ? 'solicitud'
        : 'solicitudes';
    final verb = count == 1
        ? 'será rechazada'
        : 'serán rechazadas';

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.gameCream
            .withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(
          AppTheme.radiusLg,
        ),
        border: Border.all(
          color: AppColors.gameBrown
              .withOpacityValue(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingLg,
              vertical: AppTheme.spacingMd,
            ),
            decoration: BoxDecoration(
              color: AppColors.gameRust
                  .withOpacityValue(0.08),
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.swap_horiz_rounded,
                  color: AppColors.gameRust,
                  size: 20,
                ),
                const SizedBox(
                  width: AppTheme.spacingSm,
                ),
                Expanded(
                  child: Text(
                    'Al aceptar, $count $noun '
                    'con fechas superpuestas '
                    '$verb automáticamente.',
                    style: AppTypography
                        .bodyMedium
                        .copyWith(
                      color: AppColors.gameRust,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              AppTheme.spacingMd,
            ),
            child: Column(
              children: overlappingRequests
                  .map(
                    (r) => Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom:
                            AppTheme.spacingSm,
                      ),
                      child: _OverlapRequestTile(
                        request: r,
                        dateFormat: dateFormat,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverlapRequestTile extends StatelessWidget {
  const _OverlapRequestTile({
    required this.request,
    required this.dateFormat,
  });

  final RentalRequest request;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(
          AppTheme.radiusSm,
        ),
        border: Border.all(
          color: AppColors.gameBrown
              .withOpacityValue(0.1),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.gameCream,
            backgroundImage:
                request.requester.imageUrl != null
                    ? NetworkImage(
                        request
                            .requester.imageUrl!,
                      )
                    : null,
            child:
                request.requester.imageUrl == null
                    ? Text(
                        _safeInitial(
                          request
                              .requester.username,
                        ),
                        style: AppTypography
                            .labelSmall
                            .copyWith(
                          color:
                              AppColors.gameBrown,
                          fontSize: 10,
                        ),
                      )
                    : null,
          ),
          const SizedBox(
            width: AppTheme.spacingSm,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  request.requester.username,
                  style:
                      AppTypography.labelMedium,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                ),
                Text(
                  '${dateFormat.format(request.startDate)}'
                  ' – '
                  '${dateFormat.format(request.endDate)}',
                  style: AppTypography.bodySmall
                      .copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            CurrencyFormatter.formatUYU(
              request.totalPrice,
            ),
            style:
                AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppSecondaryButton(
            onPressed: () =>
                Navigator.of(context).pop(false),
            label: 'Volver',
          ),
        ),
        const SizedBox(
          width: AppTheme.spacingMd,
        ),
        Expanded(
          child: AppPrimaryButton(
            onPressed: () =>
                Navigator.of(context).pop(true),
            label: 'Aceptar',
          ),
        ),
      ],
    );
  }
}

String _safeInitial(String text) {
  if (text.isEmpty) return '?';
  return text[0].toUpperCase();
}
