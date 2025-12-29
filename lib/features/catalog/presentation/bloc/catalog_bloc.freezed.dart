// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CatalogEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadGames,
    required TResult Function(String? query, String? startDate, String? endDate) search,
    required TResult Function(FiltersState filters) applyFilters,
    required TResult Function(SortOption sortOption) updateSort,
    required TResult Function(String category) selectCategory,
    required TResult Function() clearSearch,
    required TResult Function(String? startDate, String? endDate) setDates,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadGames,
    TResult? Function(String? query, String? startDate, String? endDate)? search,
    TResult? Function(FiltersState filters)? applyFilters,
    TResult? Function(SortOption sortOption)? updateSort,
    TResult? Function(String category)? selectCategory,
    TResult? Function()? clearSearch,
    TResult? Function(String? startDate, String? endDate)? setDates,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadGames,
    TResult Function(String? query, String? startDate, String? endDate)? search,
    TResult Function(FiltersState filters)? applyFilters,
    TResult Function(SortOption sortOption)? updateSort,
    TResult Function(String category)? selectCategory,
    TResult Function()? clearSearch,
    TResult Function(String? startDate, String? endDate)? setDates,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadGames value) loadGames,
    required TResult Function(SearchCatalog value) search,
    required TResult Function(ApplyFilters value) applyFilters,
    required TResult Function(UpdateSort value) updateSort,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(ClearSearch value) clearSearch,
    required TResult Function(SetDates value) setDates,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadGames value)? loadGames,
    TResult? Function(SearchCatalog value)? search,
    TResult? Function(ApplyFilters value)? applyFilters,
    TResult? Function(UpdateSort value)? updateSort,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(ClearSearch value)? clearSearch,
    TResult? Function(SetDates value)? setDates,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadGames value)? loadGames,
    TResult Function(SearchCatalog value)? search,
    TResult Function(ApplyFilters value)? applyFilters,
    TResult Function(UpdateSort value)? updateSort,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(ClearSearch value)? clearSearch,
    TResult Function(SetDates value)? setDates,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogEventCopyWith<$Res> {
  factory $CatalogEventCopyWith(CatalogEvent value, $Res Function(CatalogEvent) then) =
      _$CatalogEventCopyWithImpl<$Res, CatalogEvent>;
}

/// @nodoc
class _$CatalogEventCopyWithImpl<$Res, $Val extends CatalogEvent> implements $CatalogEventCopyWith<$Res> {
  _$CatalogEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadGamesImplCopyWith<$Res> {
  factory _$$LoadGamesImplCopyWith(_$LoadGamesImpl value, $Res Function(_$LoadGamesImpl) then) =
      __$$LoadGamesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadGamesImplCopyWithImpl<$Res> extends _$CatalogEventCopyWithImpl<$Res, _$LoadGamesImpl>
    implements _$$LoadGamesImplCopyWith<$Res> {
  __$$LoadGamesImplCopyWithImpl(_$LoadGamesImpl _value, $Res Function(_$LoadGamesImpl) _then) : super(_value, _then);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadGamesImpl implements LoadGames {
  const _$LoadGamesImpl();

  @override
  String toString() {
    return 'CatalogEvent.loadGames()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$LoadGamesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadGames,
    required TResult Function(String? query, String? startDate, String? endDate) search,
    required TResult Function(FiltersState filters) applyFilters,
    required TResult Function(SortOption sortOption) updateSort,
    required TResult Function(String category) selectCategory,
    required TResult Function() clearSearch,
    required TResult Function(String? startDate, String? endDate) setDates,
  }) {
    return loadGames();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadGames,
    TResult? Function(String? query, String? startDate, String? endDate)? search,
    TResult? Function(FiltersState filters)? applyFilters,
    TResult? Function(SortOption sortOption)? updateSort,
    TResult? Function(String category)? selectCategory,
    TResult? Function()? clearSearch,
    TResult? Function(String? startDate, String? endDate)? setDates,
  }) {
    return loadGames?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadGames,
    TResult Function(String? query, String? startDate, String? endDate)? search,
    TResult Function(FiltersState filters)? applyFilters,
    TResult Function(SortOption sortOption)? updateSort,
    TResult Function(String category)? selectCategory,
    TResult Function()? clearSearch,
    TResult Function(String? startDate, String? endDate)? setDates,
    required TResult orElse(),
  }) {
    if (loadGames != null) {
      return loadGames();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadGames value) loadGames,
    required TResult Function(SearchCatalog value) search,
    required TResult Function(ApplyFilters value) applyFilters,
    required TResult Function(UpdateSort value) updateSort,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(ClearSearch value) clearSearch,
    required TResult Function(SetDates value) setDates,
  }) {
    return loadGames(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadGames value)? loadGames,
    TResult? Function(SearchCatalog value)? search,
    TResult? Function(ApplyFilters value)? applyFilters,
    TResult? Function(UpdateSort value)? updateSort,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(ClearSearch value)? clearSearch,
    TResult? Function(SetDates value)? setDates,
  }) {
    return loadGames?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadGames value)? loadGames,
    TResult Function(SearchCatalog value)? search,
    TResult Function(ApplyFilters value)? applyFilters,
    TResult Function(UpdateSort value)? updateSort,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(ClearSearch value)? clearSearch,
    TResult Function(SetDates value)? setDates,
    required TResult orElse(),
  }) {
    if (loadGames != null) {
      return loadGames(this);
    }
    return orElse();
  }
}

