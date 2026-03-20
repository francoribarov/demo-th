import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/presentation/blocs/create_game/create_game_bloc.dart';
import 'package:mobile_table_hopping/presentation/blocs/publish/image_upload_bloc.dart';
import 'package:mobile_table_hopping/presentation/pages/create_game/create_game_intro.dart';
import 'package:mobile_table_hopping/presentation/pages/create_game/steps/game_details_step.dart';
import 'package:mobile_table_hopping/presentation/pages/create_game/steps/game_info_step.dart';
import 'package:mobile_table_hopping/presentation/pages/create_game/steps/game_rules_step.dart';
import 'package:mobile_table_hopping/presentation/widgets/create_game/create_game_bottom_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/create_game/create_game_progress_bar.dart';

/// Full-screen page for creating a new game in the catalog.
///
/// Flow: Intro → Step wizard (3 steps) → returns created [Game].
///
/// UI pattern follows the checkout flow from feature/370:
/// - No bottom navigation bar (full-screen route)
/// - AppBar with back button + step title
/// - Linear progress bar below app bar
/// - PageView for steps with bottom action bar
class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final _pageController = PageController();
  bool _showIntro = true;
  bool _isAnimating = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startWizard() {
    setState(() => _showIntro = false);
  }

  void _animateToStep(int step) {
    if (_isAnimating) return;
    _isAnimating = true;
    unawaited(
      _pageController
          .animateToPage(
            step,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )
          .whenComplete(() {
            if (mounted) _isAnimating = false;
          }),
    );
  }

  void _tryNext(CreateGameState state) {
    if (_isAnimating) return;
    if (!state.isStepValid) return;
    context.read<CreateGameBloc>().add(const CreateGameEvent.nextStep());
    _animateToStep(state.currentStep + 1);
  }

  void _back(int currentStep) {
    if (currentStep > 0) {
      context.read<CreateGameBloc>().add(const CreateGameEvent.previousStep());
      _animateToStep(currentStep - 1);
    } else {
      setState(() => _showIntro = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showIntro) {
      return CreateGameIntro(
        onStart: _startWizard,
        onCancel: () => Navigator.of(context).pop(),
      );
    }

    return BlocConsumer<CreateGameBloc, CreateGameState>(
      listenWhen: (prev, curr) =>
          prev.createdGame == null && curr.createdGame != null,
      listener: (context, state) {
        if (state.createdGame != null) {
          Navigator.of(context).pop(state.createdGame);
        }
      },
      builder: (context, state) {
        return BlocBuilder<ImageUploadBloc, ImageUploadState>(
          builder: (context, imageState) {
            return PopScope(
              canPop: state.currentStep == 0 && _showIntro,
              onPopInvokedWithResult: (didPop, _) {
                if (!didPop) {
                  _back(state.currentStep);
                }
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => _back(state.currentStep),
                  ),
                  title: Text(
                    CreateGameBloc.stepLabels[state.currentStep],
                  ),
                ),
                body: Column(
                  children: [
                    CreateGameProgressBar(
                      currentStep: state.currentStep,
                      totalSteps: CreateGameBloc.totalSteps,
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          GameInfoStep(
                            title: state.title,
                            description: state.description,
                            images: imageState.images,
                            isUploadingImages: imageState.isUploading,
                            titleError: state.titleError,
                            descriptionError: state.descriptionError,
                            onTitleChanged: (v) => context
                                .read<CreateGameBloc>()
                                .add(CreateGameEvent.titleChanged(v)),
                            onDescriptionChanged: (v) => context
                                .read<CreateGameBloc>()
                                .add(CreateGameEvent.descriptionChanged(v)),
                            onAddImages: () => context
                                .read<ImageUploadBloc>()
                                .add(
                                  const ImageUploadEvent.pickAndUpload(),
                                ),
                            onRemoveImage: (index) => context
                                .read<ImageUploadBloc>()
                                .add(ImageUploadEvent.imageRemoved(index)),
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
                          GameRulesStep(
                            rulesUrl: state.rulesUrl,
                            isUploading: state.isUploadingPdf,
                            onPickPdf: () {
                              // PDF upload not wired yet — placeholder
                            },
                            onRemovePdf: () => context
                                .read<CreateGameBloc>()
                                .add(
                                  const CreateGameEvent.rulesUrlChanged(''),
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (state.errorMessage != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingLg,
                          vertical: AppTheme.spacingSm,
                        ),
                        color: AppColors.errorSurface,
                        child: Text(
                          state.errorMessage!,
                          style: const TextStyle(
                            color: AppColors.destructive,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    CreateGameBottomBar(
                      currentStep: state.currentStep,
                      totalSteps: CreateGameBloc.totalSteps,
                      canAdvance: state.isStepValid,
                      isSubmitting: state.isSubmitting,
                      onNext: () => _tryNext(state),
                      onSubmit: () => context
                          .read<CreateGameBloc>()
                          .add(
                            CreateGameEvent.submit(
                              images: imageState.images,
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
