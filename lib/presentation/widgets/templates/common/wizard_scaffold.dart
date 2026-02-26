import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/button_loading_indicator.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/inline_feedback_text.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
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
    this.contentPadding = const EdgeInsets.all(16),
    this.extendBottomSafeArea = true,
  });

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
  final EdgeInsetsGeometry contentPadding;
  final bool extendBottomSafeArea;

  @override
  Widget build(BuildContext context) {
    final hasSecondary =
        secondaryLabel != null &&
        secondaryLabel!.isNotEmpty &&
        onSecondaryPressed != null;

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
              padding: contentPadding,
              child: body,
            ),
          ),
          if (inlineErrorMessage != null)
            InlineFeedbackText(
              message: inlineErrorMessage!,
              textAlign: inlineErrorTextAlign,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border(
                top: BorderSide(
                  color: AppColors.gameBrown.withOpacityValue(0.1),
                ),
              ),
            ),
            child: extendBottomSafeArea
                ? SafeArea(top: false, child: _buildFooterRow(hasSecondary))
                : _buildFooterRow(hasSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterRow(bool hasSecondary) {
    return Row(
      children: [
        if (hasSecondary)
          Expanded(
            child: OutlinedButton(
              onPressed: isSubmitting ? null : onSecondaryPressed,
              child: Text(secondaryLabel!),
            ),
          ),
        if (hasSecondary) const SizedBox(width: 16),
        Expanded(
          flex: hasSecondary ? 2 : 1,
          child: ElevatedButton(
            onPressed: isSubmitting ? null : onPrimaryPressed,
            child: isSubmitting
                ? (submittingChild ?? const ButtonLoadingIndicator())
                : Text(primaryLabel),
          ),
        ),
      ],
    );
  }
}
