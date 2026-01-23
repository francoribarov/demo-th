part of 'my_publications_bloc.dart';

@freezed
class MyPublicationsState with _$MyPublicationsState {
  const factory MyPublicationsState.initial() = _Initial;
  const factory MyPublicationsState.loading() = _Loading;
  const factory MyPublicationsState.success(List<Game> games) = _Success;
  const factory MyPublicationsState.failure(String message) = _Failure;
}