abstract class LoadGames implements CatalogEvent {
  const factory LoadGames() = _$LoadGamesImpl;
}

/// @nodoc
abstract class _$$SearchCatalogImplCopyWith<$Res> {
  factory _$$SearchCatalogImplCopyWith(_$SearchCatalogImpl value, $Res Function(_$SearchCatalogImpl) then) =
      __$$SearchCatalogImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? query, String? startDate, String? endDate});
}

/// @nodoc
class __$$SearchCatalogImplCopyWithImpl<$Res> extends _$CatalogEventCopyWithImpl<$Res, _$SearchCatalogImpl>
    implements _$$SearchCatalogImplCopyWith<$Res> {
  __$$SearchCatalogImplCopyWithImpl(_$SearchCatalogImpl _value, $Res Function(_$SearchCatalogImpl) _then)
    : super(_value, _then);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = freezed, Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _$SearchCatalogImpl(
        query: freezed == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SearchCatalogImpl implements SearchCatalog {
  const _$SearchCatalogImpl({this.query, this.startDate, this.endDate});

  @override
  final String? query;
  @override
  final String? startDate;
  @override
  final String? endDate;

  @override
  String toString() {
    return 'CatalogEvent.search(query: $query, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchCatalogImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.startDate, startDate) || other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query, startDate, endDate);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchCatalogImplCopyWith<_$SearchCatalogImpl> get copyWith =>
      __$$SearchCatalogImplCopyWithImpl<_$SearchCatalogImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadGames,
    required TResult Function(String? query, String? startDate, String? endDate) search,
    required TResult Function(FiltersState filters) applyFilters,
    required TResult Function(SortOption sortOption) updateSort,
    required TResult Function(String category) selectCategory,
    required TResult Function() clearSearch,
    required TResult Function(String? startDate, String? endDate) setDates,
  }) {
    return search(query, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadGames,
    TResult? Function(String? query, String? startDate, String? endDate)? search,
    TResult? Function(FiltersState filters)? applyFilters,
    TResult? Function(SortOption sortOption)? updateSort,
    TResult? Function(String category)? selectCategory,
    TResult? Function()? clearSearch,
    TResult? Function(String? startDate, String? endDate)? setDates,
  }) {
    return search?.call(query, startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadGames,
    TResult Function(String? query, String? startDate, String? endDate)? search,
    TResult Function(FiltersState filters)? applyFilters,
    TResult Function(SortOption sortOption)? updateSort,
    TResult Function(String category)? selectCategory,
    TResult Function()? clearSearch,
    TResult Function(String? startDate, String? endDate)? setDates,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(query, startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadGames value) loadGames,
    required TResult Function(SearchCatalog value) search,
    required TResult Function(ApplyFilters value) applyFilters,
    required TResult Function(UpdateSort value) updateSort,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(ClearSearch value) clearSearch,
    required TResult Function(SetDates value) setDates,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadGames value)? loadGames,
    TResult? Function(SearchCatalog value)? search,
    TResult? Function(ApplyFilters value)? applyFilters,
    TResult? Function(UpdateSort value)? updateSort,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(ClearSearch value)? clearSearch,
    TResult? Function(SetDates value)? setDates,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadGames value)? loadGames,
    TResult Function(SearchCatalog value)? search,
    TResult Function(ApplyFilters value)? applyFilters,
    TResult Function(UpdateSort value)? updateSort,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(ClearSearch value)? clearSearch,
    TResult Function(SetDates value)? setDates,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class SearchCatalog implements CatalogEvent {
  const factory SearchCatalog({final String? query, final String? startDate, final String? endDate}) =
      _$SearchCatalogImpl;

  String? get query;
  String? get startDate;
  String? get endDate;

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchCatalogImplCopyWith<_$SearchCatalogImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApplyFiltersImplCopyWith<$Res> {
  factory _$$ApplyFiltersImplCopyWith(_$ApplyFiltersImpl value, $Res Function(_$ApplyFiltersImpl) then) =
      __$$ApplyFiltersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({FiltersState filters});

  $FiltersStateCopyWith<$Res> get filters;
}

/// @nodoc
class __$$ApplyFiltersImplCopyWithImpl<$Res> extends _$CatalogEventCopyWithImpl<$Res, _$ApplyFiltersImpl>
    implements _$$ApplyFiltersImplCopyWith<$Res> {
  __$$ApplyFiltersImplCopyWithImpl(_$ApplyFiltersImpl _value, $Res Function(_$ApplyFiltersImpl) _then)
    : super(_value, _then);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? filters = null}) {
    return _then(
      _$ApplyFiltersImpl(
        null == filters
            ? _value.filters
            : filters // ignore: cast_nullable_to_non_nullable
                  as FiltersState,
      ),
    );
  }

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FiltersStateCopyWith<$Res> get filters {
    return $FiltersStateCopyWith<$Res>(_value.filters, (value) {
      return _then(_value.copyWith(filters: value));
    });
  }
}

/// @nodoc

class _$ApplyFiltersImpl implements ApplyFilters {
  const _$ApplyFiltersImpl(this.filters);

  @override
  final FiltersState filters;

  @override
  String toString() {
    return 'CatalogEvent.applyFilters(filters: $filters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplyFiltersImpl &&
            (identical(other.filters, filters) || other.filters == filters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filters);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplyFiltersImplCopyWith<_$ApplyFiltersImpl> get copyWith =>
      __$$ApplyFiltersImplCopyWithImpl<_$ApplyFiltersImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadGames,
    required TResult Function(String? query, String? startDate, String? endDate) search,
    required TResult Function(FiltersState filters) applyFilters,
    required TResult Function(SortOption sortOption) updateSort,
    required TResult Function(String category) selectCategory,
    required TResult Function() clearSearch,
    required TResult Function(String? startDate, String? endDate) setDates,
  }) {
    return applyFilters(filters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadGames,
    TResult? Function(String? query, String? startDate, String? endDate)? search,
    TResult? Function(FiltersState filters)? applyFilters,
    TResult? Function(SortOption sortOption)? updateSort,
    TResult? Function(String category)? selectCategory,
    TResult? Function()? clearSearch,
    TResult? Function(String? startDate, String? endDate)? setDates,
  }) {
    return applyFilters?.call(filters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadGames,
    TResult Function(String? query, String? startDate, String? endDate)? search,
    TResult Function(FiltersState filters)? applyFilters,
    TResult Function(SortOption sortOption)? updateSort,
    TResult Function(String category)? selectCategory,
    TResult Function()? clearSearch,
    TResult Function(String? startDate, String? endDate)? setDates,
    required TResult orElse(),
  }) {
    if (applyFilters != null) {
      return applyFilters(filters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadGames value) loadGames,
    required TResult Function(SearchCatalog value) search,
    required TResult Function(ApplyFilters value) applyFilters,
    required TResult Function(UpdateSort value) updateSort,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(ClearSearch value) clearSearch,
    required TResult Function(SetDates value) setDates,
  }) {
    return applyFilters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadGames value)? loadGames,
    TResult? Function(SearchCatalog value)? search,
    TResult? Function(ApplyFilters value)? applyFilters,
    TResult? Function(UpdateSort value)? updateSort,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(ClearSearch value)? clearSearch,
    TResult? Function(SetDates value)? setDates,
  }) {
    return applyFilters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadGames value)? loadGames,
    TResult Function(SearchCatalog value)? search,
    TResult Function(ApplyFilters value)? applyFilters,
    TResult Function(UpdateSort value)? updateSort,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(ClearSearch value)? clearSearch,
    TResult Function(SetDates value)? setDates,
    required TResult orElse(),
  }) {
    if (applyFilters != null) {
      return applyFilters(this);
    }
    return orElse();
  }
}

