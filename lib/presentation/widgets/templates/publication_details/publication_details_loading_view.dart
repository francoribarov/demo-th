import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';

class PublicationDetailsLoadingView extends StatelessWidget {
  const PublicationDetailsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StateFeedbackView(
        variant: StateFeedbackVariant.loading,
      ),
    );
  }
}
