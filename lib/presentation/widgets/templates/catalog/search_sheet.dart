import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/domain/validators/optional_date_range_validator.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/date_picker_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/search_input_field.dart';
import 'package:mobile_table_hopping/presentation/widgets/templates/common/bottom_sheet_shell.dart';

/// Search sheet for the full search experience
class SearchSheet extends StatefulWidget {
  const SearchSheet({
    required this.onSearch,
    required this.onClear,
    this.initialQuery = '',
    this.initialStartDate,
    this.initialEndDate,
    this.onSurprise,
    super.key,
  });

  final String initialQuery;
  final String? initialStartDate;
  final String? initialEndDate;
  final void Function(String query, String? startDate, String? endDate)
  onSearch;
  final VoidCallback onClear;
  final VoidCallback? onSurprise;

  static Future<void> show({
    required BuildContext context,
    required void Function(String query, String? startDate, String? endDate)
    onSearch,
    required VoidCallback onClear,
    String initialQuery = '',
    String? initialStartDate,
    String? initialEndDate,
    VoidCallback? onSurprise,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider(
        create: (_) => _SearchSheetCubit(
          initialQuery: initialQuery,
          initialStartDate: initialStartDate,
          initialEndDate: initialEndDate,
        ),
        child: SearchSheet(
          initialQuery: initialQuery,
          initialStartDate: initialStartDate,
          initialEndDate: initialEndDate,
          onSearch: onSearch,
          onClear: onClear,
          onSurprise: onSurprise,
        ),
      ),
    );
  }

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

@immutable
class _SearchSheetFormState {
  const _SearchSheetFormState({
    required this.query,
    this.startDate,
    this.endDate,
    this.dateError,
  });

  final String query;
  final String? startDate;
  final String? endDate;
  final String? dateError;

  static const Object _unset = Object();

  _SearchSheetFormState copyWith({
    String? query,
    Object? startDate = _unset,
    Object? endDate = _unset,
    Object? dateError = _unset,
  }) {
    return _SearchSheetFormState(
      query: query ?? this.query,
      startDate: startDate == _unset ? this.startDate : startDate as String?,
      endDate: endDate == _unset ? this.endDate : endDate as String?,
      dateError: dateError == _unset ? this.dateError : dateError as String?,
    );
  }
}

class _SearchSheetCubit extends Cubit<_SearchSheetFormState> {
  _SearchSheetCubit({
    required String initialQuery,
    String? initialStartDate,
    String? initialEndDate,
  }) : super(
         _SearchSheetFormState(
           query: initialQuery,
           startDate: initialStartDate,
           endDate: initialEndDate,
         ),
       );

  void queryChanged(String value) {
    emit(state.copyWith(query: value, dateError: null));
  }

  void clearAll() {
    emit(const _SearchSheetFormState(query: ''));
  }

  void clearDates() {
    emit(state.copyWith(startDate: null, endDate: null, dateError: null));
  }

  void setDate({required bool isStart, required String value}) {
    emit(
      state.copyWith(
        startDate: isStart ? value : state.startDate,
        endDate: isStart ? state.endDate : value,
        dateError: null,
      ),
    );
  }

  bool validateDates() {
    final error = OptionalDateRangeValidator.validate(
      startDate: state.startDate,
      endDate: state.endDate,
    );
    emit(state.copyWith(dateError: error));
    return error == null;
  }
}

class _SearchSheetState extends State<SearchSheet> {
  late TextEditingController _queryController;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final cubit = context.read<_SearchSheetCubit>();
    if (!cubit.validateDates()) return;
    widget.onSearch(
      _queryController.text,
      cubit.state.startDate,
      cubit.state.endDate,
    );
    Navigator.pop(context);
  }

  void _handleClear() {
    _queryController.clear();
    context.read<_SearchSheetCubit>().clearAll();
    widget.onClear();
  }

  void _handleSurprise() {
    if (!context.read<_SearchSheetCubit>().validateDates()) return;
    widget.onSurprise?.call();
    Navigator.pop(context);
  }

