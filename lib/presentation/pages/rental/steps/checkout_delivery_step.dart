import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/checkout_order_summary.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/delivery_option_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/info_banner.dart';

class CheckoutDeliveryStep
    extends StatelessWidget {
  const CheckoutDeliveryStep({
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
                      '¿Cómo recibís el juego?',
                      style: AppTypography
                          .headlineMedium,
                    ),
                    const SizedBox(
                      height: AppTheme.spacing2xl,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                              DeliveryOptionCard(
                            icon: Icons.store,
                            title:
                                'Retiro en punto',
                            subtitle:
                                'Retiralo en '
                                'persona',
                            isSelected:
                                !state.isDelivery,
                            onTap: () => context
                                .read<RentalBloc>()
                                .add(
                                  const RentalEvent
                                      .deliveryChanged(
                                    isDelivery:
                                        false,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(
                          width:
                              AppTheme.spacingMd,
                        ),
                        Expanded(
                          child:
                              DeliveryOptionCard(
                            icon: Icons
                                .delivery_dining,
                            title: 'Envío',
                            subtitle:
                                'A tu domicilio',
                            isSelected:
                                state.isDelivery,
                            onTap: () => context
                                .read<RentalBloc>()
                                .add(
                                  const RentalEvent
                                      .deliveryChanged(
                                    isDelivery:
                                        true,
                                  ),
                                ),
                          ),
                        ),
                      ],
                    ),
                    if (state.isDelivery) ...[
                      const SizedBox(
                        height:
                            AppTheme.spacing2xl,
                      ),
                      Text(
                        'Dirección de entrega',
                        style: AppTypography
                            .titleSmall,
                      ),
                      const SizedBox(
                        height:
                            AppTheme.spacingSm,
                      ),
                      TextField(
                        decoration:
                            const InputDecoration(
                          hintText:
                              'Ej: Av. 18 de '
                              'Julio 1234, '
                              'Montevideo',
                          prefixIcon: Icon(
                            Icons
                                .location_on_outlined,
                          ),
                        ),
                        maxLength: 200,
                        onChanged: (value) =>
                            context
                                .read<
                                    RentalBloc>()
                                .add(
                                  RentalEvent
                                      .deliveryAddressChanged(
                                    address: value,
                                  ),
                                ),
                      ),
                      const SizedBox(
                        height:
                            AppTheme.spacingLg,
                      ),
                      Text(
                        'Comentarios (opcional)',
                        style: AppTypography
                            .titleSmall,
                      ),
                      const SizedBox(
                        height:
                            AppTheme.spacingSm,
                      ),
                      TextField(
                        decoration:
                            const InputDecoration(
                          hintText:
                              'Ej: Timbre 2B, '
                              'casa con reja '
                              'verde',
                          prefixIcon: Icon(
                            Icons
                                .comment_outlined,
                          ),
                        ),
                        maxLength: 300,
                        onChanged: (value) =>
                            context
                                .read<
                                    RentalBloc>()
                                .add(
                                  RentalEvent
                                      .deliveryCommentsChanged(
                                    comments:
                                        value,
                                  ),
                                ),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height:
                            AppTheme.spacingLg,
                      ),
                      InfoBanner(
                        text: 'Costo de envío: '
                            '${CurrencyFormatter.formatUYU(150)}',
                      ),
                    ],
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
