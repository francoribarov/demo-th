import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/food_bundle_selector.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/price_breakdown_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/publication_summary_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/review_section_card.dart';

class CheckoutReviewStep
    extends StatelessWidget {
  const CheckoutReviewStep({
    required this.publication,
    required this.state,
    required this.onEditStep,
    super.key,
  });

  final PublicationListing publication;
  final RentalState state;
  final ValueChanged<int> onEditStep;

  @override
  Widget build(BuildContext context) {
    final start =
        DateFormatter.parseIso(state.startDate);
    final end =
        DateFormatter.parseIso(state.endDate);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        AppTheme.spacingLg,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Resumen del pedido',
            style: AppTypography.headlineMedium,
          ),
          const SizedBox(
            height: AppTheme.spacingXs,
          ),
          Text(
            'Revisá que todo esté correcto '
            'antes de enviar.',
            style:
                AppTypography.bodyMedium.copyWith(
              color: AppColors.gameBrown
                  .withOpacityValue(0.6),
            ),
          ),
          const SizedBox(
            height: AppTheme.spacingXl,
          ),
          PublicationSummaryCard(
            publication: publication,
          ),
          const SizedBox(
            height: AppTheme.spacingLg,
          ),
          _buildDatesSection(start, end),
          _buildPaymentSection(),
          _buildDeliverySection(),
          if (state
              .selectedFoodBundles.isNotEmpty)
            _buildSnacksSection(),
          const SizedBox(
            height: AppTheme.spacingLg,
          ),
          PriceBreakdownCard(
            subtotal: state.subtotal,
            days: state.rentalDays,
            pricePerDay: publication.price,
            serviceFee: state.serviceFee,
            deliveryFee: state.deliveryFee,
            foodTotal: state.foodTotal,
            total: state.total,
          ),
          const SizedBox(
            height: AppTheme.spacing4xl,
          ),
        ],
      ),
    );
  }

  Widget _buildDatesSection(
    DateTime? start,
    DateTime? end,
  ) {
    return ReviewSectionCard(
      icon: Icons.calendar_today,
      title: 'Fechas de alquiler',
      onEdit: () => onEditStep(0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          if (start != null && end != null) ...[
            Text(
              DateFormatter.formatRange(
                state.startDate!,
                state.endDate!,
              ),
              style: AppTypography.titleSmall,
            ),
            const SizedBox(
              height: AppTheme.spacingXs,
            ),
            Text(
              '${state.rentalDays} días',
              style:
                  AppTypography.bodySmall.copyWith(
                color: AppColors.gameBrown
                    .withOpacityValue(0.6),
              ),
            ),
          ] else
            Text(
              'No seleccionadas',
              style: AppTypography.bodyMedium
                  .copyWith(
                color: AppColors.destructive,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return ReviewSectionCard(
      icon: Icons.payments,
      title: 'Método de pago',
      onEdit: () => onEditStep(1),
      child: Text(
        _paymentLabel(state.paymentMethod),
        style: AppTypography.titleSmall,
      ),
    );
  }

  Widget _buildDeliverySection() {
    return ReviewSectionCard(
      icon: Icons.local_shipping,
      title: 'Entrega',
      onEdit: () => onEditStep(2),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            state.isDelivery
                ? 'Envío a domicilio'
                : 'Retiro en punto',
            style: AppTypography.titleSmall,
          ),
          if (state.isDelivery &&
              state.deliveryAddress
                  .isNotEmpty) ...[
            const SizedBox(
              height: AppTheme.spacingXs,
            ),
            Text(
              state.deliveryAddress,
              style: AppTypography.bodySmall
                  .copyWith(
                color: AppColors.gameBrown
                    .withOpacityValue(0.6),
              ),
            ),
          ],
          if (state.isDelivery &&
              state.deliveryComments
                  .isNotEmpty) ...[
            const SizedBox(
              height: AppTheme.spacingXs,
            ),
            Text(
              state.deliveryComments,
              style: AppTypography.bodySmall
                  .copyWith(
                color: AppColors.gameBrown
                    .withOpacityValue(0.5),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSnacksSection() {
    return ReviewSectionCard(
      icon: Icons.fastfood,
      title: 'Snacks',
      onEdit: () => onEditStep(0),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: state.selectedFoodBundles
            .map(
              (b) => Padding(
                padding: const EdgeInsets.only(
                  bottom: AppTheme.spacingXs,
                ),
                child: Text(
                  FoodBundleSelector.labelForId(b),
                  style: AppTypography.bodySmall,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  String _paymentLabel(String method) {
    switch (method) {
      case 'cash':
        return 'Efectivo';
      case 'mercadopago':
        return 'Mercado Pago';
      case 'card':
        return 'Tarjeta guardada';
      default:
        return method;
    }
  }
}
