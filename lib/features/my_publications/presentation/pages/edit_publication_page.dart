import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/widgets/app_alert_dialog.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/edit_publication_bloc.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/pages/steps/edit_data_step.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/pages/steps/edit_photos_step.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/pages/steps/edit_price_step.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/pages/steps/edit_review_step.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/edit_success_view.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';
import 'package:mobile_table_hopping/features/publish/presentation/widgets/step_indicator.dart';

/// Page for editing an existing publication.
class EditPublicationPage extends StatelessWidget {
  /// Creates the edit publication page.
  const EditPublicationPage({
    required this.publicationId,
    super.key,
  });

  /// The ID of the publication to edit.
  final String publicationId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditPublicationBloc, EditPublicationState>(
      listener: (context, state) {
        if (state.deleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Publicación eliminada exitosamente'),
              backgroundColor: AppColors.success,
            ),
          );
          context.go('/my-publications');
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return _LoadingView();
        }

        if (state.errorMessage != null && state.publication == null) {
          return _ErrorView(
            message: state.errorMessage!,
            onRetry: () => context.read<EditPublicationBloc>().add(
              EditPublicationEvent.started(publicationId: publicationId),
            ),
          );
        }

        if (state.success) {
          return EditSuccessView(
            onBackToPublications: () => context.go('/my-publications'),
            onViewPublication: () => context.go('/publications/$publicationId'),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Editar Publicación'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _handleBack(context, state),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: AppColors.destructive,
                onPressed: state.isDeleting
                    ? null
                    : () => _showDeleteConfirmation(context),
              ),
            ],
          ),
          body: Column(
            children: [
              // Progress indicator
              StepIndicator(
                currentStep: state.currentStep,
                steps: const ['Datos', 'Fotos', 'Precio', 'Revisión'],
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: IndexedStack(
                    index: state.currentStep,
                    children: [
                      EditDataStep(
                        description: state.description,
                        condition: state.condition,
                        conditions: PublicationCondition.values,
                        selectedGame: state.selectedGame,
                        onDescriptionChanged: (v) =>
                            context.read<EditPublicationBloc>().add(
                              EditPublicationEvent.descriptionChanged(v),
                            ),
                        onConditionChanged: (v) =>
                            context.read<EditPublicationBloc>().add(
                              EditPublicationEvent.conditionChanged(v),
                            ),
                      ),
                      EditPhotosStep(
                        images: state.images,
                        isUploading: state.isUploadingImage,
                        onImagesChanged: (v) =>
                            context.read<EditPublicationBloc>().add(
                              EditPublicationEvent.imagesChanged(v),
                            ),
                        onAddImage: () =>
                            context.read<EditPublicationBloc>().add(
                              const EditPublicationEvent.pickMultipleImages(),
                            ),
                      ),
                      EditPriceStep(
                        price: state.price,
                        deliveryMethods: state.deliveryMethods,
                        availableDeliveryMethods:
                            state.availableDeliveryMethods,
                        onPriceChanged: (v) =>
                            context.read<EditPublicationBloc>().add(
                              EditPublicationEvent.priceChanged(v),
                            ),
                        onDeliveryMethodsChanged: (v) =>
                            context.read<EditPublicationBloc>().add(
                              EditPublicationEvent.deliveryMethodsChanged(v),
                            ),
                      ),
                      EditReviewStep(
                        selectedGame: state.selectedGame,
                        description: state.description,
                        price: state.price,
                        condition: state.condition,
                        images: state.images,
                      ),
                    ],
                  ),
                ),
              ),

              if (state.errorMessage != null && state.publication != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.errorMessage!,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.destructive,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Navigation buttons
              _NavigationButtons(state: state),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleBack(
    BuildContext context,
    EditPublicationState state,
  ) async {
    if (state.hasChanges) {
      final discard = await AppAlertDialog.showConfirm(
        context,
        title: '¿Descartar cambios?',
        confirmText: 'Descartar',
        content: 'Tienes cambios sin guardar. ¿Estás seguro que quieres salir?',
        isDestructive: true,
      );
      if (context.mounted && (discard ?? false)) context.pop();
    } else {
      context.pop();
    }
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    await AppAlertDialog.showConfirm(
      context,
      title: '¿Eliminar publicación?',
      content:
          'Esta acción no se puede deshacer. ¿Estás seguro que quieres '
          'eliminar esta publicación?',
      confirmText: 'Eliminar',
      isDestructive: true,
      onConfirm: () => context.read<EditPublicationBloc>().add(
        const EditPublicationEvent.delete(),
      ),
    );
  }
}

class _NavigationButtons extends StatelessWidget {
  const _NavigationButtons({required this.state});

  final EditPublicationState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(
          top: BorderSide(
            color: AppColors.gameBrown.withOpacityValue(0.1),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (state.currentStep > 0)
              Expanded(
                child: OutlinedButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.read<EditPublicationBloc>().add(
                          const EditPublicationEvent.previousStep(),
                        ),
                  child: const Text('Anterior'),
                ),
              ),
            if (state.currentStep > 0) const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: (!state.canProceed || state.isSubmitting)
                    ? null
                    : () {
                        if (state.currentStep == 3) {
                          context.read<EditPublicationBloc>().add(
                            const EditPublicationEvent.submit(),
                          );
                        } else {
                          context.read<EditPublicationBloc>().add(
                            const EditPublicationEvent.nextStep(),
                          );
                        }
                      },
                child: state.isSubmitting
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        state.currentStep == 3
                            ? 'Guardar Cambios'
                            : 'Siguiente',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Publicación')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.gameRust),
            SizedBox(height: 16),
            Text('Cargando publicación...'),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Publicación')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacityValue(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Oops! Algo salió mal',
                style: AppTypography.titleLarge.copyWith(
                  color: AppColors.foreground,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.mutedForeground,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gameRust,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
