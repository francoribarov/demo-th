import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/owner_rentals/owner_rentals_event.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/my_rentals/my_rental_card.dart';

class OwnerRentalsList extends StatelessWidget {
  const OwnerRentalsList({
    required this.activeRentals,
    required this.upcomingRentals,
    super.key,
  });

  final List<RentalRequest> activeRentals;
  final List<RentalRequest> upcomingRentals;

  @override
  Widget build(BuildContext context) {
    if (activeRentals.isEmpty && upcomingRentals.isEmpty) {
      return const Center(
        child: Text(
          'No tienes alquileres activos ni próximos.',
          style: TextStyle(color: AppColors.gameBrown),
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
          if (upcomingRentals.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Text(
                'Próximos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gameRust,
                ),
              ),
            ),
            ...upcomingRentals.map((rental) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: MyRentalCard(
                    rental: rental,
                    showDropOffButton: false,
                  ),
            )),
            const SizedBox(height: 16),
          ],
          if (activeRentals.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Text(
                'Activos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gameRust,
                ),
              ),
            ),
            ...activeRentals.map((rental) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: MyRentalCard(
                    rental: rental,
                    showDropOffButton: false,
                  ),
            )),
          ],
        ],
      ),
    );
  }
}
