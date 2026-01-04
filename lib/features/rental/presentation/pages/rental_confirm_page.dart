// UI widgets are documented at a higher level; omit per-member docs.
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/core/widgets/availability_date_selector.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/rental/presentation/bloc/rental_bloc.dart';

/// Rental confirmation page matching RentalConfirm.tsx
class RentalConfirmPage extends StatelessWidget {
  const RentalConfirmPage({
    required this.gameId,
    super.key,
    this.startDate,
    this.endDate,
  });
  final String gameId;
  final String? startDate;
  final String? endDate;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalBloc, RentalState>(
      listenWhen: (previous, current) =>
          previous.snackbarMessage != current.snackbarMessage &&
          current.snackbarMessage != null,
      listener: (context, state) {
        final message = state.snackbarMessage;
        if (message == null) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
        context.read<RentalBloc>().add(const RentalEvent.messageShown());
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.gameRust),
            ),
          );
        }

        final game = state.game;
        if (game == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.popOrGo('/game/$gameId'),
              ),
            ),
            body: Center(
              child: Text(state.errorMessage ?? 'Juego no encontrado'),
            ),
          );
        }

        if (state.success) {
          return _SuccessView(game: game, onBackHome: () => context.go('/'));
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.popOrGo('/game/$gameId'),
            ),
            title: const Text('Confirmar alquiler'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Game summary
                _GameSummary(game: game),

                const SizedBox(height: 24),

                // Dates section
                const _SectionTitle(title: 'FECHAS DE ALQUILER'),
                const SizedBox(height: 12),
                AvailabilityDateSelector(
                  game: game,
                  startDate: state.startDate,
                  endDate: state.endDate,
                  onRangeChanged: (start, end) => context.read<RentalBloc>().add(
                    RentalEvent.dateRangeChanged(start, end),
                  ),
                ),

                const SizedBox(height: 24),

                // Delivery/Pickup
                const _SectionTitle(title: 'ENTREGA'),
                const SizedBox(height: 12),
                _DeliverySelector(
                  isDelivery: state.isDelivery,
                  address: state.deliveryAddress,
                  comments: state.deliveryComments,
                  onDeliveryChanged: ({required bool isDelivery}) => context
                      .read<RentalBloc>()
                      .add(RentalEvent.deliveryChanged(isDelivery: isDelivery)),
                  onAddressChanged: (value) => context.read<RentalBloc>().add(
                    RentalEvent.deliveryAddressChanged(value),
                  ),
                  onCommentsChanged: (value) => context.read<RentalBloc>().add(
                    RentalEvent.deliveryCommentsChanged(value),
                  ),
                ),

                const SizedBox(height: 24),

                // Food bundles
                const _SectionTitle(title: 'AGREGÁ SNACKS'),
                const SizedBox(height: 12),
                _FoodBundleSelector(
                  selectedBundles: state.selectedFoodBundles,
                  onBundlesChanged: (bundles) => context.read<RentalBloc>().add(
                    RentalEvent.foodBundlesChanged(bundles),
                  ),
                ),

                const SizedBox(height: 24),

                // Payment method
                const _SectionTitle(title: 'MÉTODO DE PAGO'),
                const SizedBox(height: 12),
                _PaymentSelector(
                  selected: state.paymentMethod,
                  onChanged: (method) => context.read<RentalBloc>().add(
                    RentalEvent.paymentMethodChanged(method),
                  ),
                ),

                const SizedBox(height: 24),

                // Price breakdown
                _PriceBreakdown(
                  subtotal: state.subtotal,
                  days: state.rentalDays,
                  pricePerDay: game.price,
                  serviceFee: state.serviceFee,
                  deliveryFee: state.deliveryFee,
                  foodTotal: state.foodTotal,
                  total: state.total,
                ),

                const SizedBox(height: 24),

                if (state.errorMessage != null) ...[
                  Text(
                    state.errorMessage!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.destructive,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],

                // Confirm button
                ElevatedButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.read<RentalBloc>().add(
                          const RentalEvent.submitted(),
                        ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: state.isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Confirmar y pagar ${CurrencyFormatter.formatUYU(state.total)}',
                        ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTypography.sectionHeader);
  }
}

