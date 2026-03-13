import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/delivery_option_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/info_banner.dart';

class CheckoutDeliveryStep extends StatelessWidget {
  const CheckoutDeliveryStep({required this.state, super.key});
  final RentalState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Cómo recibís el juego?',
            style: AppTypography.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Elegí cómo preferís recibir tu alquiler.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: DeliveryOptionCard(
                  icon: Icons.store,
                  title: 'Retiro en punto',
                  subtitle: 'Retiralo en persona',
                  isSelected: !state.isDelivery,
                  onTap: () => context.read<RentalBloc>().add(
                        const RentalEvent.deliveryChanged(isDelivery: false),
                      ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DeliveryOptionCard(
                  icon: Icons.delivery_dining,
                  title: 'Envío',
                  subtitle: 'A tu domicilio',
                  isSelected: state.isDelivery,
                  onTap: () => context.read<RentalBloc>().add(
                        const RentalEvent.deliveryChanged(isDelivery: true),
                      ),
                ),
              ),
            ],
          ),
          if (state.isDelivery) ...[
            const SizedBox(height: 24),
            Text('Dirección de entrega', style: AppTypography.titleSmall),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ej: Av. 18 de Julio 1234, Montevideo',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
              onChanged: (value) => context.read<RentalBloc>().add(
                    RentalEvent.deliveryAddressChanged(address: value),
                  ),
            ),
            const SizedBox(height: 16),
            Text('Comentarios (opcional)', style: AppTypography.titleSmall),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Ej: Timbre 2B, casa con reja verde',
                prefixIcon: Icon(Icons.comment_outlined),
              ),
              onChanged: (value) => context.read<RentalBloc>().add(
                    RentalEvent.deliveryCommentsChanged(comments: value),
                  ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            InfoBanner(
              text:
                  'Costo de envío: ${CurrencyFormatter.formatUYU(150)}',
            ),
          ],
        ],
      ),
    );
  }
}
