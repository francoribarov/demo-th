import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/publication_listing.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/availability_date_selector.dart';

class RentalConfirmPage extends StatefulWidget {
  const RentalConfirmPage({
    required this.publicationId,
    super.key,
    this.startDate,
    this.endDate,
  });
  final String publicationId;
  final String? startDate;
  final String? endDate;

  @override
  State<RentalConfirmPage> createState() => _RentalConfirmPageState();
}

class _RentalConfirmPageState extends State<RentalConfirmPage> {
  final _pageController = PageController();
  int _currentStep = 0;
  static const _totalSteps = 4;

  static const _stepLabels = ['Fechas', 'Pago', 'Entrega', 'Resumen'];
  static const _stepIcons = [
    Icons.calendar_today,
    Icons.payments,
    Icons.local_shipping,
    Icons.checklist,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    if (step < 0 || step >= _totalSteps) return;
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentStep = step);
  }

  void _next() => _goToStep(_currentStep + 1);
  void _back() => _goToStep(_currentStep - 1);

  bool _canAdvanceFromStep(int step, RentalState state) {
    switch (step) {
      case 0:
        return state.startDate != null && state.endDate != null;
      case 1:
        return state.paymentMethod.isNotEmpty;
      case 2:
        if (state.isDelivery && state.deliveryAddress.trim().isEmpty) {
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalBloc, RentalState>(
      listenWhen: (previous, current) =>
          previous.snackbarMessage != current.snackbarMessage &&
          current.snackbarMessage != null,
      listener: (context, state) {
        final message = state.snackbarMessage;
        if (message == null) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
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

        final publication = state.publication;
        if (publication == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context
                    .popOrGo('/publications/${widget.publicationId}'),
              ),
            ),
            body: Center(
              child: Text(state.errorMessage ?? 'Publicación no encontrada'),
            ),
          );
        }

        if (state.success) {
          return _SuccessView(
            publication: publication,
            onBackHome: () => context.go('/'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (_currentStep > 0) {
                  _back();
                } else {
                  context
                      .popOrGo('/publications/${widget.publicationId}');
                }
              },
            ),
            title: Text(_stepLabels[_currentStep]),
          ),
          body: Column(
            children: [
              _StepIndicator(
                currentStep: _currentStep,
                totalSteps: _totalSteps,
                labels: _stepLabels,
                icons: _stepIcons,
                onStepTapped: (step) {
                  if (step < _currentStep) _goToStep(step);
                },
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) =>
                      setState(() => _currentStep = index),
                  children: [
                    _DateStep(
                      publication: publication,
                      state: state,
                    ),
                    _PaymentStep(state: state),
                    _DeliveryStep(state: state),
                    _ReviewStep(
                      publication: publication,
                      state: state,
                      onEditStep: _goToStep,
                    ),
                  ],
                ),
              ),
              _BottomNavBar(
                currentStep: _currentStep,
                totalSteps: _totalSteps,
                canAdvance: _canAdvanceFromStep(_currentStep, state),
                isSubmitting: state.isSubmitting,
                onNext: _next,
                onBack: _back,
                onSubmit: () => context
                    .read<RentalBloc>()
                    .add(const RentalEvent.submitted()),
                errorMessage: state.errorMessage,
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Step Indicator
// ---------------------------------------------------------------------------

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.labels,
    required this.icons,
    required this.onStepTapped,
  });
  final int currentStep;
  final int totalSteps;
  final List<String> labels;
  final List<IconData> icons;
  final ValueChanged<int> onStepTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          bottom: BorderSide(
            color: AppColors.gameBrown.withOpacityValue(0.1),
          ),
        ),
      ),
      child: Row(
        children: List.generate(totalSteps * 2 - 1, (index) {
          if (index.isOdd) {
            final stepBefore = index ~/ 2;
            final isCompleted = stepBefore < currentStep;
            return Expanded(
              child: Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                color: isCompleted
                    ? AppColors.gameRust
                    : AppColors.gameBrown.withOpacityValue(0.15),
              ),
            );
          }
          final step = index ~/ 2;
          final isActive = step == currentStep;
          final isCompleted = step < currentStep;
          return GestureDetector(
            onTap: () => onStepTapped(step),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.gameRust
                        : isActive
                            ? AppColors.gameRust.withOpacityValue(0.12)
                            : AppColors.gameBrown.withOpacityValue(0.06),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive
                          ? AppColors.gameRust
                          : isCompleted
                              ? AppColors.gameRust
                              : AppColors.gameBrown.withOpacityValue(0.15),
                      width: isActive ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, size: 18, color: Colors.white)
                        : Icon(
                            icons[step],
                            size: 16,
                            color: isActive
                                ? AppColors.gameRust
                                : AppColors.gameBrown.withOpacityValue(0.4),
                          ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  labels[step],
                  style: AppTypography.labelSmall.copyWith(
                    color: isActive || isCompleted
                        ? AppColors.gameRust
                        : AppColors.gameBrown.withOpacityValue(0.4),
                    fontWeight:
                        isActive ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom Navigation Bar
// ---------------------------------------------------------------------------

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.currentStep,
    required this.totalSteps,
    required this.canAdvance,
    required this.isSubmitting,
    required this.onNext,
    required this.onBack,
    required this.onSubmit,
    this.errorMessage,
  });
  final int currentStep;
  final int totalSteps;
  final bool canAdvance;
  final bool isSubmitting;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onSubmit;
  final String? errorMessage;

  bool get _isLastStep => currentStep == totalSteps - 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacityValue(0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (errorMessage != null) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                errorMessage!,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.destructive,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          Row(
            children: [
              if (currentStep > 0)
                Expanded(
                  child: OutlinedButton(
                    onPressed: onBack,
                    child: const Text('Atrás'),
                  ),
                ),
              if (currentStep > 0) const SizedBox(width: 12),
              Expanded(
                flex: currentStep > 0 ? 2 : 1,
                child: ElevatedButton(
                  onPressed: (canAdvance && !isSubmitting)
                      ? (_isLastStep ? onSubmit : onNext)
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52),
                    disabledBackgroundColor:
                        AppColors.gameBrown.withOpacityValue(0.12),
                    disabledForegroundColor:
                        AppColors.gameBrown.withOpacityValue(0.35),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(_isLastStep ? 'Enviar solicitud' : 'Continuar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Step 1 – Date Selection
// ---------------------------------------------------------------------------

class _DateStep extends StatelessWidget {
  const _DateStep({required this.publication, required this.state});
  final PublicationListing publication;
  final RentalState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PublicationSummary(publication: publication),
          const SizedBox(height: 24),
          Text(
            '¿Cuándo querés alquilar?',
            style: AppTypography.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Seleccioná las fechas de inicio y fin del alquiler.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
          ),
          const SizedBox(height: 20),
          AvailabilityDateSelector(
            publication: publication,
            startDate: state.startDate,
            endDate: state.endDate,
            onRangeChanged: (start, end) =>
                context.read<RentalBloc>().add(
                      RentalEvent.dateRangeChanged(
                        startDate: start,
                        endDate: end,
                      ),
                    ),
          ),
          if (state.startDate != null && state.endDate != null) ...[
            const SizedBox(height: 20),
            _DateSummaryCard(state: state, publication: publication),
          ],
          const SizedBox(height: 24),
          _SectionTitle(title: 'AGREGÁ SNACKS (OPCIONAL)'),
          const SizedBox(height: 12),
          _FoodBundleSelector(
            selectedBundles: state.selectedFoodBundles,
            onBundlesChanged: (bundles) => context
                .read<RentalBloc>()
                .add(RentalEvent.foodBundlesChanged(foodBundles: bundles)),
          ),
        ],
      ),
    );
  }
}

class _DateSummaryCard extends StatelessWidget {
  const _DateSummaryCard({required this.state, required this.publication});
  final RentalState state;
  final PublicationListing publication;

  @override
  Widget build(BuildContext context) {
    final start = DateFormatter.parseIso(state.startDate);
    final end = DateFormatter.parseIso(state.endDate);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.5),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameRust.withOpacityValue(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.date_range, color: AppColors.gameRust, size: 20),
              const SizedBox(width: 10),
              Text(
                '${state.rentalDays} días',
                style: AppTypography.titleMedium
                    .copyWith(color: AppColors.gameRust),
              ),
            ],
          ),
          if (start != null && end != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const SizedBox(width: 30),
                Expanded(
                  child: Text(
                    '${DateFormatter.formatFullDate(start)} → ${DateFormatter.formatFullDate(end)}',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${CurrencyFormatter.formatUYU(publication.price)}/día × ${state.rentalDays} días',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.7),
                ),
              ),
              Text(
                CurrencyFormatter.formatUYU(state.subtotal),
                style: AppTypography.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Step 2 – Payment Method
// ---------------------------------------------------------------------------

class _PaymentStep extends StatelessWidget {
  const _PaymentStep({required this.state});
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
          _PaymentMethodCard(
            id: 'cash',
            title: 'Efectivo',
            subtitle: 'Pagá en efectivo al momento de la entrega',
            icon: Icons.payments,
            isSelected: state.paymentMethod == 'cash',
            onTap: () => context
                .read<RentalBloc>()
                .add(const RentalEvent.paymentMethodChanged(
                  paymentMethod: 'cash',
                )),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.gameCream.withOpacityValue(0.4),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 20,
                  color: AppColors.gameBrown.withOpacityValue(0.5),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Próximamente más métodos de pago.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.6),
                    ),
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

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gameCream : AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isSelected
                ? AppColors.gameRust
                : AppColors.gameBrown.withOpacityValue(0.15),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.gameRust.withOpacityValue(0.1)
                    : AppColors.gameBrown.withOpacityValue(0.06),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.titleSmall),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.6),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? const Icon(Icons.check_circle, color: AppColors.gameRust)
                  : Icon(
                      Icons.radio_button_unchecked,
                      color: AppColors.gameBrown.withOpacityValue(0.25),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Step 3 – Delivery Method
// ---------------------------------------------------------------------------

class _DeliveryStep extends StatelessWidget {
  const _DeliveryStep({required this.state});
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
                child: _DeliveryOptionCard(
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
                child: _DeliveryOptionCard(
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
          ],
          if (state.isDelivery) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.gameCream.withOpacityValue(0.4),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 18, color: AppColors.gameBrown),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Costo de envío: ${CurrencyFormatter.formatUYU(150)}',
                      style: AppTypography.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DeliveryOptionCard extends StatelessWidget {
  const _DeliveryOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.gameCream : AppColors.card,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: isSelected
                ? AppColors.gameRust
                : AppColors.gameBrown.withOpacityValue(0.15),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.gameRust.withOpacityValue(0.1)
                    : AppColors.gameBrown.withOpacityValue(0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: AppTypography.titleSmall.copyWith(
                color: isSelected ? AppColors.gameRust : AppColors.gameBrown,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.gameBrown.withOpacityValue(0.5),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
            if (isSelected) ...[
              const SizedBox(height: 8),
              const Icon(Icons.check_circle, color: AppColors.gameRust, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Step 4 – Review / Summary (read-only)
// ---------------------------------------------------------------------------

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({
    required this.publication,
    required this.state,
    required this.onEditStep,
  });
  final PublicationListing publication;
  final RentalState state;
  final ValueChanged<int> onEditStep;

  @override
  Widget build(BuildContext context) {
    final start = DateFormatter.parseIso(state.startDate);
    final end = DateFormatter.parseIso(state.endDate);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Resumen del pedido', style: AppTypography.headlineMedium),
          const SizedBox(height: 4),
          Text(
            'Revisá que todo esté correcto antes de enviar.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.gameBrown.withOpacityValue(0.6),
            ),
          ),
          const SizedBox(height: 20),

          _PublicationSummary(publication: publication),
          const SizedBox(height: 16),

          // Dates
          _ReviewSection(
            icon: Icons.calendar_today,
            title: 'Fechas de alquiler',
            onEdit: () => onEditStep(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (start != null && end != null) ...[
                  Text(
                    DateFormatter.formatRange(
                        state.startDate!, state.endDate!),
                    style: AppTypography.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${state.rentalDays} días',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.6),
                    ),
                  ),
                ] else
                  Text(
                    'No seleccionadas',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.destructive,
                    ),
                  ),
              ],
            ),
          ),

          // Payment
          _ReviewSection(
            icon: Icons.payments,
            title: 'Método de pago',
            onEdit: () => onEditStep(1),
            child: Text(
              _paymentLabel(state.paymentMethod),
              style: AppTypography.titleSmall,
            ),
          ),

          // Delivery
          _ReviewSection(
            icon: Icons.local_shipping,
            title: 'Entrega',
            onEdit: () => onEditStep(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.isDelivery ? 'Envío a domicilio' : 'Retiro en punto',
                  style: AppTypography.titleSmall,
                ),
                if (state.isDelivery &&
                    state.deliveryAddress.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    state.deliveryAddress,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.6),
                    ),
                  ),
                ],
                if (state.isDelivery &&
                    state.deliveryComments.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    state.deliveryComments,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gameBrown.withOpacityValue(0.5),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Food bundles
          if (state.selectedFoodBundles.isNotEmpty)
            _ReviewSection(
              icon: Icons.fastfood,
              title: 'Snacks',
              onEdit: () => onEditStep(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.selectedFoodBundles
                    .map((b) => Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(
                            _bundleLabel(b),
                            style: AppTypography.bodySmall,
                          ),
                        ))
                    .toList(),
              ),
            ),

          const SizedBox(height: 16),

          // Price breakdown
          _PriceBreakdown(
            subtotal: state.subtotal,
            days: state.rentalDays,
            pricePerDay: publication.price,
            serviceFee: state.serviceFee,
            deliveryFee: state.deliveryFee,
            foodTotal: state.foodTotal,
            total: state.total,
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  String _paymentLabel(String method) {
    switch (method) {
      case 'cash':
        return 'Efectivo';
      case 'mercadopago':
        return 'Mercado Pago';
      case 'card':
        return 'Tarjeta guardada';
      default:
        return method;
    }
  }

  String _bundleLabel(String id) {
    switch (id) {
      case 'classic':
        return 'Pack Clásico';
      case 'sweet':
        return 'Pack Dulce';
      case 'premium':
        return 'Pack Premium';
      default:
        return id;
    }
  }
}

class _ReviewSection extends StatelessWidget {
  const _ReviewSection({
    required this.icon,
    required this.title,
    required this.onEdit,
    required this.child,
  });
  final IconData icon;
  final String title;
  final VoidCallback onEdit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.gameRust.withOpacityValue(0.08),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Icon(icon, size: 18, color: AppColors.gameRust),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.5),
                  ),
                ),
                const SizedBox(height: 4),
                child,
              ],
            ),
          ),
          GestureDetector(
            onTap: onEdit,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.gameRust.withOpacityValue(0.08),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: AppColors.gameRust,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared widgets
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTypography.sectionHeader);
  }
}

