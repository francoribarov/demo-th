import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/steps/checkout_date_step.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/steps/checkout_delivery_step.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/steps/checkout_payment_step.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/steps/checkout_review_step.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/checkout_bottom_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/checkout_step_indicator.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/rental_success_view.dart';

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
  State<RentalConfirmPage> createState() =>
      _RentalConfirmPageState();
}

class _RentalConfirmPageState
    extends State<RentalConfirmPage> {
  final _pageController = PageController();
  int _currentStep = 0;

  // Tracks the furthest step the user has
  // legitimately reached via validation.
  int _highestUnlockedStep = 0;

  static const _totalSteps = 4;
  static const _stepLabels = [
    'Fechas',
    'Pago',
    'Entrega',
    'Resumen',
  ];
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
    if (step > _highestUnlockedStep) return;
    _pageController.animateToPage(
      step,
      duration:
          const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentStep = step);
  }

  void _tryNext(RentalState state) {
    if (!_isStepValid(_currentStep, state)) {
      _showValidationError(
        _currentStep,
        state,
      );
      return;
    }
    final next = _currentStep + 1;
    if (next > _highestUnlockedStep) {
      setState(
        () => _highestUnlockedStep = next,
      );
    }
    _goToStep(next);
  }

  void _back() => _goToStep(_currentStep - 1);

  bool _isStepValid(
    int step,
    RentalState state,
  ) {
    switch (step) {
      case 0:
        return state.startDate != null &&
            state.endDate != null;
      case 1:
        return state.paymentMethod.isNotEmpty;
      case 2:
        if (state.isDelivery &&
            state.deliveryAddress
                .trim()
                .isEmpty) {
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _showValidationError(
    int step,
    RentalState state,
  ) {
    String? msg;
    switch (step) {
      case 0:
        if (state.startDate == null ||
            state.endDate == null) {
          msg = 'Seleccioná las fechas de '
              'inicio y fin del alquiler.';
        }
      case 2:
        if (state.isDelivery &&
            state.deliveryAddress
                .trim()
                .isEmpty) {
          msg = 'Ingresá una dirección '
              'de entrega.';
        }
    }
    if (msg != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RentalBloc, RentalState>(
      listenWhen: (prev, curr) =>
          prev.snackbarMessage !=
              curr.snackbarMessage &&
          curr.snackbarMessage != null,
      listener: (context, state) {
        final message = state.snackbarMessage;
        if (message == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        context.read<RentalBloc>().add(
              const RentalEvent.messageShown(),
            );
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.gameRust,
              ),
            ),
          );
        }

        final publication = state.publication;
        if (publication == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () =>
                    context.popOrGo(
                  '/publications/'
                  '${widget.publicationId}',
                ),
              ),
            ),
            body: Center(
              child: Text(
                state.errorMessage ??
                    'Publicación no encontrada',
              ),
            ),
          );
        }

        if (state.success) {
          return RentalSuccessView(
            publication: publication,
            onBackHome: () => context.go('/'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                if (_currentStep > 0) {
                  _back();
                } else {
                  context.popOrGo(
                    '/publications/'
                    '${widget.publicationId}',
                  );
                }
              },
            ),
            title: Text(
              _stepLabels[_currentStep],
            ),
          ),
          body: Column(
            children: [
              CheckoutStepIndicator(
                currentStep: _currentStep,
                totalSteps: _totalSteps,
                labels: _stepLabels,
                icons: _stepIcons,
                onStepTapped: _goToStep,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) =>
                      setState(
                    () => _currentStep = i,
                  ),
                  children: [
                    CheckoutDateStep(
                      publication: publication,
                      state: state,
                    ),
                    CheckoutPaymentStep(
                      state: state,
                    ),
                    CheckoutDeliveryStep(
                      state: state,
                    ),
                    CheckoutReviewStep(
                      publication: publication,
                      state: state,
                      onEditStep: _goToStep,
                    ),
                  ],
                ),
              ),
              CheckoutBottomBar(
                currentStep: _currentStep,
                totalSteps: _totalSteps,
                canAdvance: _isStepValid(
                  _currentStep,
                  state,
                ),
                isSubmitting: state.isSubmitting,
                onNext: () => _tryNext(state),
                onBack: _back,
                onSubmit: () => context
                    .read<RentalBloc>()
                    .add(
                      const RentalEvent
                          .submitted(),
                    ),
                errorMessage: state.errorMessage,
                totalPrice: state.total,
              ),
            ],
          ),
        );
      },
    );
  }
}