abstract class ApplyFilters implements CatalogEvent {
  const factory ApplyFilters(final FiltersState filters) = _$ApplyFiltersImpl;

  FiltersState get filters;

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplyFiltersImplCopyWith<_$ApplyFiltersImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateSortImplCopyWith<$Res> {
  factory _$$UpdateSortImplCopyWith(_$UpdateSortImpl value, $Res Function(_$UpdateSortImpl) then) =
      __$$UpdateSortImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SortOption sortOption});
}

/// @nodoc
class __$$UpdateSortImplCopyWithImpl<$Res> extends _$CatalogEventCopyWithImpl<$Res, _$UpdateSortImpl>
    implements _$$UpdateSortImplCopyWith<$Res> {
  __$$UpdateSortImplCopyWithImpl(_$UpdateSortImpl _value, $Res Function(_$UpdateSortImpl) _then) : super(_value, _then);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sortOption = null}) {
    return _then(
      _$UpdateSortImpl(
        null == sortOption
            ? _value.sortOption
            : sortOption // ignore: cast_nullable_to_non_nullable
                  as SortOption,
      ),
    );
  }
}

/// @nodoc

class _$UpdateSortImpl implements UpdateSort {
  const _$UpdateSortImpl(this.sortOption);

  @override
  final SortOption sortOption;

