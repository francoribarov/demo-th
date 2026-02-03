import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

class PublicationDetailsLoadingView extends StatelessWidget {
  const PublicationDetailsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: AppColors.gameRust),
      ),
    );
  }
}
