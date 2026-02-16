import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/delivery_method_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/image_upload_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/publish_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/data_step.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/photos_step.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/price_step.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/review_step.dart';
import 'package:mobile_table_hopping/presentation/widgets/publish/publish_success_view.dart';
import 'package:mobile_table_hopping/presentation/widgets/publish/step_indicator.dart';

/// Publish game page matching PublishGame.tsx wizard.
class PublishGamePage extends StatelessWidget {
  /// Creates the publish game page.
  const PublishGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublishBloc, PublishState>(
      builder: (context, publishState) {
        if (publishState.success) {
          return PublishSuccessView(
            onBackHome: () => context.go('/'),
            onPublishAnother: () {
              context
                  .read<PublishBloc>()
                  .add(const PublishEvent.publishAnother());
              context
                  .read<ImageUploadBloc>()
                  .add(const ImageUploadEvent.reset());
              context
                  .read<DeliveryMethodBloc>()
                  .add(const DeliveryMethodEvent.reset());
            },
          );
        }

        return BlocBuilder<ImageUploadBloc, ImageUploadState>(
          builder: (context, imageState) {
            return BlocBuilder<DeliveryMethodBloc, DeliveryMethodState>(
              builder: (context, deliveryState) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Publicar juego'),
                    leading: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => context.go('/'),
                    ),
                  ),
                  body: Column(
                    children: [
                      // Progress indicator
                      StepIndicator(
                        currentStep: publishState.currentStep,
                        steps: const ['Datos', 'Fotos', 'Precio', 'Revisión'],
                      ),

                      // Content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: IndexedStack(
                            index: publishState.currentStep,
                            children: [
                              DataStep(
                                formVersion: publishState.formVersion,
                                gameId: publishState.gameId,
                                description: publishState.description,
                                condition: publishState.condition,
                                conditions: PublicationCondition.values,
                                onGameIdChanged: (v) => context
                                    .read<PublishBloc>()
                                    .add(PublishEvent.gameIdChanged(v)),
                                onDescriptionChanged: (v) => context
                                    .read<PublishBloc>()
                                    .add(PublishEvent.descriptionChanged(v)),
                                onConditionChanged: (v) => context
                                    .read<PublishBloc>()
                                    .add(PublishEvent.conditionChanged(v)),
                              ),
                              PhotosStep(
                                images: imageState.images,
                                isUploading: imageState.isUploading,
                                onAddImage: () => context
                                    .read<ImageUploadBloc>()
                                    .add(
                                        const ImageUploadEvent.pickAndUpload()),
                                onRemoveImage: (index) => context
                                    .read<ImageUploadBloc>()
                                    .add(ImageUploadEvent.imageRemoved(index)),
                              ),
                              PriceStep(
                                formVersion: publishState.formVersion,
                                price: publishState.price,
                                deliveryMethods: deliveryState.selectedMethods,
                                availableDeliveryMethods:
                                    deliveryState.availableMethods,
                                onPriceChanged: (v) => context
                                    .read<PublishBloc>()
                                    .add(PublishEvent.priceChanged(v)),
                                onToggleDeliveryMethod: (method) => context
                                    .read<DeliveryMethodBloc>()
                                    .add(
                                      DeliveryMethodEvent.methodToggled(method),
                                    ),
                                onAddDeliveryMethod: (method) => context
                                    .read<DeliveryMethodBloc>()
                                    .add(
                                      DeliveryMethodEvent.methodCreated(method),
                                    ),
                              ),
                              ReviewStep(
                                gameId: publishState.gameId,
                                description: publishState.description,
                                price: publishState.price,
                                condition: publishState.condition,
                                images: imageState.images,
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (publishState.errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            publishState.errorMessage!,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.destructive,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      // Navigation buttons
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
                        child: SafeArea(
                          child: Row(
                            children: [
                              if (publishState.currentStep > 0)
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: publishState.isSubmitting
                                        ? null
                                        : () => context.read<PublishBloc>().add(
                                              const PublishEvent.previousStep(),
                                            ),
                                    child: const Text('Anterior'),
                                  ),
                                ),
                              if (publishState.currentStep > 0)
                                const SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: ElevatedButton(
                                  onPressed: (!publishState.isStepValid ||
                                          publishState.isSubmitting)
                                      ? null
                                      : () {
                                          if (publishState.currentStep == 3) {
                                            context.read<PublishBloc>().add(
                                                  PublishEvent.submit(
                                                    images: imageState.images,
                                                    deliveryMethods:
                                                        deliveryState
                                                            .selectedMethods,
                                                  ),
                                                );
                                          } else {
                                            context.read<PublishBloc>().add(
                                                  const PublishEvent.nextStep(),
                                                );
                                          }
                                        },
                                  child: publishState.isSubmitting
                                      ? const SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          publishState.currentStep == 3
                                              ? 'Publicar'
                                              : 'Siguiente',
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
