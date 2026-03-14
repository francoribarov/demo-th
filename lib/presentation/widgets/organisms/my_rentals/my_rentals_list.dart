import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/rental_request.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_rentals/my_rentals_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/my_rentals/my_rental_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/my_rentals/drop_off_bottom_sheet.dart';

class MyRentalsList extends StatelessWidget {
  const MyRentalsList({
    required this.rentals,
    super.key,
  });

  final List<RentalRequest> rentals;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.gameRust,
      onRefresh: () async {
        context.read<MyRentalsBloc>().add(const MyRentalsEvent.refresh());
        await Future<void>.delayed(const Duration(milliseconds: 500));
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: rentals.length,
        itemBuilder: (context, index) {
          final rental = rentals[index];
          return MyRentalCard(
            rental: rental,
            onDropOff: () async {
              final success = await showDropOffBottomSheet(context, rental.id);
              if (context.mounted && success != null && success) {
                context.read<MyRentalsBloc>().add(
                  MyRentalsEvent.dropOffSuccess(rental.id),
                );
              }
            },
          );
        },
      ),
    );
  }
}
