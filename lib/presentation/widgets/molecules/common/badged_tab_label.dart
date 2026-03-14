import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';

/// A tab label that shows a red badge with a count when [count] > 0.
class BadgedTabLabel extends StatelessWidget {
  const BadgedTabLabel({
    required this.label,
    required this.count,
    super.key,
  });

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return Text(label);

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          const SizedBox(width: 4),
          Badge(
            label: Text(count.toString()),
            backgroundColor: AppColors.statusRejected,
            textColor: AppColors.primaryForeground,
          ),
        ],
      ),
    );
  }
}
