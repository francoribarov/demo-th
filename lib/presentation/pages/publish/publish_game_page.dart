import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/domain/model/publish/publication.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/game_search_cubit.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/delivery_method_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/image_upload_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/publish_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/data_step.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/photos_step.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/price_step.dart';
import 'package:mobile_table_hopping/presentation/pages/publish/steps/review_step.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/wizard_scaffold.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/publish/publish_success_view.dart';

/// Publish game page matching PublishGame.tsx wizard.
class PublishGamePage extends StatefulWidget {
  /// Creates the publish game page.
  const PublishGamePage({super.key});

  @override
  State<PublishGamePage> createState() => _PublishGamePageState();
}

class _PublishGamePageState extends State<PublishGamePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      context.read<DeliveryMethodBloc>().add(
        const DeliveryMethodEvent.started(),
      );
      await context.read<GameSearchCubit>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublishBloc, PublishState>(
      builder: (context, publishState) {
        if (publishState.success) {
          return PublishSuccessView(
            onBackHome: () => context.go('/'),
            onPublishAnother: () {
              context.read<PublishBloc>().add(
                const PublishEvent.publishAnother(),
              );
              context.read<ImageUploadBloc>().add(
                const ImageUploadEvent.reset(),
              );
              context.read<DeliveryMethodBloc>().add(
                const DeliveryMethodEvent.reset(),
              );
            },
          );
        }

        return BlocBuilder<GameSearchCubit, GameSearchState>(
          builder: (context, gameSearchState) {
            return BlocBuilder<ImageUploadBloc, ImageUploadState>(
              builder: (context, imageState) {
                return BlocBuilder<DeliveryMethodBloc, DeliveryMethodState>(
                  builder: (context, deliveryState) {
                    return WizardScaffold(
                      title: 'Publicar juego',
                      leadingType: PageAppBarLeadingType.close,
                      onLeadingPressed: () => context.go('/'),
                      currentStep: publishState.currentStep,
                      steps: const ['Datos', 'Fotos', 'Precio', 'Revisión'],
                      body: IndexedStack(
                        index: publishState.currentStep,
                        children: [
                          DataStep(
                            formVersion: publishState.formVersion,
                            gameId: publishState.form.gameId,
                            description: publishState.form.description,
                            condition: publishState.form.condition,
                            conditions: PublicationCondition.values,
                            allGames: gameSearchState.allGames,
                            filteredGames: gameSearchState.filteredGames,
                            isLoadingGames: gameSearchState.isLoading,
                            onGameIdChanged: (v) => context.read<PublishBloc>().add(
                              PublishEvent.gameIdChanged(v),
                            ),
                            onGameSearchChanged: (v) => context.read<GameSearchCubit>().search(v),
                            onGameSearchCleared: () => context.read<GameSearchCubit>().search(''),
                            onDescriptionChanged: (v) => context.read<PublishBloc>().add(
                              PublishEvent.descriptionChanged(v),
                            ),
                            onConditionChanged: (v) => context.read<PublishBloc>().add(
                              PublishEvent.conditionChanged(v),
                            ),
                            descriptionError: publishState.form.descriptionError,
                            conditionError: publishState.form.conditionError,
                          ),
                          PhotosStep(
                            images: imageState.images,
                            isUploading: imageState.isUploading,
                            onAddImage: () => context.read<ImageUploadBloc>().add(
                              const ImageUploadEvent.pickAndUpload(),
                            ),
                            onRemoveImage: (index) => context.read<ImageUploadBloc>().add(
                              ImageUploadEvent.imageRemoved(index),
                            ),
                          ),
                          PriceStep(
                            formVersion: publishState.formVersion,
                            price: publishState.form.price,
                            deliveryMethods: deliveryState.selectedMethods,
                            availableDeliveryMethods: deliveryState.availableMethods,
                            onPriceChanged: (v) => context.read<PublishBloc>().add(
                              PublishEvent.priceChanged(v),
                            ),
                            priceError: publishState.form.priceError,
                            onToggleDeliveryMethod: (method) => context.read<DeliveryMethodBloc>().add(
                              DeliveryMethodEvent.methodToggled(method),
                            ),
                            onAddDeliveryMethod: (method) => context.read<DeliveryMethodBloc>().add(
                              DeliveryMethodEvent.methodCreated(method),
                            ),
                          ),
                          ReviewStep(
                            gameId: publishState.form.gameId,
                            description: publishState.form.description,
                            price: publishState.form.price,
                            condition: publishState.form.condition,
                            images: imageState.images,
                          ),
                        ],
                      ),
                      inlineErrorMessage: publishState.errorMessage,
                      primaryLabel: publishState.currentStep == 3 ? 'Publicar' : 'Siguiente',
                      onPrimaryPressed: (!publishState.isStepValid || publishState.isSubmitting)
                          ? null
                          : () {
                              if (publishState.currentStep == 3) {
                                context.read<PublishBloc>().add(
                                  PublishEvent.submit(
                                    images: imageState.images,
                                    deliveryMethods: deliveryState.selectedMethods,
                                  ),
                                );
                              } else {
                                context.read<PublishBloc>().add(
                                  const PublishEvent.nextStep(),
                                );
                              }
                            },
                      secondaryLabel: publishState.currentStep > 0 ? 'Anterior' : null,
                      onSecondaryPressed: publishState.currentStep > 0
                          ? () => context.read<PublishBloc>().add(
                              const PublishEvent.previousStep(),
                            )
                          : null,
                      isSubmitting: publishState.isSubmitting,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
