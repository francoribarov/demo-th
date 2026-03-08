import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';

class MyPublicationsLoadingView extends StatelessWidget {
  const MyPublicationsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const StateFeedbackView(
      variant: StateFeedbackVariant.loading,
      message: 'Cargando tus publicaciones...',
    );
  }
}
