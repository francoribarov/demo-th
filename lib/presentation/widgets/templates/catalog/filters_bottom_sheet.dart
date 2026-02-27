import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/filters.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/app_primary_button.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/selectable_chip.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/common/surface_card.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/numeric_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/section_header_block.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/bottom_sheet_shell.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({
    required this.initialFilters,
    required this.hasDateFilter,
    required this.getPreviewCount,
    required this.onApply,
    super.key,
  });

  final FiltersState initialFilters;
  final bool hasDateFilter;
  final int Function(FiltersState) getPreviewCount;
  final void Function(FiltersState) onApply;

  static Future<FiltersState?> show({
    required BuildContext context,
    required FiltersState initialFilters,
    required bool hasDateFilter,
    required int Function(FiltersState) getPreviewCount,
  }) {
    return showModalBottomSheet<FiltersState>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FiltersBottomSheet(
        initialFilters: initialFilters,
        hasDateFilter: hasDateFilter,
        getPreviewCount: getPreviewCount,
        onApply: (filters) => Navigator.pop(context, filters),
      ),
    );
  }

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

@immutable
class _FiltersSheetState {
  const _FiltersSheetState({required this.filters, required this.version});

  final FiltersState filters;
  final int version;

  _FiltersSheetState copyWith({FiltersState? filters, int? version}) {
    return _FiltersSheetState(
      filters: filters ?? this.filters,
      version: version ?? this.version,
    );
  }
}

class _FiltersSheetCubit extends Cubit<_FiltersSheetState> {
  _FiltersSheetCubit(FiltersState initialFilters) : super(_FiltersSheetState(filters: initialFilters, version: 0));

  void updateFilters(FiltersState Function(FiltersState) update) {
    emit(state.copyWith(filters: update(state.filters)));
  }

  void clearAll() {
    emit(
      state.copyWith(filters: const FiltersState(), version: state.version + 1),
    );
  }
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  late final _FiltersSheetCubit _cubit;

  FiltersState get _filters => _cubit.state.filters;
  int get _version => _cubit.state.version;

  @override
  void initState() {
    super.initState();
    _cubit = _FiltersSheetCubit(widget.initialFilters);
  }

  @override
  void dispose() {
    unawaited(_cubit.close());
    super.dispose();
  }

  void _updateFilters(FiltersState Function(FiltersState) update) {
    _cubit.updateFilters(update);
  }

  void _clearAll() {
    _cubit.clearAll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<_FiltersSheetCubit>.value(
      value: _cubit,
      child: BlocBuilder<_FiltersSheetCubit, _FiltersSheetState>(
        builder: (context, sheetState) {
          final previewCount = widget.getPreviewCount(sheetState.filters);

          return BottomSheetShell(
            title: Text('Filtros', style: AppTypography.titleMedium),
            leading: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cerrar',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.gameBrown,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
              ),
            ),
            trailing: TextButton(
              onPressed: _clearAll,
              child: Text(
                'Borrá todo',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.gameRust,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Players section
                const SectionHeaderBlock(title: 'Jugadores'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: PlayersRangeOption.values.map((option) {
                    return SelectableChip(
                      label: option.label,
                      isSelected: _filters.playersRange == option,
                      onTap: () => _updateFilters(
                        (f) => f.copyWith(playersRange: option),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Duration section
                const SectionHeaderBlock(title: 'Duración'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: DurationRangeOption.values.map((option) {
                    return SelectableChip(
                      label: option.label,
                      isSelected: _filters.durationRange == option,
                      onTap: () => _updateFilters(
                        (f) => f.copyWith(durationRange: option),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Price section
                const SectionHeaderBlock(
                  title: 'Precio por día',
                  subtitle: 'Filtrá por precio de alquiler por día.',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _PriceInputField(
                        label: 'Mínimo (UYU)',
                        value: _filters.priceMin,
                        version: _version,
                        onChanged: (value) => _updateFilters((f) => f.copyWith(priceMin: value)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _PriceInputField(
                        label: 'Máximo (UYU)',
                        value: _filters.priceMax,
                        version: _version,
                        onChanged: (value) => _updateFilters((f) => f.copyWith(priceMax: value)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Difficulty section
                const SectionHeaderBlock(title: 'Dificultad'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: DifficultyOption.values.map((option) {
                    return SelectableChip(
                      label: option.label,
                      isSelected: _filters.difficulty == option,
                      onTap: () => _updateFilters((f) => f.copyWith(difficulty: option)),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Experience types section
                const SectionHeaderBlock(title: 'Tipo de experiencia'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ExperienceTypes.all.map((type) {
                    final isSelected = _filters.experienceTypes.contains(type);
                    return SelectableChip(
                      label: type,
                      isSelected: isSelected,
                      variant: SelectableChipVariant.outline,
                      onTap: () {
                        _updateFilters((f) {
                          final types = List<String>.from(f.experienceTypes);
                          if (isSelected) {
                            types.remove(type);
                          } else {
                            types.add(type);
                          }
                          return f.copyWith(experienceTypes: types);
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Other filters section
                const SectionHeaderBlock(title: 'Otros'),
                const SizedBox(height: 12),
                SurfaceCard(
                  variant: SurfaceCardVariant.subtle,
                  borderColor: AppColors.gameBrown.withOpacityValue(0.1),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Solo disponibles en mis fechas',
                              style: AppTypography.labelLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.hasDateFilter
                                  ? 'Mostramos únicamente los juegos con cupo libre.'
                                  : 'Agregá fechas para activar este filtro.',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.gameBrown.withOpacityValue(
                                  0.7,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _filters.onlyAvailableInDates && widget.hasDateFilter,
                        onChanged: widget.hasDateFilter
                            ? (value) => _updateFilters(
                                (f) => f.copyWith(onlyAvailableInDates: value),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Rating filter
                SurfaceCard(
                  borderColor: AppColors.gameBrown.withOpacityValue(0.1),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Valoración mínima',
                        style: AppTypography.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Mostramos juegos con puntaje igual o superior al seleccionado.',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: RatingOptions.all.map((option) {
                          return SelectableChip(
                            label: option.$2,
                            isSelected: _filters.minRating == option.$1,
                            onTap: () => _updateFilters(
                              (f) => f.copyWith(minRating: option.$1),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            footer: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.card.withOpacityValue(0.9),
                border: Border(
                  top: BorderSide(
                    color: AppColors.gameBrown.withOpacityValue(0.1),
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      previewCount == 1 ? 'Se encontró 1 juego' : 'Se encontraron $previewCount juegos',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    AppPrimaryButton(
                      label: 'Ver resultados',
                      onPressed: () => widget.onApply(_filters),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PriceInputField extends StatelessWidget {
  const _PriceInputField({
    required this.label,
    required this.value,
    required this.version,
    required this.onChanged,
  });

  final String label;
  final int? value;
  final int version;
  final void Function(int?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown),
        ),
        const SizedBox(height: 8),
        NumericInputField(
          key: ValueKey('$label-$version'),
          initialValue: value?.toString() ?? '',
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          onChangedValue: onChanged,
        ),
      ],
    );
  }
}
