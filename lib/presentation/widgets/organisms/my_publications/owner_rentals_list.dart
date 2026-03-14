import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/data/dto/rental/rental_drop_off_response.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/my_rentals/my_rental_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/my_rentals/returned_rental_card.dart';

class OwnerRentalsList extends StatelessWidget {
  const OwnerRentalsList({
    required this.returnedRentals,
    required this.activeRentals,
    required this.upcomingRentals,
    required this.dropOffTickets,
    this.onConfirmReturn,
    this.onReportReturn,
    super.key,
  });

  final List<RentalRequest> returnedRentals;
  final List<RentalRequest> activeRentals;
  final List<RentalRequest> upcomingRentals;
  final Map<String, RentalDropOffResponse> dropOffTickets;
  final void Function(String)? onConfirmReturn;
  final void Function(String)? onReportReturn;

  @override
  Widget build(BuildContext context) {
    if (returnedRentals.isEmpty &&
        activeRentals.isEmpty &&
        upcomingRentals.isEmpty) {
      return Center(
        child: Text(
          'No tienes alquileres devueltos, activos ni próximos.',
          style: AppTypography.bodyMedium,
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.gameRust,
      onRefresh: () async {
        context.read<OwnerRentalsBloc>().add(const OwnerRentalsEvent.refresh());
        await Future<void>.delayed(const Duration(milliseconds: 500));
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          if (returnedRentals.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                'Devueltos',
                style: AppTypography.headlineSmall,
              ),
            ),
            ...returnedRentals.map(
              (rental) => ReturnedRentalCard(
                rental: rental,
                dropOffTicket: dropOffTickets[rental.id],
                onConfirm: onConfirmReturn != null
                    ? () => onConfirmReturn!(rental.id)
                    : null,
                onReport: onReportReturn != null
                    ? () => onReportReturn!(rental.id)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (upcomingRentals.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                'Próximos',
                style: AppTypography.headlineSmall,
              ),
            ),
            ...upcomingRentals.map(
              (rental) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: MyRentalCard(
                  rental: rental,
                  showDropOffButton: false,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (activeRentals.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Text(
                'Activos',
                style: AppTypography.headlineSmall,
              ),
            ),
            ...activeRentals.map(
              (rental) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: MyRentalCard(
                  rental: rental,
                  showDropOffButton: false,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
