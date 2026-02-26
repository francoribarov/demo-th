import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/presentation/widgets/templates/common/success_state_view.dart';

/// Success view shown after successfully updating a publication.
class EditSuccessView extends StatelessWidget {
  /// Creates the edit success view.
  const EditSuccessView({
    required this.onBackToPublications,
    required this.onViewPublication,
    super.key,
  });

  /// Callback to go back to publications list.
  final VoidCallback onBackToPublications;

  /// Callback to view the updated publication.
  final VoidCallback onViewPublication;

  @override
  Widget build(BuildContext context) {
    return SuccessStateView(
      title: '¡Cambios guardados!',
      subtitle: 'Tu publicación ha sido actualizada exitosamente.',
      primaryActionLabel: 'Ver publicación',
      onPrimaryAction: onViewPublication,
      secondaryActionLabel: 'Volver a mis publicaciones',
      onSecondaryAction: onBackToPublications,
    );
  }
}
