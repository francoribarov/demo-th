import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:mobile_table_hopping/features/publish/presentation/pages/steps/data_step.dart';
import 'package:mobile_table_hopping/features/publish/presentation/pages/steps/photos_step.dart';
import 'package:mobile_table_hopping/features/publish/presentation/pages/steps/price_step.dart';
import 'package:mobile_table_hopping/features/publish/presentation/pages/steps/review_step.dart';
import 'package:mobile_table_hopping/features/publish/presentation/widgets/publish_success_view.dart';
import 'package:mobile_table_hopping/features/publish/presentation/widgets/step_indicator.dart';

/// Publish game page matching PublishGame.tsx wizard.
class PublishGamePage extends StatelessWidget {
  /// Creates the publish game page.
  const PublishGamePage({super.key});

  static const _categories = ['Estrategia', 'Cooperativo', 'Familiar', 'Fiesta', 'Experto', 'Abstracto'];

  static const _difficulties = ['Fácil', 'Medio', 'Difícil', 'Experto'];
  static const _conditions = [
    ('new', 'Nuevo', 'Sellado o usado una vez'),
    ('like_new', 'Como nuevo', 'Excelente estado, sin marcas'),
    ('good', 'Buen estado', 'Uso normal, todo completo'),
    ('fair', 'Aceptable', 'Desgaste visible pero funcional'),
    ('worn', 'Usado', 'Muy jugado, puede faltar algo'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublishBloc, PublishState>(
      builder: (context, state) {
        if (state.success) {
          return PublishSuccessView(
            title: state.title,
            onBackHome: () => context.go('/'),
            onPublishAnother: () => context.read<PublishBloc>().add(const PublishEvent.publishAnother()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Publicar juego'),
            leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.go('/')),
          ),
          body: Column(
            children: [
              // Progress indicator
              StepIndicator(currentStep: state.currentStep, steps: const ['Datos', 'Fotos', 'Precio', 'Revisión']),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: IndexedStack(
                    index: state.currentStep,
                    children: [
                      DataStep(
                        formVersion: state.formVersion,
                        title: state.title,
                        publisher: state.publisher,
                        category: state.category,
                        description: state.description,
                        duration: state.duration,
                        players: state.players,
                        difficulty: state.difficulty,
                        categories: _categories,
                        difficulties: _difficulties,
                        onTitleChanged: (v) => context.read<PublishBloc>().add(PublishEvent.titleChanged(v)),
                        onPublisherChanged: (v) => context.read<PublishBloc>().add(PublishEvent.publisherChanged(v)),
                        onCategoryChanged: (v) => context.read<PublishBloc>().add(PublishEvent.categoryChanged(v)),
                        onDescriptionChanged: (v) =>
                            context.read<PublishBloc>().add(PublishEvent.descriptionChanged(v)),
                        onDurationChanged: (v) => context.read<PublishBloc>().add(PublishEvent.durationChanged(v)),
                        onPlayersChanged: (v) => context.read<PublishBloc>().add(PublishEvent.playersChanged(v)),
                        onDifficultyChanged: (v) => context.read<PublishBloc>().add(PublishEvent.difficultyChanged(v)),
                      ),
                      PhotosStep(
                        images: state.images,
                        onImagesChanged: (v) => context.read<PublishBloc>().add(PublishEvent.imagesChanged(v)),
                      ),
                      PriceStep(
                        formVersion: state.formVersion,
                        pricePerDay: state.pricePerDay,
                        deposit: state.deposit,
                        condition: state.condition,
                        visibility: state.visibility,
                        conditions: _conditions,
                        onPriceChanged: (v) => context.read<PublishBloc>().add(PublishEvent.pricePerDayChanged(v)),
                        onDepositChanged: (v) => context.read<PublishBloc>().add(PublishEvent.depositChanged(v)),
                        onConditionChanged: (v) => context.read<PublishBloc>().add(PublishEvent.conditionChanged(v)),
                        onVisibilityChanged: (v) => context.read<PublishBloc>().add(PublishEvent.visibilityChanged(v)),
                      ),
                      ReviewStep(
                        title: state.title,
                        publisher: state.publisher,
                        category: state.category,
                        description: state.description,
                        duration: state.duration,
                        players: state.players,
                        difficulty: state.difficulty,
                        pricePerDay: state.pricePerDay,
                        deposit: state.deposit,
                        condition: state.condition,
                        visibility: state.visibility,
                        images: state.images,
                        conditions: _conditions,
                      ),
                    ],
                  ),
                ),
              ),

              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.errorMessage!,
                    style: AppTypography.bodySmall.copyWith(color: AppColors.destructive, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Navigation buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  border: Border(top: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.1))),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      if (state.currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: state.isSubmitting
                                ? null
                                : () => context.read<PublishBloc>().add(const PublishEvent.previousStep()),
                            child: const Text('Anterior'),
                          ),
                        ),
                      if (state.currentStep > 0) const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: (!state.canProceed || state.isSubmitting)
                              ? null
                              : () => context.read<PublishBloc>().add(const PublishEvent.nextStep()),
                          child: state.isSubmitting
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Text(state.currentStep == 3 ? 'Publicar' : 'Siguiente'),
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
  }
}