class _PublicationSummary extends StatelessWidget {
  const _PublicationSummary({required this.publication});
  final PublicationListing publication;

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
            child: CachedNetworkImage(
              imageUrl: publication.heroImage,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const ColoredBox(color: AppColors.gameCream),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  publication.title,
                  style: AppTypography.titleSmall,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  publication.categoryName,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.gameBrown.withOpacityValue(0.6),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${CurrencyFormatter.formatUYU(publication.price)}/día',
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

class _FoodBundleSelector extends StatelessWidget {
  const _FoodBundleSelector({
    required this.selectedBundles,
    required this.onBundlesChanged,
  });
  final List<String> selectedBundles;
  final void Function(List<String>) onBundlesChanged;

  static const _bundles = [
    ('classic', 'Pack Clásico', 'Pop, papas y bebidas', '🍿'),
    ('sweet', 'Pack Dulce', 'Chocolates, galletas y jugos', '🍫'),
    ('premium', 'Pack Premium', 'Quesos, fiambres y vino', '🧀'),
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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.gameCream : AppColors.card,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(
                color: isSelected
                    ? AppColors.gameRust
                    : AppColors.gameBrown.withOpacityValue(0.15),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Center(
                    child: Text(bundle.$4, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bundle.$2, style: AppTypography.titleSmall),
                      Text(
                        bundle.$3,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(0.6),
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
  final num subtotal;
  final int days;
  final num pricePerDay;
  final num serviceFee;
  final num deliveryFee;
  final num foodTotal;
  final num total;

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
  final num value;

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
  const _SuccessView({required this.publication, required this.onBackHome});
  final PublicationListing publication;
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
                '¡Solicitud enviada!',
                style: AppTypography.displaySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Tu solicitud de alquiler de ${publication.title} fue enviada. El propietario deberá aceptarla.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.gameBrown.withOpacityValue(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Te notificaremos cuando el propietario acepte tu solicitud.',
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
