import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_rentals/my_rentals_bloc.dart';

class MyRentalsErrorState extends StatelessWidget {
  const MyRentalsErrorState({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(message),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              context.read<MyRentalsBloc>().add(const MyRentalsEvent.refresh());
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
