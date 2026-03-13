// UI widgets are documented at a higher level; omit per-member docs.
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/feedback_notice.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/label_value_row.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/section_header_block.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/rental/availability_date_selector.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/feedback_messenger.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/success_state_view.dart';

/// Rental confirmation page matching RentalConfirm.tsx
class RentalConfirmPage extends StatelessWidget {
  const RentalConfirmPage({
    required this.publicationId,
    super.key,
    this.startDate,
    this.endDate,
  });
  final String publicationId;
  final String? startDate;
  final String? endDate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalBloc, RentalState>(
      listenWhen: (previous, current) =>
          previous.feedbackNotice != current.feedbackNotice && current.feedbackNotice != null,
      listener: (context, state) {
        final notice = state.feedbackNotice;
        if (notice == null) return;
        _showNotice(context, notice);
        context.read<RentalBloc>().add(const RentalEvent.messageShown());
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.gameRust),
            ),
          );
        }

        final publication = state.publication;
        if (publication == null) {
          return Scaffold(
            appBar: PageAppBar(
              title: const Text('Solicitar alquiler'),
              onLeadingPressed: () => context.popOrGo('/publications/$publicationId'),
            ),
            body: Center(
              child: Text(state.errorMessage ?? 'Publicación no encontrada'),
            ),
          );
        }

        if (state.success) {
          return SuccessStateView(
            title: '¡Solicitud enviada!',
            subtitle:
                'Tu solicitud de alquiler de ${publication.title} fue enviada. El propietario deberá aceptarla.\nTe notificaremos cuando el propietario acepte tu solicitud.',
            primaryActionLabel: 'Volver al inicio',
            onPrimaryAction: () => context.go('/'),
            icon: Icons.check_circle,
          );
        }

        final pricing = state.pricing;
        return Scaffold(
          appBar: PageAppBar(
            title: const Text('Solicitar alquiler'),
            onLeadingPressed: () => context.popOrGo('/publications/$publicationId'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Publication summary
                _PublicationSummary(publication: publication),

                const SizedBox(height: 24),

                // Dates section
                SectionHeaderBlock(
                  title: 'FECHAS DE ALQUILER',
                  titleStyle: AppTypography.sectionHeader,
                ),
                const SizedBox(height: 12),
                AvailabilityDateSelector(
                  publication: publication,
                  startDate: state.startDate,
                  endDate: state.endDate,
                  onRangeChanged: (start, end) => context.read<RentalBloc>().add(
                    RentalEvent.dateRangeChanged(
                      startDate: start,
                      endDate: end,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Delivery/Pickup
                SectionHeaderBlock(
                  title: 'ENTREGA',
                  titleStyle: AppTypography.sectionHeader,
                ),
                const SizedBox(height: 12),
                _DeliverySelector(
                  isDelivery: state.isDelivery,
                  address: state.deliveryAddress,
                  comments: state.deliveryComments,
                  onDeliveryChanged: ({required bool isDelivery}) =>
                      context.read<RentalBloc>().add(RentalEvent.deliveryChanged(isDelivery: isDelivery)),
                  onAddressChanged: (value) => context.read<RentalBloc>().add(
                    RentalEvent.deliveryAddressChanged(address: value),
                  ),
                  onCommentsChanged: (value) => context.read<RentalBloc>().add(
                    RentalEvent.deliveryCommentsChanged(comments: value),
                  ),
                ),

                const SizedBox(height: 24),

                // Food bundles
                SectionHeaderBlock(
                  title: 'AGREGÁ SNACKS',
                  titleStyle: AppTypography.sectionHeader,
                ),
                const SizedBox(height: 12),
                _FoodBundleSelector(
                  selectedBundles: state.selectedFoodBundles,
                  onBundlesChanged: (bundles) => context.read<RentalBloc>().add(
                    RentalEvent.foodBundlesChanged(foodBundles: bundles),
                  ),
                ),

                const SizedBox(height: 24),

                // Payment method
                SectionHeaderBlock(
                  title: 'MÉTODO DE PAGO',
                  titleStyle: AppTypography.sectionHeader,
                ),
                const SizedBox(height: 12),
                _PaymentSelector(
                  selected: state.paymentMethod,
                  onChanged: (method) => context.read<RentalBloc>().add(
                    RentalEvent.paymentMethodChanged(paymentMethod: method),
                  ),
                ),

                const SizedBox(height: 24),

                // Price breakdown
                _PriceBreakdown(
                  subtotal: pricing.subtotal,
                  days: pricing.rentalDays,
                  pricePerDay: publication.price,
                  serviceFee: pricing.serviceFee,
                  deliveryFee: pricing.deliveryFee,
                  foodTotal: pricing.foodTotal,
                  total: pricing.total,
                ),

                const SizedBox(height: AppTheme.spacing2xl),

                if (state.errorMessage != null) ...[
                  InlineFeedbackText(
                    message: state.errorMessage!,
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                ],

                // Confirm button
                AppPrimaryButton(
                  label: 'Enviar solicitud',
                  onPressed: () => context.read<RentalBloc>().add(
                    const RentalEvent.submitted(),
                  ),
                  isLoading: state.isSubmitting,
                  minimumSize: const Size(double.infinity, 56),
                ),

                const SizedBox(height: AppTheme.spacingScrollBottom),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PublicationSummary extends StatelessWidget {
  const _PublicationSummary({required this.publication});
  final PublicationListing publication;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      variant: SurfaceCardVariant.subtle,
      borderWidth: 0,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            child: CachedNetworkImage(
              imageUrl: publication.heroImage,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => const ColoredBox(color: AppColors.gameCream),
              errorWidget: (context, url, error) => const MediaPlaceholder(
                icon: Icons.image_not_supported,
                backgroundColor: AppColors.gameCream,
                iconColor: AppColors.gameBrown,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  publication.title,
                  style: AppTypography.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  publication.categoryName,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '${CurrencyFormatter.formatUYU(publication.price)}/día',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.gameRust,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliverySelector extends StatelessWidget {
  const _DeliverySelector({
    required this.isDelivery,
    required this.address,
    required this.comments,
    required this.onDeliveryChanged,
    required this.onAddressChanged,
    required this.onCommentsChanged,
  });
  final bool isDelivery;
  final String address;
  final String comments;
  final void Function({required bool isDelivery}) onDeliveryChanged;
  final void Function(String) onAddressChanged;
  final void Function(String) onCommentsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SelectableInputCard(
                onTap: () => onDeliveryChanged(isDelivery: false),
                isSelected: !isDelivery,
                layout: SelectableInputCardLayout.stacked,
                leading: const Icon(Icons.store),
                title: 'Retiro en punto',
                titleStyle: AppTypography.labelMedium,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SelectableInputCard(
                onTap: () => onDeliveryChanged(isDelivery: true),
                isSelected: isDelivery,
                layout: SelectableInputCardLayout.stacked,
                leading: const Icon(Icons.delivery_dining),
                title: 'Envío a domicilio',
                titleStyle: AppTypography.labelMedium,
              ),
            ),
          ],
        ),
        if (isDelivery) ...[
          const SizedBox(height: 16),
          TextInputField(
            labelText: 'Dirección de entrega',
            hintText: 'Ej: Av. 18 de Julio 1234, Montevideo',
            onChanged: onAddressChanged,
          ),
          const SizedBox(height: 12),
          TextInputField(
            labelText: 'Comentarios (opcional)',
            hintText: 'Ej: Timbre 2B, casa con reja verde',
            onChanged: onCommentsChanged,
            maxLines: 2,
          ),
        ],
      ],
    );
  }
}

class _FoodBundleSelector extends StatelessWidget {
  const _FoodBundleSelector({
    required this.selectedBundles,
    required this.onBundlesChanged,
  });
  final List<String> selectedBundles;
  final void Function(List<String>) onBundlesChanged;

  static const _bundles = [
    ('classic', '🍿 Pack Clásico', 'Pop, papas y bebidas'),
    ('sweet', '🍫 Pack Dulce', 'Chocolates, galletas y jugos'),
    ('premium', '🧀 Pack Premium', 'Quesos, fiambres y vino'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _bundles.map((bundle) {
        final isSelected = selectedBundles.contains(bundle.$1);
        return SelectableInputCard(
          onTap: () {
            final newBundles = List<String>.from(selectedBundles);
            if (isSelected) {
              newBundles.remove(bundle.$1);
            } else {
              newBundles.add(bundle.$1);
            }
            onBundlesChanged(newBundles);
          },
          isSelected: isSelected,
          margin: const EdgeInsets.only(bottom: 12),
          indicatorMode: SelectableInputIndicatorMode.check,
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Center(
              child: Text(
                bundle.$2.split(' ')[0],
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          title: bundle.$2.length > 3 ? bundle.$2.substring(3) : bundle.$2,
          subtitle: bundle.$3,
          titleStyle: AppTypography.titleSmall,
          selectedTextColor: AppColors.foreground,
          unselectedTextColor: AppColors.foreground,
          trailing: Text(r'$250', style: AppTypography.titleSmall),
        );
      }).toList(),
    );
  }
}

class _PaymentSelector extends StatelessWidget {
  const _PaymentSelector({required this.selected, required this.onChanged});
  final String selected;
  final void Function(String) onChanged;

  static const List<(String, String, IconData)> _methods = [
    ('mercadopago', 'Mercado Pago', Icons.account_balance_wallet),
    ('cash', 'Efectivo', Icons.payments),
    ('card', 'Tarjeta guardada', Icons.credit_card),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _methods.map((method) {
        final isSelected = selected == method.$1;
        return SelectableInputCard(
          onTap: () => onChanged(method.$1),
          isSelected: isSelected,
          margin: const EdgeInsets.only(bottom: 12),
          indicatorMode: SelectableInputIndicatorMode.check,
          leading: Icon(method.$3),
          title: method.$2,
          titleStyle: AppTypography.titleSmall,
          selectedTextColor: AppColors.foreground,
          unselectedTextColor: AppColors.foreground,
          selectedIconColor: AppColors.gameBrown,
          unselectedIconColor: AppColors.gameBrown,
        );
      }).toList(),
    );
  }
}

class _PriceBreakdown extends StatelessWidget {
  const _PriceBreakdown({
    required this.subtotal,
    required this.days,
    required this.pricePerDay,
    required this.serviceFee,
    required this.deliveryFee,
    required this.foodTotal,
    required this.total,
  });
  final num subtotal;
  final int days;
  final num pricePerDay;
  final num serviceFee;
  final num deliveryFee;
  final num foodTotal;
  final num total;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          LabelValueRow(
            label: '${CurrencyFormatter.formatUYU(pricePerDay)}/día × $days días',
            value: CurrencyFormatter.formatUYU(subtotal),
            labelColor: AppColors.textTertiary,
            valueStyle: AppTypography.bodyMedium,
          ),
          const SizedBox(height: 8),
          LabelValueRow(
            label: 'Tarifa de servicio',
            value: CurrencyFormatter.formatUYU(serviceFee),
            labelColor: AppColors.textTertiary,
            valueStyle: AppTypography.bodyMedium,
          ),
          if (deliveryFee > 0) ...[
            const SizedBox(height: 8),
            LabelValueRow(
              label: 'Envío a domicilio',
              value: CurrencyFormatter.formatUYU(deliveryFee),
              labelColor: AppColors.textTertiary,
              valueStyle: AppTypography.bodyMedium,
            ),
          ],
          if (foodTotal > 0) ...[
            const SizedBox(height: 8),
            LabelValueRow(
              label: 'Snacks',
              value: CurrencyFormatter.formatUYU(foodTotal),
              labelColor: AppColors.textTertiary,
              valueStyle: AppTypography.bodyMedium,
            ),
          ],
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTypography.titleMedium),
              Text(
                CurrencyFormatter.formatUYU(total),
                style: AppTypography.price,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _showNotice(BuildContext context, FeedbackNotice notice) {
  switch (notice.severity) {
    case FeedbackSeverity.success:
      FeedbackMessenger.showSuccess(context, message: notice.message);
      return;
    case FeedbackSeverity.error:
      FeedbackMessenger.showError(context, message: notice.message);
      return;
    case FeedbackSeverity.warning:
      FeedbackMessenger.showWarning(context, message: notice.message);
      return;
    case FeedbackSeverity.info:
      FeedbackMessenger.showInfo(context, message: notice.message);
      return;
  }
}