class _GameSummary extends StatelessWidget {
  const _GameSummary({required this.game});
  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            child: Image.network(
              game.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game.title, style: AppTypography.titleMedium),
                const SizedBox(height: 4),
                Text(
                  game.category,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${CurrencyFormatter.formatUYU(game.price)}/día',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.gameRust,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliverySelector extends StatelessWidget {
  const _DeliverySelector({
    required this.isDelivery,
    required this.address,
    required this.comments,
    required this.onDeliveryChanged,
    required this.onAddressChanged,
    required this.onCommentsChanged,
  });
  final bool isDelivery;
  final String address;
  final String comments;
  final void Function({required bool isDelivery}) onDeliveryChanged;
  final void Function(String) onAddressChanged;
  final void Function(String) onCommentsChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _OptionButton(
                label: 'Retiro en punto',
                icon: Icons.store,
                isSelected: !isDelivery,
                onTap: () => onDeliveryChanged(isDelivery: false),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _OptionButton(
                label: 'Envío a domicilio',
                icon: Icons.delivery_dining,
                isSelected: isDelivery,
                onTap: () => onDeliveryChanged(isDelivery: true),
              ),
            ),
          ],
        ),
        if (isDelivery) ...[
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Dirección de entrega',
              hintText: 'Ej: Av. 18 de Julio 1234, Montevideo',
            ),
            onChanged: onAddressChanged,
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Comentarios (opcional)',
              hintText: 'Ej: Timbre 2B, casa con reja verde',
            ),
            onChanged: onCommentsChanged,
            maxLines: 2,
          ),
        ],
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gameCream : AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isSelected
                ? AppColors.gameRust
                : AppColors.gameBrown.withOpacityValue(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodBundleSelector extends StatelessWidget {
  const _FoodBundleSelector({
    required this.selectedBundles,
    required this.onBundlesChanged,
  });
  final List<String> selectedBundles;
  final void Function(List<String>) onBundlesChanged;

  static const _bundles = [
    ('classic', '🍿 Pack Clásico', 'Pochoclos, papas y bebidas'),
    ('sweet', '🍫 Pack Dulce', 'Chocolates, galletas y jugos'),
    ('premium', '🧀 Pack Premium', 'Quesos, fiambres y vino'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _bundles.map((bundle) {
        final isSelected = selectedBundles.contains(bundle.$1);
        return GestureDetector(
          onTap: () {
            final newBundles = List<String>.from(selectedBundles);
            if (isSelected) {
              newBundles.remove(bundle.$1);
            } else {
              newBundles.add(bundle.$1);
            }
            onBundlesChanged(newBundles);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.gameCream : AppColors.card,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(
                color: isSelected
                    ? AppColors.gameRust
                    : AppColors.gameBrown.withOpacityValue(0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Center(
                    child: Text(
                      bundle.$2.split(' ')[0],
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bundle.$2.substring(3),
                        style: AppTypography.titleSmall,
                      ),
                      Text(
                        bundle.$3,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(r'$250', style: AppTypography.titleSmall),
                const SizedBox(width: 8),
                Icon(
                  isSelected ? Icons.check_circle : Icons.add_circle_outline,
                  color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PaymentSelector extends StatelessWidget {
  const _PaymentSelector({required this.selected, required this.onChanged});
  final String selected;
  final void Function(String) onChanged;

  static const List<(String, String, IconData)> _methods = [
    ('mercadopago', 'Mercado Pago', Icons.account_balance_wallet),
    ('cash', 'Efectivo', Icons.payments),
    ('card', 'Tarjeta guardada', Icons.credit_card),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _methods.map((method) {
        final isSelected = selected == method.$1;
        return GestureDetector(
          onTap: () => onChanged(method.$1),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.gameCream : AppColors.card,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(
                color: isSelected
                    ? AppColors.gameRust
                    : AppColors.gameBrown.withOpacityValue(0.2),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Icon(method.$3, color: AppColors.gameBrown),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(method.$2, style: AppTypography.titleSmall),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: AppColors.gameRust),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PriceBreakdown extends StatelessWidget {
  const _PriceBreakdown({
    required this.subtotal,
    required this.days,
    required this.pricePerDay,
    required this.serviceFee,
    required this.deliveryFee,
    required this.foodTotal,
    required this.total,
  });
  final int subtotal;
  final int days;
  final int pricePerDay;
  final int serviceFee;
  final int deliveryFee;
  final int foodTotal;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
      ),
      child: Column(
        children: [
          _PriceRow(
            label:
                '${CurrencyFormatter.formatUYU(pricePerDay)}/día × $days días',
            value: subtotal,
          ),
          const SizedBox(height: 8),
          _PriceRow(label: 'Tarifa de servicio', value: serviceFee),
          if (deliveryFee > 0) ...[
            const SizedBox(height: 8),
            _PriceRow(label: 'Envío a domicilio', value: deliveryFee),
          ],
          if (foodTotal > 0) ...[
            const SizedBox(height: 8),
            _PriceRow(label: 'Snacks', value: foodTotal),
          ],
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTypography.titleMedium),
              Text(
                CurrencyFormatter.formatUYU(total),
                style: AppTypography.price,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.gameBrown.withOpacityValue(0.7),
          ),
        ),
        Text(
          CurrencyFormatter.formatUYU(value),
          style: AppTypography.bodyMedium,
        ),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.game, required this.onBackHome});
  final Game game;
  final VoidCallback onBackHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 64,
                  color: Colors.green[600],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '¡Reserva confirmada!',
                style: AppTypography.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Tu alquiler de ${game.title} ha sido procesado exitosamente.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Te enviaremos un email con los detalles de tu reserva y las instrucciones de entrega.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: onBackHome,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
