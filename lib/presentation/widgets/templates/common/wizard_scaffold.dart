import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/wizard_navigation_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/publish/step_indicator.dart';

/// Shared scaffold used by multi-step wizard pages.
class WizardScaffold extends StatelessWidget {
  /// Creates a [WizardScaffold].
  const WizardScaffold({
    required this.title,
    required this.currentStep,
    required this.steps,
    required this.body,
    required this.primaryLabel,
    super.key,
    this.leadingType = PageAppBarLeadingType.back,
    this.onLeadingPressed,
    this.appBarActions = const [],
    this.inlineErrorMessage,
    this.inlineErrorTextAlign = TextAlign.center,
    this.onPrimaryPressed,
    this.secondaryLabel,
    this.onSecondaryPressed,
    this.isSubmitting = false,
    this.submittingChild,
    EdgeInsetsGeometry? contentPadding,
    this.extendBottomSafeArea = true,
  }) : _contentPadding =
           contentPadding ?? const EdgeInsets.all(AppTheme.spacingLg);

  final String title;
  final PageAppBarLeadingType leadingType;
  final VoidCallback? onLeadingPressed;
  final List<Widget> appBarActions;
  final int currentStep;
  final List<String> steps;
  final Widget body;
  final String? inlineErrorMessage;
  final TextAlign inlineErrorTextAlign;
  final String primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final bool isSubmitting;
  final Widget? submittingChild;
  final EdgeInsetsGeometry _contentPadding;
  final bool extendBottomSafeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: Text(title),
        leadingType: leadingType,
        onLeadingPressed: onLeadingPressed,
        actions: appBarActions,
      ),
      body: Column(
        children: [
          StepIndicator(currentStep: currentStep, steps: steps),
          Expanded(
            child: SingleChildScrollView(
              padding: _contentPadding,
              child: body,
            ),
          ),
          if (inlineErrorMessage != null)
            InlineFeedbackText(
              message: inlineErrorMessage!,
              textAlign: inlineErrorTextAlign,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLg,
              ),
            ),
          WizardNavigationBar(
            primaryLabel: primaryLabel,
            onPrimaryPressed: onPrimaryPressed,
            secondaryLabel: secondaryLabel,
            onSecondaryPressed: onSecondaryPressed,
            isSubmitting: isSubmitting,
            submittingChild: submittingChild,
            extendBottomSafeArea: extendBottomSafeArea,
          ),
        ],
      ),
    );
  }
}