  @override
  String toString() {
    return 'CatalogEvent.updateSort(sortOption: $sortOption)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSortImpl &&
            (identical(other.sortOption, sortOption) || other.sortOption == sortOption));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sortOption);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSortImplCopyWith<_$UpdateSortImpl> get copyWith =>
      __$$UpdateSortImplCopyWithImpl<_$UpdateSortImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadGames,
    required TResult Function(String? query, String? startDate, String? endDate) search,
    required TResult Function(FiltersState filters) applyFilters,
    required TResult Function(SortOption sortOption) updateSort,
    required TResult Function(String category) selectCategory,
    required TResult Function() clearSearch,
    required TResult Function(String? startDate, String? endDate) setDates,
  }) {
    return updateSort(sortOption);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadGames,
    TResult? Function(String? query, String? startDate, String? endDate)? search,
    TResult? Function(FiltersState filters)? applyFilters,
    TResult? Function(SortOption sortOption)? updateSort,
    TResult? Function(String category)? selectCategory,
    TResult? Function()? clearSearch,
    TResult? Function(String? startDate, String? endDate)? setDates,
  }) {
    return updateSort?.call(sortOption);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadGames,
    TResult Function(String? query, String? startDate, String? endDate)? search,
    TResult Function(FiltersState filters)? applyFilters,
    TResult Function(SortOption sortOption)? updateSort,
    TResult Function(String category)? selectCategory,
    TResult Function()? clearSearch,
    TResult Function(String? startDate, String? endDate)? setDates,
    required TResult orElse(),
  }) {
    if (updateSort != null) {
      return updateSort(sortOption);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadGames value) loadGames,
    required TResult Function(SearchCatalog value) search,
    required TResult Function(ApplyFilters value) applyFilters,
    required TResult Function(UpdateSort value) updateSort,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(ClearSearch value) clearSearch,
    required TResult Function(SetDates value) setDates,
  }) {
    return updateSort(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadGames value)? loadGames,
    TResult? Function(SearchCatalog value)? search,
    TResult? Function(ApplyFilters value)? applyFilters,
    TResult? Function(UpdateSort value)? updateSort,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(ClearSearch value)? clearSearch,
    TResult? Function(SetDates value)? setDates,
  }) {
    return updateSort?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadGames value)? loadGames,
    TResult Function(SearchCatalog value)? search,
    TResult Function(ApplyFilters value)? applyFilters,
    TResult Function(UpdateSort value)? updateSort,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(ClearSearch value)? clearSearch,
    TResult Function(SetDates value)? setDates,
    required TResult orElse(),
  }) {
    if (updateSort != null) {
      return updateSort(this);
    }
    return orElse();
  }
}

abstract class UpdateSort implements CatalogEvent {
  const factory UpdateSort(final SortOption sortOption) = _$UpdateSortImpl;

  SortOption get sortOption;

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSortImplCopyWith<_$UpdateSortImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SelectCategoryImplCopyWith<$Res> {
  factory _$$SelectCategoryImplCopyWith(_$SelectCategoryImpl value, $Res Function(_$SelectCategoryImpl) then) =
      __$$SelectCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String category});
}

