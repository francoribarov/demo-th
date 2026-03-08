import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';

class PublicationDetailsErrorView extends StatelessWidget {
  const PublicationDetailsErrorView({
    required this.errorMessage,
    required this.onBack,
    required this.onGoHome,
    super.key,
  });

  final String? errorMessage;
  final VoidCallback onBack;
  final VoidCallback onGoHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        title: const Text('Detalle'),
        onLeadingPressed: onBack,
      ),
      body: StateFeedbackView(
        variant: StateFeedbackVariant.error,
        title: errorMessage ?? 'Juego no encontrado',
        primaryActionLabel: 'Volver al inicio',
        onPrimaryAction: onGoHome,
      ),
    );
  }
}
