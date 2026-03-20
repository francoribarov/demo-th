import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/selectable_input_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/text_form_input_field.dart';

/// Difficulty options for game creation.
const _difficulties = ['Fácil', 'Medio', 'Difícil'];

/// Step 2 of the create-game wizard: duration, players, difficulty.
class GameDetailsStep extends StatelessWidget {
  const GameDetailsStep({
    required this.duration,
    required this.players,
    required this.difficulty,
    required this.onDurationChanged,
    required this.onPlayersChanged,
    required this.onDifficultyChanged,
    this.durationError,
    this.playersError,
    super.key,
  });

  final int duration;
  final String players;
  final String difficulty;
  final ValueChanged<int> onDurationChanged;
  final ValueChanged<String> onPlayersChanged;
  final ValueChanged<String> onDifficultyChanged;
  final String? durationError;
  final String? playersError;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Detalles del juego', style: AppTypography.headlineMedium),
        const SizedBox(height: AppTheme.spacingSm),
        Text(
          'Completá la información técnica del juego.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppTheme.spacing2xl),

        TextFormInputField(
          key: ValueKey('create_game_duration_$duration'),
          initialValue: duration > 0 ? duration.toString() : '',
          labelText: 'Duración (minutos) *',
          hintText: 'Ej: 60',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (v) => onDurationChanged(int.tryParse(v) ?? 0),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (_) => durationError,
        ),
        const SizedBox(height: AppTheme.spacingLg),

        TextFormInputField(
          key: ValueKey('create_game_players_$players'),
          initialValue: players,
          labelText: 'Jugadores *',
          hintText: 'Ej: 2-4',
          helperText: 'Formato: "2-4" o un número fijo como "3"',
          onChanged: onPlayersChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (_) => playersError,
        ),
        const SizedBox(height: AppTheme.spacing2xl),

        Text('Dificultad', style: AppTypography.titleMedium),
        const SizedBox(height: AppTheme.spacingMd),
        ...List.generate(
          _difficulties.length,
          (index) {
            final d = _difficulties[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: SelectableInputCard(
                onTap: () => onDifficultyChanged(d),
                isSelected: difficulty == d,
                indicatorMode: SelectableInputIndicatorMode.radio,
                indicatorPosition: SelectableInputIndicatorPosition.leading,
                title: d,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                selectedBackgroundColor:
                    AppColors.gameRust.withOpacityValue(0.1),
                unselectedBorderColor: AppColors.border,
                selectedTextColor: AppColors.gameRust,
                unselectedTextColor: AppColors.foreground,
              ),
            );
          },
        ),
      ],
    );
  }
}
