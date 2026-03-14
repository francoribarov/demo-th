import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/info_banner.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/payment_method_card.dart';

class CheckoutPaymentStep extends StatelessWidget {
  const CheckoutPaymentStep({required this.state, super.key});
  final RentalState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Cómo querés pagar?',
            style: AppTypography.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Seleccioná tu método de pago preferido.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
          ),
          const SizedBox(height: 24),
          PaymentMethodCard(
            title: 'Efectivo',
            subtitle: 'Pagá en efectivo al momento de la entrega',
            icon: Icons.payments,
            isSelected: state.paymentMethod == 'cash',
            onTap: () => context.read<RentalBloc>().add(
                  const RentalEvent.paymentMethodChanged(
                    paymentMethod: 'cash',
                  ),
                ),
          ),
          const SizedBox(height: 24),
          const InfoBanner(text: 'Próximamente más métodos de pago.'),
        ],
      ),
    );
  }
}
