import 'package:flutter/material.dart';

import 'package:mobile_table_hopping/presentation/widgets/templates/common/success_state_view.dart';

/// View shown after a game has been successfully published.
class PublishSuccessView extends StatelessWidget {
  /// Creates a [PublishSuccessView].
  const PublishSuccessView({
    required this.onBackHome,
    required this.onPublishAnother,
    super.key,
  });

  /// Callback to navigate back home.
  final VoidCallback onBackHome;

  /// Callback to start another publishing flow.
  final VoidCallback onPublishAnother;

  @override
  Widget build(BuildContext context) {
    return SuccessStateView(
      title: '¡Juego publicado!',
      subtitle: 'Tu publicación ya está disponible para alquilar.',
      primaryActionLabel: 'Volver al inicio',
      onPrimaryAction: onBackHome,
      secondaryActionLabel: 'Publicar otro juego',
      onSecondaryAction: onPublishAnother,
    );
  }
}
