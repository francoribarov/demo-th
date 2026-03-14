import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/availability_date_selector.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/date_summary_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/food_bundle_selector.dart';

class CheckoutDateStep extends StatelessWidget {
  const CheckoutDateStep({
    required this.publication,
    required this.state,
    super.key,
  });

  final PublicationListing publication;
  final RentalState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        AppTheme.spacingLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Cuándo querés alquilar?',
            style: AppTypography.headlineMedium,
          ),
          const SizedBox(
            height: AppTheme.spacingXs,
          ),
          Text(
            'Seleccioná las fechas de inicio '
            'y fin del alquiler.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
          ),
          const SizedBox(
            height: AppTheme.spacingXl,
          ),
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
          if (state.startDate != null && state.endDate != null) ...[
            const SizedBox(
              height: AppTheme.spacingXl,
            ),
            DateSummaryCard(
              startDate: state.startDate!,
              endDate: state.endDate!,
              rentalDays: state.rentalDays,
              pricePerDay: publication.price,
              subtotal: state.subtotal,
            ),
          ],
          const SizedBox(
            height: AppTheme.spacing2xl,
          ),
          Text(
            'Agregá snacks (opcional)',
            style: AppTypography.titleSmall.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
          ),
          const SizedBox(
            height: AppTheme.spacingMd,
          ),
          FoodBundleSelector(
            selectedBundles: state.selectedFoodBundles,
            onBundlesChanged: (bundles) => context.read<RentalBloc>().add(
              RentalEvent.foodBundlesChanged(
                foodBundles: bundles,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
