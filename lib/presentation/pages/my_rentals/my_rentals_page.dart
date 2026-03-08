import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_rentals/my_rentals_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/my_rentals/widgets/my_rentals_empty_state.dart';
import 'package:mobile_table_hopping/presentation/pages/my_rentals/widgets/my_rentals_error_state.dart';
import 'package:mobile_table_hopping/presentation/pages/my_rentals/widgets/my_rentals_list.dart';

class MyRentalsPage extends StatelessWidget {
  const MyRentalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MyRentalsBloc>()..add(const MyRentalsEvent.started()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('Mis Alquileres'),
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.foreground,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocConsumer<MyRentalsBloc, MyRentalsState>(
          listener: (context, state) {
            final msg = state.mapOrNull(success: (s) => s.feedbackMessage);
            if (msg != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(msg),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.read<MyRentalsBloc>().add(
                const MyRentalsEvent.messageDismissed(),
              );
            }
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.gameRust),
              ),
              failure: (message) => MyRentalsErrorState(message: message),
              success: (rentals, _, _) {
                if (rentals.isEmpty) {
                  return const MyRentalsEmptyState();
                }
                return MyRentalsList(rentals: rentals);
              },
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