/// @nodoc
class __$$SelectCategoryImplCopyWithImpl<$Res> extends _$CatalogEventCopyWithImpl<$Res, _$SelectCategoryImpl>
    implements _$$SelectCategoryImplCopyWith<$Res> {
  __$$SelectCategoryImplCopyWithImpl(_$SelectCategoryImpl _value, $Res Function(_$SelectCategoryImpl) _then)
    : super(_value, _then);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = null}) {
    return _then(
      _$SelectCategoryImpl(
        null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SelectCategoryImpl implements SelectCategory {
  const _$SelectCategoryImpl(this.category);

  @override
  final String category;

  @override
  String toString() {
    return 'CatalogEvent.selectCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SelectCategoryImpl &&
            (identical(other.category, category) || other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectCategoryImplCopyWith<_$SelectCategoryImpl> get copyWith =>
      __$$SelectCategoryImplCopyWithImpl<_$SelectCategoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadGames,
    required TResult Function(String? query, String? startDate, String? endDate) search,
    required TResult Function(FiltersState filters) applyFilters,
    required TResult Function(SortOption sortOption) updateSort,
    required TResult Function(String category) selectCategory,
    required TResult Function() clearSearch,
    required TResult Function(String? startDate, String? endDate) setDates,
  }) {
    return selectCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadGames,
    TResult? Function(String? query, String? startDate, String? endDate)? search,
    TResult? Function(FiltersState filters)? applyFilters,
    TResult? Function(SortOption sortOption)? updateSort,
    TResult? Function(String category)? selectCategory,
    TResult? Function()? clearSearch,
    TResult? Function(String? startDate, String? endDate)? setDates,
  }) {
    return selectCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadGames,
    TResult Function(String? query, String? startDate, String? endDate)? search,
    TResult Function(FiltersState filters)? applyFilters,
    TResult Function(SortOption sortOption)? updateSort,
    TResult Function(String category)? selectCategory,
    TResult Function()? clearSearch,
    TResult Function(String? startDate, String? endDate)? setDates,
    required TResult orElse(),
  }) {
    if (selectCategory != null) {
      return selectCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadGames value) loadGames,
    required TResult Function(SearchCatalog value) search,
    required TResult Function(ApplyFilters value) applyFilters,
    required TResult Function(UpdateSort value) updateSort,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(ClearSearch value) clearSearch,
    required TResult Function(SetDates value) setDates,
  }) {
    return selectCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadGames value)? loadGames,
    TResult? Function(SearchCatalog value)? search,
    TResult? Function(ApplyFilters value)? applyFilters,
    TResult? Function(UpdateSort value)? updateSort,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(ClearSearch value)? clearSearch,
    TResult? Function(SetDates value)? setDates,
  }) {
    return selectCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadGames value)? loadGames,
    TResult Function(SearchCatalog value)? search,
    TResult Function(ApplyFilters value)? applyFilters,
    TResult Function(UpdateSort value)? updateSort,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(ClearSearch value)? clearSearch,
    TResult Function(SetDates value)? setDates,
    required TResult orElse(),
  }) {
    if (selectCategory != null) {
      return selectCategory(this);
    }
    return orElse();
  }
}

abstract class SelectCategory implements CatalogEvent {
  const factory SelectCategory(final String category) = _$SelectCategoryImpl;

  String get category;

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SelectCategoryImplCopyWith<_$SelectCategoryImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearSearchImplCopyWith<$Res> {
  factory _$$ClearSearchImplCopyWith(_$ClearSearchImpl value, $Res Function(_$ClearSearchImpl) then) =
      __$$ClearSearchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearSearchImplCopyWithImpl<$Res> extends _$CatalogEventCopyWithImpl<$Res, _$ClearSearchImpl>
    implements _$$ClearSearchImplCopyWith<$Res> {
  __$$ClearSearchImplCopyWithImpl(_$ClearSearchImpl _value, $Res Function(_$ClearSearchImpl) _then)
    : super(_value, _then);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearSearchImpl implements ClearSearch {
  const _$ClearSearchImpl();

  @override
  String toString() {
    return 'CatalogEvent.clearSearch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _$ClearSearchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadGames,
    required TResult Function(String? query, String? startDate, String? endDate) search,
    required TResult Function(FiltersState filters) applyFilters,
    required TResult Function(SortOption sortOption) updateSort,
    required TResult Function(String category) selectCategory,
    required TResult Function() clearSearch,
    required TResult Function(String? startDate, String? endDate) setDates,
  }) {
    return clearSearch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadGames,
    TResult? Function(String? query, String? startDate, String? endDate)? search,
    TResult? Function(FiltersState filters)? applyFilters,
    TResult? Function(SortOption sortOption)? updateSort,
    TResult? Function(String category)? selectCategory,
    TResult? Function()? clearSearch,
    TResult? Function(String? startDate, String? endDate)? setDates,
  }) {
    return clearSearch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadGames,
    TResult Function(String? query, String? startDate, String? endDate)? search,
    TResult Function(FiltersState filters)? applyFilters,
    TResult Function(SortOption sortOption)? updateSort,
    TResult Function(String category)? selectCategory,
    TResult Function()? clearSearch,
    TResult Function(String? startDate, String? endDate)? setDates,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadGames value) loadGames,
    required TResult Function(SearchCatalog value) search,
    required TResult Function(ApplyFilters value) applyFilters,
    required TResult Function(UpdateSort value) updateSort,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(ClearSearch value) clearSearch,
    required TResult Function(SetDates value) setDates,
  }) {
    return clearSearch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadGames value)? loadGames,
    TResult? Function(SearchCatalog value)? search,
    TResult? Function(ApplyFilters value)? applyFilters,
    TResult? Function(UpdateSort value)? updateSort,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(ClearSearch value)? clearSearch,
    TResult? Function(SetDates value)? setDates,
  }) {
    return clearSearch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadGames value)? loadGames,
    TResult Function(SearchCatalog value)? search,
    TResult Function(ApplyFilters value)? applyFilters,
    TResult Function(UpdateSort value)? updateSort,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(ClearSearch value)? clearSearch,
    TResult Function(SetDates value)? setDates,
    required TResult orElse(),
  }) {
    if (clearSearch != null) {
      return clearSearch(this);
    }
    return orElse();
  }
}

