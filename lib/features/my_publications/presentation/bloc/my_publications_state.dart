part of 'my_publications_bloc.dart';

/// State for [MyPublicationsBloc].
@freezed
sealed class MyPublicationsState with _$MyPublicationsState {
  const factory MyPublicationsState({
    /// Whether data is being loaded.
    @Default(false) bool isLoading,

    /// Whether data is being refreshed.
    @Default(false) bool isRefreshing,

    /// List of user's publications.
    @Default([]) List<PublicationListing> publications,

    /// Error message if any.
    String? errorMessage,
  }) = _MyPublicationsState;
}
