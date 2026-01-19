// UI widgets are documented at a higher level; omit per-member docs.
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';

/// Search header widget matching the Vite.js Layout search pill
class SearchHeader extends StatelessWidget {
  const SearchHeader({
    required this.onTap,
    this.query,
    this.startDate,
    this.endDate,
    this.selectedCategory,
    super.key,
  });

  final String? query;
  final String? startDate;
  final String? endDate;
  final String? selectedCategory;
  final VoidCallback onTap;

  String get _dateLabel {
    if (startDate != null && endDate != null) {
      return DateFormatter.formatRange(startDate!, endDate!);
    }
    return 'Fechas flexibles';
  }

  String get _querySummary {
    if (selectedCategory != null) return selectedCategory!;
    if (query != null && query!.trim().isNotEmpty) return '"$query"';
    return '';
  }

  String get _pillSecondaryText {
    final parts = <String>[];
    if (_querySummary.isNotEmpty) parts.add(_querySummary);
    parts.add(_dateLabel);
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.card,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Row(
        children: [
          // Logo
          CachedNetworkImage(
            imageUrl:
                'https://images.vexels.com/media/users/3/189702/isolated/preview/0909c4a72562b45eb247012f1606c4c6-icono-de-juguete-de-dados.png',
            height: 40,
            width: 40,
            placeholder: (context, url) => Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.gameRust,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.casino, color: Colors.white, size: 24),
            ),
            errorWidget: (context, url, error) => Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.gameRust,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.casino, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 12),

          // Search pill
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(AppTheme.radius3xl),
                  border: Border.all(
                    color: AppColors.gameBrown.withOpacityValue(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacityValue(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Buscá un juego de mesa',
                            style: AppTypography.labelLarge,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _pillSecondaryText,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gameBrown.withOpacityValue(0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppColors.gameRust,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
    final start = state.startDate;
    final end = state.endDate;

    final hasStart = start != null && start.isNotEmpty;
    final hasEnd = end != null && end.isNotEmpty;

    if ((hasStart && !hasEnd) || (!hasStart && hasEnd)) {
      emit(
        state.copyWith(
          dateError: 'Ingresá una fecha de inicio y de fin para continuar.',
        ),
      );
      return false;
    }

    if (hasStart && hasEnd) {
      final parsedStart = DateTime.tryParse(start);
      final parsedEnd = DateTime.tryParse(end);
      if (parsedStart != null &&
          parsedEnd != null &&
          !parsedEnd.isAfter(parsedStart)) {
        emit(
          state.copyWith(
            dateError:
                'La fecha de fin tiene que ser posterior a la de inicio.',
          ),
        );
        return false;
      }
    }

    emit(state.copyWith(dateError: null));
    return true;
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
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radius3xl),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'BUSCÁ JUEGOS',
                            style: AppTypography.sectionHeader.copyWith(
                              color: AppColors.gameBrown.withOpacityValue(0.6),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                            color: AppColors.gameBrown,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Search input
                      TextField(
                        controller: _queryController,
                        decoration: const InputDecoration(
                          hintText: 'Buscá por nombre, categoría o mecánica',
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.gameBrown,
                          ),
                        ),
                        textInputAction: TextInputAction.search,
                        onChanged: (v) =>
                            context.read<_SearchSheetCubit>().queryChanged(v),
                        onSubmitted: (_) => _handleSearch(),
                      ),

                      const SizedBox(height: 16),

                      // Quick suggestions
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _SuggestionChip(
                            label: 'Cooperativos para 4 jugadores',
                            onTap: () {
                              _queryController.text = 'Cooperativo';
                              context.read<_SearchSheetCubit>().queryChanged(
                                'Cooperativo',
                              );
                              _handleSearch();
                            },
                          ),
                          _SuggestionChip(
                            label: 'Para jugar en familia',
                            onTap: () {
                              _queryController.text = 'Familiar';
                              context.read<_SearchSheetCubit>().queryChanged(
                                'Familiar',
                              );
                              _handleSearch();
                            },
                          ),
                          _SuggestionChip(
                            label: 'Juegos de fiesta',
                            onTap: () {
                              _queryController.text = 'Fiesta';
                              context.read<_SearchSheetCubit>().queryChanged(
                                'Fiesta',
                              );
                              _handleSearch();
                            },
                          ),
                          _SuggestionChip(
                            label: 'Desafíos expertos',
                            onTap: () {
                              _queryController.text = 'Experto';
                              context.read<_SearchSheetCubit>().queryChanged(
                                'Experto',
                              );
                              _handleSearch();
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Dates section
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
                                formState.startDate != null &&
                                        formState.endDate != null
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
                                  color: AppColors.gameBrown.withOpacityValue(
                                    0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Date inputs
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.gameCream,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusLg,
                          ),
                          border: Border.all(
                            color: AppColors.gameBrown.withOpacityValue(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _DateInput(
                                    label: 'Fecha de inicio',
                                    value: formState.startDate,
                                    onTap: () => _selectDate(isStart: true),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _DateInput(
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
                                      color: AppColors.gameBrown
                                          .withOpacityValue(0.7),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => context
                                      .read<_SearchSheetCubit>()
                                      .clearDates(),
                                  child: Text(
                                    'Reiniciá las fechas',
                                    style: AppTypography.labelSmall.copyWith(
                                      color: AppColors.gameRust,
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.dotted,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (formState.dateError != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                formState.dateError!,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.destructive,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Surprise button
                      if (widget.onSurprise != null)
                        OutlinedButton.icon(
                          onPressed: _handleSurprise,
                          icon: const Icon(Icons.casino),
                          label: const Text('Sorprendeme'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.gameRust,
                            side: BorderSide(
                              color: AppColors.gameRust.withOpacityValue(0.3),
                            ),
                            minimumSize: const Size(double.infinity, 48),
                          ),
                        ),

                      const SizedBox(height: 32),

                      // Footer buttons
                      Row(
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
                          ElevatedButton.icon(
                            onPressed: _handleSearch,
                            icon: const Icon(Icons.search),
                            label: const Text('Buscá'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.gameRust,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  const _SuggestionChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.gameCream,
          borderRadius: BorderRadius.circular(AppTheme.radius2xl),
          border: Border.all(color: Colors.amber[200]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, size: 14, color: Colors.amber[600]),
            const SizedBox(width: 6),
            Text(label, style: AppTypography.labelSmall),
          ],
        ),
      ),
    );
  }
}

class _DateInput extends StatelessWidget {
  const _DateInput({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.labelMedium),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(
                color: AppColors.gameBrown.withOpacityValue(0.2),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? 'Seleccionar',
                    style: AppTypography.bodyMedium.copyWith(
                      color: value != null
                          ? AppColors.gameBrown
                          : AppColors.gameBrown.withOpacityValue(0.5),
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.gameBrown.withOpacityValue(0.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
