import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/routing/app_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/widgets/app_alert_dialog.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/rental_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/steps/checkout_date_step.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/steps/checkout_delivery_step.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/steps/checkout_payment_step.dart';
import 'package:mobile_table_hopping/presentation/pages/rental/steps/checkout_review_step.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/checkout_bottom_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/rental/checkout_progress_bar.dart';
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
  State<RentalConfirmPage> createState() => _RentalConfirmPageState();
}

class _RentalConfirmPageState extends State<RentalConfirmPage> {
  final _pageController = PageController();
  int _currentStep = 0;
  bool _isAnimating = false;

  static const _totalSteps = 4;
  static const _stepLabels = [
    'Fechas',
    'Pago',
    'Entrega',
    'Resumen',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _isStepValid(
    int step,
    RentalState state,
  ) {
    switch (step) {
      case 0:
        final start = state.startDate;
        final end = state.endDate;
        return start != null &&
            start.isNotEmpty &&
            end != null &&
            end.isNotEmpty;
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

  /// The furthest step reachable given the
  /// current state. Re-evaluated on every
  /// build so clearing data on a previous step
  /// immediately locks later ones.
  int _maxReachableStep(RentalState state) {
    for (var i = 0; i < _totalSteps - 1; i++) {
      if (!_isStepValid(i, state)) return i;
    }
    return _totalSteps - 1;
  }

  void _animateToStep(int step) {
    if (_isAnimating) return;
    _isAnimating = true;
    unawaited(
      _pageController
          .animateToPage(
        step,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .whenComplete(() {
        if (mounted) _isAnimating = false;
      }),
    );
    setState(() => _currentStep = step);
  }

  void _goToStep(int step, RentalState state) {
    if (step < 0 || step >= _totalSteps) return;
    final max = _maxReachableStep(state);
    if (step > max) return;
    _animateToStep(step);
  }

  void _tryNext(RentalState state) {
    if (_isAnimating) return;
    if (!_isStepValid(_currentStep, state)) {
      _showValidationError(
        _currentStep,
        state,
      );
      return;
    }
    _animateToStep(_currentStep + 1);
  }

  void _back() {
    if (_currentStep > 0) {
      _animateToStep(_currentStep - 1);
    }
  }

  void _showSubmitErrorDialog(BuildContext context) {
    unawaited(
      AppAlertDialog.showAlert(
        context,
        title: 'No pudimos enviar tu solicitud',
      ),
    );
  }

  void _showValidationError(
    int step,
    RentalState state,
  ) {
    String? msg;
    switch (step) {
      case 0:
        msg = 'Seleccioná las fechas de '
            'inicio y fin del alquiler.';
      case 2:
        if (state.isDelivery && state.deliveryAddress.trim().isEmpty) {
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
          (prev.snackbarMessage != curr.snackbarMessage &&
              curr.snackbarMessage != null) ||
          (prev.isSubmitting &&
              !curr.isSubmitting &&
              curr.errorMessage != null),
      listener: (context, state) {
        if (state.errorMessage != null && !state.isSubmitting) {
          _showSubmitErrorDialog(context);
          return;
        }
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
                onPressed: () => context.popOrGo(
                  '/publications/'
                  '${widget.publicationId}',
                ),
              ),
            ),
            body: Center(
              child: Text(
                state.errorMessage ?? 'Publicación no encontrada',
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

        final max = _maxReachableStep(state);
        if (_currentStep > max && !_isAnimating) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _currentStep > max) {
              _animateToStep(max);
            }
          });
        }

        return PopScope(
          canPop: _currentStep == 0,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop && _currentStep > 0) {
              _back();
            }
          },
          child: Scaffold(
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
                CheckoutProgressBar(
                  currentStep: _currentStep,
                  totalSteps: _totalSteps,
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) => setState(
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
                        onEditStep: (step) => _goToStep(step, state),
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
                  onSubmit: () => context.read<RentalBloc>().add(
                        const RentalEvent.submitted(),
                      ),
                  totalPrice: state.total,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
