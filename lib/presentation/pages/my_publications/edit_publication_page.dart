import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/presentation/blocs/my_publications/edit_publication/edit_publication_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/my_publications/steps/edit_data_step.dart';
import 'package:mobile_table_hopping/presentation/pages/my_publications/steps/edit_photos_step.dart';
import 'package:mobile_table_hopping/presentation/pages/my_publications/steps/edit_price_step.dart';
import 'package:mobile_table_hopping/presentation/pages/my_publications/steps/edit_review_step.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/organisms/common/state_feedback_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/confirm_action_dialog.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/feedback_messenger.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/wizard_scaffold.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/my_publications/edit_success_view.dart';

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
          FeedbackMessenger.showSuccess(
            context,
            message: 'Publicación eliminada exitosamente',
          );
          context.go('/my-publications');
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const _LoadingView();
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

        return WizardScaffold(
          title: 'Editar Publicación',
          onLeadingPressed: () => _handleBack(context, state),
          appBarActions: [
            AppBarIconAction(
              icon: Icons.delete_outline,
              iconColor: AppColors.destructive,
              tooltip: 'Eliminar publicación',
              onPressed: state.isDeleting
                  ? null
                  : () => _showDeleteConfirmation(context),
            ),
          ],
          currentStep: state.currentStep,
          steps: const ['Datos', 'Fotos', 'Precio', 'Revisión'],
          body: IndexedStack(
            index: state.currentStep,
            children: [
              EditDataStep(
                description: state.form.description,
                condition: state.form.condition,
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
                descriptionError: state.form.descriptionError,
                conditionError: state.form.conditionError,
              ),
              EditPhotosStep(
                images: state.images,
                isUploading: state.isUploadingImage,
                onImagesChanged: (v) => context.read<EditPublicationBloc>().add(
                  EditPublicationEvent.imagesChanged(v),
                ),
                onAddImage: () => context.read<EditPublicationBloc>().add(
                  const EditPublicationEvent.pickMultipleImages(),
                ),
              ),
              EditPriceStep(
                price: state.form.price,
                deliveryMethods: state.deliveryMethods,
                availableDeliveryMethods: state.availableDeliveryMethods,
                onPriceChanged: (v) => context.read<EditPublicationBloc>().add(
                  EditPublicationEvent.priceChanged(v),
                ),
                priceError: state.form.priceError,
                onDeliveryMethodsChanged: (v) =>
                    context.read<EditPublicationBloc>().add(
                      EditPublicationEvent.deliveryMethodsChanged(v),
                    ),
              ),
              EditReviewStep(
                selectedGame: state.selectedGame,
                description: state.form.description,
                price: state.form.price,
                condition: state.form.condition,
                images: state.images,
              ),
            ],
          ),
          inlineErrorMessage:
              state.errorMessage != null && state.publication != null
              ? state.errorMessage
              : null,
          primaryLabel: state.currentStep == 3
              ? 'Guardar Cambios'
              : 'Siguiente',
          onPrimaryPressed: (!state.canProceed || state.isSubmitting)
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
          secondaryLabel: state.currentStep > 0 ? 'Anterior' : null,
          onSecondaryPressed: state.currentStep > 0
              ? () => context.read<EditPublicationBloc>().add(
                  const EditPublicationEvent.previousStep(),
                )
              : null,
          isSubmitting: state.isSubmitting,
        );
      },
    );
  }

  Future<void> _handleBack(
    BuildContext context,
    EditPublicationState state,
  ) async {
    if (state.hasChanges) {
      final confirmed = await ConfirmActionDialog.show(
        context: context,
        title: '¿Descartar cambios?',
        message: 'Tienes cambios sin guardar. ¿Estás seguro que quieres salir?',
        confirmLabel: 'Descartar',
        cancelLabel: 'Cancelar',
        isDestructive: true,
      );
      if (confirmed && context.mounted) {
        context.pop();
      }
    } else {
      context.pop();
    }
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await ConfirmActionDialog.show(
      context: context,
      title: '¿Eliminar publicación?',
      message:
          'Esta acción no se puede deshacer. ¿Estás seguro que quieres eliminar esta publicación?',
      confirmLabel: 'Eliminar',
      cancelLabel: 'Cancelar',
      isDestructive: true,
    );
    if (confirmed && context.mounted) {
      context.read<EditPublicationBloc>().add(
        const EditPublicationEvent.delete(),
      );
    }
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PageAppBar(title: Text('Editar Publicación')),
      body: StateFeedbackView(
        variant: StateFeedbackVariant.loading,
        message: 'Cargando publicación...',
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
      appBar: const PageAppBar(title: Text('Editar Publicación')),
      body: StateFeedbackView(
        variant: StateFeedbackVariant.error,
        title: 'Oops! Algo salió mal',
        message: message,
        icon: Icons.error_outline,
        primaryActionLabel: 'Reintentar',
        onPrimaryAction: onRetry,
      ),
    );
  }
}
