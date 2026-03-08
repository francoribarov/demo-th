import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

class MyRentalsEmptyState extends StatelessWidget {
  const MyRentalsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: AppColors.gameBrown.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No tenés alquileres',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.gameBrown,
                ),
          ),
        ],
      ),
    );
  }
}
