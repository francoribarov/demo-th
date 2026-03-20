import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/presentation/blocs/create_game/create_game_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/create_game/steps/game_details_step.dart';
import 'package:mobile_table_hopping/presentation/pages/create_game/steps/game_info_step.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/wizard_scaffold.dart';

/// Page for creating a new game in the catalog.
///
/// Uses the same wizard scaffold as the publish flow for consistency.
/// Returns the created [Game] via Navigator.pop when successful.
class CreateGamePage extends StatelessWidget {
  const CreateGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateGameBloc, CreateGameState>(
      listenWhen: (prev, curr) =>
          prev.createdGame == null && curr.createdGame != null,
      listener: (context, state) {
        if (state.createdGame != null) {
          Navigator.of(context).pop(state.createdGame);
        }
      },
      builder: (context, state) {
        return WizardScaffold(
          title: 'Crear juego',
          onLeadingPressed: () => Navigator.of(context).pop(),
          currentStep: state.currentStep,
          steps: const ['Información', 'Detalles'],
          body: IndexedStack(
            index: state.currentStep,
            children: [
              GameInfoStep(
                title: state.title,
                description: state.description,
                titleError: state.titleError,
                descriptionError: state.descriptionError,
                onTitleChanged: (v) => context
                    .read<CreateGameBloc>()
                    .add(CreateGameEvent.titleChanged(v)),
                onDescriptionChanged: (v) => context
                    .read<CreateGameBloc>()
                    .add(CreateGameEvent.descriptionChanged(v)),
              ),
              GameDetailsStep(
                duration: state.duration,
                players: state.players,
                difficulty: state.difficulty,
                durationError: state.durationError,
                playersError: state.playersError,
                onDurationChanged: (v) => context
                    .read<CreateGameBloc>()
                    .add(CreateGameEvent.durationChanged(v)),
                onPlayersChanged: (v) => context
                    .read<CreateGameBloc>()
                    .add(CreateGameEvent.playersChanged(v)),
                onDifficultyChanged: (v) => context
                    .read<CreateGameBloc>()
                    .add(CreateGameEvent.difficultyChanged(v)),
              ),
            ],
          ),
          inlineErrorMessage: state.errorMessage,
          primaryLabel: state.currentStep == CreateGameBloc.maxStep
              ? 'Crear juego'
              : 'Siguiente',
          onPrimaryPressed:
              (!state.isStepValid || state.isSubmitting)
                  ? null
                  : () {
                      if (state.currentStep == CreateGameBloc.maxStep) {
                        context
                            .read<CreateGameBloc>()
                            .add(const CreateGameEvent.submit());
                      } else {
                        context
                            .read<CreateGameBloc>()
                            .add(const CreateGameEvent.nextStep());
                      }
                    },
          secondaryLabel:
              state.currentStep > 0 ? 'Anterior' : null,
          onSecondaryPressed: state.currentStep > 0
              ? () => context
                  .read<CreateGameBloc>()
                  .add(const CreateGameEvent.previousStep())
              : null,
          isSubmitting: state.isSubmitting,
        );
      },
    );
  }
}
