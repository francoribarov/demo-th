import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/checkout_order_summary.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/info_banner.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/payment_method_card.dart';

class CheckoutPaymentStep extends StatelessWidget {
  const CheckoutPaymentStep({
    required this.state,
    super.key,
  });

  final RentalState state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(
            AppTheme.spacingLg,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight -
                  AppTheme.spacingLg * 2,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¿Cómo querés pagar?',
                      style: AppTypography
                          .headlineMedium,
                    ),
                    const SizedBox(
                      height: AppTheme.spacing2xl,
                    ),
                    PaymentMethodCard(
                      title: 'Efectivo',
                      subtitle:
                          'Pagá en efectivo al '
                          'momento de la entrega',
                      icon: Icons.payments,
                      isSelected:
                          state.paymentMethod ==
                              'cash',
                      onTap: () => context
                          .read<RentalBloc>()
                          .add(
                            const RentalEvent
                                .paymentMethodChanged(
                              paymentMethod: 'cash',
                            ),
                          ),
                    ),
                    const SizedBox(
                      height: AppTheme.spacing2xl,
                    ),
                    const InfoBanner(
                      text: 'Próximamente más '
                          'métodos de pago.',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppTheme.spacingXl,
                  ),
                  child: CheckoutOrderSummary(
                    state: state,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