abstract class ClearSearch implements CatalogEvent {
  const factory ClearSearch() = _$ClearSearchImpl;
}

/// @nodoc
abstract class _$$SetDatesImplCopyWith<$Res> {
  factory _$$SetDatesImplCopyWith(_$SetDatesImpl value, $Res Function(_$SetDatesImpl) then) =
      __$$SetDatesImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? startDate, String? endDate});
}

/// @nodoc
class __$$SetDatesImplCopyWithImpl<$Res> extends _$CatalogEventCopyWithImpl<$Res, _$SetDatesImpl>
    implements _$$SetDatesImplCopyWith<$Res> {
  __$$SetDatesImplCopyWithImpl(_$SetDatesImpl _value, $Res Function(_$SetDatesImpl) _then) : super(_value, _then);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _$SetDatesImpl(
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SetDatesImpl implements SetDates {
  const _$SetDatesImpl({this.startDate, this.endDate});

  @override
  final String? startDate;
  @override
  final String? endDate;

  @override
  String toString() {
    return 'CatalogEvent.setDates(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetDatesImpl &&
            (identical(other.startDate, startDate) || other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetDatesImplCopyWith<_$SetDatesImpl> get copyWith =>
      __$$SetDatesImplCopyWithImpl<_$SetDatesImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadGames,
    required TResult Function(String? query, String? startDate, String? endDate) search,
    required TResult Function(FiltersState filters) applyFilters,
    required TResult Function(SortOption sortOption) updateSort,
    required TResult Function(String category) selectCategory,
    required TResult Function() clearSearch,
    required TResult Function(String? startDate, String? endDate) setDates,
  }) {
    return setDates(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadGames,
    TResult? Function(String? query, String? startDate, String? endDate)? search,
    TResult? Function(FiltersState filters)? applyFilters,
    TResult? Function(SortOption sortOption)? updateSort,
    TResult? Function(String category)? selectCategory,
    TResult? Function()? clearSearch,
    TResult? Function(String? startDate, String? endDate)? setDates,
  }) {
    return setDates?.call(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadGames,
    TResult Function(String? query, String? startDate, String? endDate)? search,
    TResult Function(FiltersState filters)? applyFilters,
    TResult Function(SortOption sortOption)? updateSort,
    TResult Function(String category)? selectCategory,
    TResult Function()? clearSearch,
    TResult Function(String? startDate, String? endDate)? setDates,
    required TResult orElse(),
  }) {
    if (setDates != null) {
      return setDates(startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadGames value) loadGames,
    required TResult Function(SearchCatalog value) search,
    required TResult Function(ApplyFilters value) applyFilters,
    required TResult Function(UpdateSort value) updateSort,
    required TResult Function(SelectCategory value) selectCategory,
    required TResult Function(ClearSearch value) clearSearch,
    required TResult Function(SetDates value) setDates,
  }) {
    return setDates(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadGames value)? loadGames,
    TResult? Function(SearchCatalog value)? search,
    TResult? Function(ApplyFilters value)? applyFilters,
    TResult? Function(UpdateSort value)? updateSort,
    TResult? Function(SelectCategory value)? selectCategory,
    TResult? Function(ClearSearch value)? clearSearch,
    TResult? Function(SetDates value)? setDates,
  }) {
    return setDates?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadGames value)? loadGames,
    TResult Function(SearchCatalog value)? search,
    TResult Function(ApplyFilters value)? applyFilters,
    TResult Function(UpdateSort value)? updateSort,
    TResult Function(SelectCategory value)? selectCategory,
    TResult Function(ClearSearch value)? clearSearch,
    TResult Function(SetDates value)? setDates,
    required TResult orElse(),
  }) {
    if (setDates != null) {
      return setDates(this);
    }
    return orElse();
  }
}

abstract class SetDates implements CatalogEvent {
  const factory SetDates({final String? startDate, final String? endDate}) = _$SetDatesImpl;

  String? get startDate;
  String? get endDate;