  Future<void> _selectDate({required bool isStart}) async {
    final cubit = context.read<_SearchSheetCubit>();
    final now = DateTime.now();
    final initialDate = isStart
        ? (cubit.state.startDate != null
                  ? DateTime.tryParse(cubit.state.startDate!)
                  : now) ??
              now
        : (cubit.state.endDate != null
                  ? DateTime.tryParse(cubit.state.endDate!)
                  : now) ??
              now;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.gameRust,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final dateStr = DateFormatter.toIsoString(picked);
      cubit.setDate(isStart: isStart, value: dateStr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_SearchSheetCubit, _SearchSheetFormState>(
      buildWhen: (previous, current) =>
          previous.startDate != current.startDate ||
          previous.endDate != current.endDate ||
          previous.dateError != current.dateError,
      builder: (context, formState) {
        return BottomSheetShell(
          title: Text(
            'BUSCÁ JUEGOS',
            style: AppTypography.sectionHeader.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          trailing: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            color: AppColors.gameBrown,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchInputField(
                controller: _queryController,
                hintText: 'Buscá por nombre, categoría o mecánica',
                onClear: () {
                  _queryController.clear();
                  context.read<_SearchSheetCubit>().queryChanged('');
                  setState(() {});
                },
                onChanged: (v) =>
                    context.read<_SearchSheetCubit>().queryChanged(v),
                onSubmitted: (_) => _handleSearch(),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  SelectableChip(
                    label: 'Cooperativos para 4 jugadores',
                    isSelected: false,
                    variant: SelectableChipVariant.suggestion,
                    icon: Icons.auto_awesome,
                    onTap: () {
                      _queryController.text = 'Cooperativo';
                      context.read<_SearchSheetCubit>().queryChanged(
                        'Cooperativo',
                      );
                      _handleSearch();
                    },
                  ),
                  SelectableChip(
                    label: 'Para jugar en familia',
                    isSelected: false,
                    variant: SelectableChipVariant.suggestion,
                    icon: Icons.auto_awesome,
                    onTap: () {
                      _queryController.text = 'Familiar';
                      context.read<_SearchSheetCubit>().queryChanged(
                        'Familiar',
                      );
                      _handleSearch();
                    },
                  ),
                  SelectableChip(
                    label: 'Juegos de fiesta',
                    isSelected: false,
                    variant: SelectableChipVariant.suggestion,
                    icon: Icons.auto_awesome,
                    onTap: () {
                      _queryController.text = 'Fiesta';
                      context.read<_SearchSheetCubit>().queryChanged('Fiesta');
                      _handleSearch();
                    },
                  ),
                  SelectableChip(
                    label: 'Desafíos expertos',
                    isSelected: false,
                    variant: SelectableChipVariant.suggestion,
                    icon: Icons.auto_awesome,
                    onTap: () {
                      _queryController.text = 'Experto';
                      context.read<_SearchSheetCubit>().queryChanged('Experto');
                      _handleSearch();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FECHAS',
                        style: AppTypography.sectionHeader.copyWith(
                          color: AppColors.gameBrown.withOpacityValue(
                            0.6,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formState.startDate != null && formState.endDate != null
                            ? DateFormatter.formatRange(
                                formState.startDate!,
                                formState.endDate!,
                              )
                            : 'Agregá fechas cuando quieras',
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 16,
                        color: AppColors.gameBrown,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Agregá tus días',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SurfaceCard(
                variant: SurfaceCardVariant.highlight,
                padding: const EdgeInsets.all(16),
                borderColor: AppColors.gameBrown.withOpacityValue(0.2),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DatePickerField(
                            label: 'Fecha de inicio',
                            value: formState.startDate,
                            onTap: () => _selectDate(isStart: true),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DatePickerField(
                            label: 'Fecha de fin',
                            value: formState.endDate,
                            onTap: () => _selectDate(isStart: false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Agregá un rango para ver solo lo disponible en esos días.',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              context.read<_SearchSheetCubit>().clearDates(),
                          child: Text(
                            'Reiniciá las fechas',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.gameRust,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dotted,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (formState.dateError != null) ...[
                      const SizedBox(height: 8),
                      InlineFeedbackText(
                        message: formState.dateError!,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              if (widget.onSurprise != null)
                AppSecondaryButton(
                  onPressed: _handleSurprise,
                  icon: Icons.casino,
                  label: 'Sorprendeme',
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.gameRust,
                    side: BorderSide(
                      color: AppColors.gameRust.withOpacityValue(0.3),
                    ),
                    minimumSize: const Size(double.infinity, 48),
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
              child: Row(
                children: [
                  TextButton(
                    onPressed: _handleClear,
                    child: Text(
                      'Borrá todo',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.gameBrown,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                      ),
                    ),
                  ),
                  const Spacer(),
                  AppPrimaryButton(
                    onPressed: _handleSearch,
                    icon: Icons.search,
                    label: 'Buscá',
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gameRust,
                      foregroundColor: AppColors.primaryForeground,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
