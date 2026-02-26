import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/routing/navigation.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/blocs/publication_details/game_rules_bloc.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/info_chip.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/page_app_bar.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/feedback_messenger.dart';

/// Game rules page matching GameRules.tsx
class GameRulesPage extends StatefulWidget {
  /// Creates a [GameRulesPage] for the provided game id.
  const GameRulesPage({required this.gameId, super.key});

  /// Game id used to load the rules.
  final String gameId;

  @override
  State<GameRulesPage> createState() => _GameRulesPageState();
}

class _GameRulesPageState extends State<GameRulesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameRulesBloc, GameRulesState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppColors.gameRust),
            ),
          );
        }

        final game = state.game;
        if (game == null) {
          final publicationPath = publicationDetailsPath(widget.gameId);
          return Scaffold(
            appBar: PageAppBar(
              title: const Text('Reglas'),
              onLeadingPressed: () => context.popOrGo(publicationPath),
            ),
            body: Center(
              child: Text(state.errorMessage ?? 'Juego no encontrado'),
            ),
          );
        }

        final publicationPath = publicationDetailsPath(widget.gameId);
        return Scaffold(
          appBar: PageAppBar(
            title: Text('Reglas de ${game.title}'),
            onLeadingPressed: () => context.popOrGo(publicationPath),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Game details summary
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.gameCream.withOpacityValue(0.5),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InfoChip(
                        icon: Icons.timer,
                        label: '${game.duration} min',
                        layout: InfoChipLayout.column,
                        textStyle: AppTypography.labelMedium,
                      ),
                      InfoChip(
                        icon: Icons.people,
                        label: game.players,
                        layout: InfoChipLayout.column,
                        textStyle: AppTypography.labelMedium,
                      ),
                      InfoChip(
                        icon: Icons.psychology,
                        label: game.difficulty,
                        layout: InfoChipLayout.column,
                        textStyle: AppTypography.labelMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Video section
                Text('VIDEO TUTORIAL', style: AppTypography.sectionHeader),
                const SizedBox(height: 12),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.gameBrown.withOpacityValue(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_outline,
                          size: 48,
                          color: AppColors.gameBrown.withOpacityValue(0.5),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Video tutorial de YouTube',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.gameBrown.withOpacityValue(0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        if ((game.rules?.videoUrl ?? '').isEmpty)
                          Text(
                            '(próximamente)',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gameBrown.withOpacityValue(0.5),
                            ),
                          )
                        else
                          Text(
                            game.rules?.videoUrl ?? '',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gameBrown.withOpacityValue(0.5),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Rules text
                Text('RESUMEN DE REGLAS', style: AppTypography.sectionHeader),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(
                      color: AppColors.gameBrown.withOpacityValue(0.1),
                    ),
                  ),
                  child: Text(
                    game.rules?.summaryRules ?? '',
                    style: AppTypography.bodyLarge,
                  ),
                ),

                const SizedBox(height: 24),

                // Cheat sheet
                Text('CHEAT SHEET', style: AppTypography.sectionHeader),
                const SizedBox(height: 12),
                _CheatSheetSection(
                  title: 'Cómo se gana',
                  content: _generateCheatSheetContent(game.title, 'win'),
                ),
                _CheatSheetSection(
                  title: 'Lo básico',
                  content: _generateCheatSheetContent(game.title, 'basics'),
                ),
                _CheatSheetSection(
                  title: 'Avanzado',
                  content: _generateCheatSheetContent(game.title, 'advanced'),
                ),

                const SizedBox(height: 24),

                // PDF download
                OutlinedButton.icon(
                  onPressed: () => FeedbackMessenger.showInfo(
                    context,
                    message: 'Descarga de PDF próximamente',
                  ),
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Descargar manual completo (PDF)'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  String _generateCheatSheetContent(String title, String section) {
    // Generate dynamic content based on game
    switch (section) {
      case 'win':
        return 'El objetivo principal del juego es acumular la mayor cantidad de puntos siguiendo las reglas específicas de $title.';
      case 'basics':
        return 'En tu turno, podés realizar una acción principal y opcionalmente una secundaria. Las acciones disponibles dependen del estado del juego.';
      case 'advanced':
        return 'Los jugadores experimentados pueden optimizar sus turnos combinando acciones estratégicamente para maximizar la eficiencia.';
      default:
        return '';
    }
  }
}

class _CheatSheetSection extends StatelessWidget {
  const _CheatSheetSection({required this.title, required this.content});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppColors.gameGold.withOpacityValue(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb, color: AppColors.gameGold, size: 20),
              const SizedBox(width: 8),
              Text(title, style: AppTypography.titleSmall),
            ],
          ),
          const SizedBox(height: 8),
          Text(content, style: AppTypography.bodyMedium),
        ],
      ),
    );
  }
}