  /// Create a copy of CatalogEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetDatesImplCopyWith<_$SetDatesImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CatalogState {
  List<Game> get allGames => throw _privateConstructorUsedError;
  List<Game> get filteredGames => throw _privateConstructorUsedError;
  List<Game> get availableTodayGames => throw _privateConstructorUsedError;
  List<GameCategory> get categories => throw _privateConstructorUsedError;
  List<FilterShortcut> get filterShortcuts => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  String? get selectedCategory => throw _privateConstructorUsedError;
  FiltersState get filters => throw _privateConstructorUsedError;
  SortOption get sortOption => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CatalogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatalogStateCopyWith<CatalogState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogStateCopyWith<$Res> {
  factory $CatalogStateCopyWith(CatalogState value, $Res Function(CatalogState) then) =
      _$CatalogStateCopyWithImpl<$Res, CatalogState>;
  @useResult
  $Res call({
    List<Game> allGames,
    List<Game> filteredGames,
    List<Game> availableTodayGames,
    List<GameCategory> categories,
    List<FilterShortcut> filterShortcuts,
    String query,
    String? startDate,
    String? endDate,
    String? selectedCategory,
    FiltersState filters,
    SortOption sortOption,
    bool isLoading,
    String? errorMessage,
  });

  $FiltersStateCopyWith<$Res> get filters;
}

/// @nodoc
class _$CatalogStateCopyWithImpl<$Res, $Val extends CatalogState> implements $CatalogStateCopyWith<$Res> {
  _$CatalogStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatalogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allGames = null,
    Object? filteredGames = null,
    Object? availableTodayGames = null,
    Object? categories = null,
    Object? filterShortcuts = null,
    Object? query = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? selectedCategory = freezed,
    Object? filters = null,
    Object? sortOption = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            allGames: null == allGames
                ? _value.allGames
                : allGames // ignore: cast_nullable_to_non_nullable
                      as List<Game>,
            filteredGames: null == filteredGames
                ? _value.filteredGames
                : filteredGames // ignore: cast_nullable_to_non_nullable
                      as List<Game>,
            availableTodayGames: null == availableTodayGames
                ? _value.availableTodayGames
                : availableTodayGames // ignore: cast_nullable_to_non_nullable
                      as List<Game>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<GameCategory>,
            filterShortcuts: null == filterShortcuts
                ? _value.filterShortcuts
                : filterShortcuts // ignore: cast_nullable_to_non_nullable
                      as List<FilterShortcut>,
            query: null == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            selectedCategory: freezed == selectedCategory
                ? _value.selectedCategory
                : selectedCategory // ignore: cast_nullable_to_non_nullable
                      as String?,
            filters: null == filters
                ? _value.filters
                : filters // ignore: cast_nullable_to_non_nullable
                      as FiltersState,
            sortOption: null == sortOption
                ? _value.sortOption
                : sortOption // ignore: cast_nullable_to_non_nullable
                      as SortOption,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of CatalogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FiltersStateCopyWith<$Res> get filters {
    return $FiltersStateCopyWith<$Res>(_value.filters, (value) {
      return _then(_value.copyWith(filters: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CatalogStateImplCopyWith<$Res> implements $CatalogStateCopyWith<$Res> {
  factory _$$CatalogStateImplCopyWith(_$CatalogStateImpl value, $Res Function(_$CatalogStateImpl) then) =
      __$$CatalogStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Game> allGames,
    List<Game> filteredGames,
    List<Game> availableTodayGames,
    List<GameCategory> categories,
    List<FilterShortcut> filterShortcuts,
    String query,
    String? startDate,
    String? endDate,
    String? selectedCategory,
    FiltersState filters,
    SortOption sortOption,
    bool isLoading,
    String? errorMessage,
  });

  @override
  $FiltersStateCopyWith<$Res> get filters;
}

/// @nodoc
class __$$CatalogStateImplCopyWithImpl<$Res> extends _$CatalogStateCopyWithImpl<$Res, _$CatalogStateImpl>
    implements _$$CatalogStateImplCopyWith<$Res> {
  __$$CatalogStateImplCopyWithImpl(_$CatalogStateImpl _value, $Res Function(_$CatalogStateImpl) _then)
    : super(_value, _then);

  /// Create a copy of CatalogState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allGames = null,
    Object? filteredGames = null,
    Object? availableTodayGames = null,
    Object? categories = null,
    Object? filterShortcuts = null,
    Object? query = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? selectedCategory = freezed,
    Object? filters = null,
    Object? sortOption = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$CatalogStateImpl(
        allGames: null == allGames
            ? _value._allGames
            : allGames // ignore: cast_nullable_to_non_nullable
                  as List<Game>,
        filteredGames: null == filteredGames
            ? _value._filteredGames
            : filteredGames // ignore: cast_nullable_to_non_nullable
                  as List<Game>,
        availableTodayGames: null == availableTodayGames
            ? _value._availableTodayGames
            : availableTodayGames // ignore: cast_nullable_to_non_nullable
                  as List<Game>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<GameCategory>,
        filterShortcuts: null == filterShortcuts
            ? _value._filterShortcuts
            : filterShortcuts // ignore: cast_nullable_to_non_nullable
                  as List<FilterShortcut>,
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        selectedCategory: freezed == selectedCategory
            ? _value.selectedCategory
            : selectedCategory // ignore: cast_nullable_to_non_nullable
                  as String?,
        filters: null == filters
            ? _value.filters
            : filters // ignore: cast_nullable_to_non_nullable
                  as FiltersState,
        sortOption: null == sortOption
            ? _value.sortOption
            : sortOption // ignore: cast_nullable_to_non_nullable
                  as SortOption,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CatalogStateImpl extends _CatalogState {
  const _$CatalogStateImpl({
    final List<Game> allGames = const [],
    final List<Game> filteredGames = const [],
    final List<Game> availableTodayGames = const [],
    final List<GameCategory> categories = const [],
    final List<FilterShortcut> filterShortcuts = const [],
    this.query = '',
    this.startDate,
    this.endDate,
    this.selectedCategory,
    this.filters = const FiltersState(),
    this.sortOption = SortOption.availability,
    this.isLoading = false,
    this.errorMessage,
  }) : _allGames = allGames,
       _filteredGames = filteredGames,
       _availableTodayGames = availableTodayGames,
       _categories = categories,
       _filterShortcuts = filterShortcuts,
       super._();

  final List<Game> _allGames;
  @override
  @JsonKey()
  List<Game> get allGames {
    if (_allGames is EqualUnmodifiableListView) return _allGames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allGames);
  }

  final List<Game> _filteredGames;
  @override
  @JsonKey()
  List<Game> get filteredGames {
    if (_filteredGames is EqualUnmodifiableListView) return _filteredGames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredGames);
  }

  final List<Game> _availableTodayGames;
  @override
  @JsonKey()
  List<Game> get availableTodayGames {
    if (_availableTodayGames is EqualUnmodifiableListView) return _availableTodayGames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableTodayGames);
  }

  final List<GameCategory> _categories;
  @override
  @JsonKey()
  List<GameCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<FilterShortcut> _filterShortcuts;
  @override
  @JsonKey()
  List<FilterShortcut> get filterShortcuts {
    if (_filterShortcuts is EqualUnmodifiableListView) return _filterShortcuts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filterShortcuts);
  }

  @override
  @JsonKey()
  final String query;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? selectedCategory;
  @override
  @JsonKey()
  final FiltersState filters;
  @override
  @JsonKey()
  final SortOption sortOption;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'CatalogState(allGames: $allGames, filteredGames: $filteredGames, availableTodayGames: $availableTodayGames, categories: $categories, filterShortcuts: $filterShortcuts, query: $query, startDate: $startDate, endDate: $endDate, selectedCategory: $selectedCategory, filters: $filters, sortOption: $sortOption, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogStateImpl &&
            const DeepCollectionEquality().equals(other._allGames, _allGames) &&
            const DeepCollectionEquality().equals(other._filteredGames, _filteredGames) &&
            const DeepCollectionEquality().equals(other._availableTodayGames, _availableTodayGames) &&
            const DeepCollectionEquality().equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._filterShortcuts, _filterShortcuts) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.startDate, startDate) || other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory) &&
            (identical(other.filters, filters) || other.filters == filters) &&
            (identical(other.sortOption, sortOption) || other.sortOption == sortOption) &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_allGames),
    const DeepCollectionEquality().hash(_filteredGames),
    const DeepCollectionEquality().hash(_availableTodayGames),
    const DeepCollectionEquality().hash(_categories),
    const DeepCollectionEquality().hash(_filterShortcuts),
    query,
    startDate,
    endDate,
    selectedCategory,
    filters,
    sortOption,
    isLoading,
    errorMessage,
  );

  /// Create a copy of CatalogState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogStateImplCopyWith<_$CatalogStateImpl> get copyWith =>
      __$$CatalogStateImplCopyWithImpl<_$CatalogStateImpl>(this, _$identity);
}

abstract class _CatalogState extends CatalogState {
  const factory _CatalogState({
    final List<Game> allGames,
    final List<Game> filteredGames,
    final List<Game> availableTodayGames,
    final List<GameCategory> categories,
    final List<FilterShortcut> filterShortcuts,
    final String query,
    final String? startDate,
    final String? endDate,
    final String? selectedCategory,
    final FiltersState filters,
    final SortOption sortOption,
    final bool isLoading,
    final String? errorMessage,
  }) = _$CatalogStateImpl;
  const _CatalogState._() : super._();

  @override
  List<Game> get allGames;
  @override
  List<Game> get filteredGames;
  @override
  List<Game> get availableTodayGames;
  @override
  List<GameCategory> get categories;
  @override
  List<FilterShortcut> get filterShortcuts;
  @override
  String get query;
  @override
  String? get startDate;
  @override
  String? get endDate;
  @override
  String? get selectedCategory;
  @override
  FiltersState get filters;
  @override
  SortOption get sortOption;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of CatalogState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatalogStateImplCopyWith<_$CatalogStateImpl> get copyWith => throw _privateConstructorUsedError;
}
