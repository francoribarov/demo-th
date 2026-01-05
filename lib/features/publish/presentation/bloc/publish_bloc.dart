import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/listing.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_listing.dart';
import 'package:mobile_table_hopping/features/publish/domain/validators/listing_validator.dart';

part 'publish_bloc.freezed.dart';
part 'publish_event.dart';
part 'publish_state.dart';

@injectable
/// Coordinates publish flow actions and side effects.
class PublishBloc extends Bloc<PublishEvent, PublishState> {
  /// Creates a publish bloc wired to the create listing use case.
  PublishBloc({required CreateListing createListing}) : _createListing = createListing, super(const PublishState()) {
    on<_Started>(_onStarted);
    on<_NextStep>(_onNextStep);
    on<_PreviousStep>(_onPreviousStep);
    on<_Submit>(_onSubmit);
    on<_PublishAnother>(_onPublishAnother);

    on<_TitleChanged>(_onTitleChanged);
    on<_PublisherChanged>(_onPublisherChanged);
    on<_CategoryChanged>(_onCategoryChanged);
    on<_DescriptionChanged>(_onDescriptionChanged);
    on<_DurationChanged>(_onDurationChanged);
    on<_PlayersChanged>(_onPlayersChanged);
    on<_DifficultyChanged>(_onDifficultyChanged);
    on<_PricePerDayChanged>(_onPricePerDayChanged);
    on<_DepositChanged>(_onDepositChanged);
    on<_ConditionChanged>(_onConditionChanged);
    on<_VisibilityChanged>(_onVisibilityChanged);
    on<_ImagesChanged>(_onImagesChanged);
  }
  static const _defaultImageUrl =
      'https://images.vexels.com/media/users/3/189702/isolated/preview/'
      '0909c4a72562b45eb247012f1606c4c6-icono-de-juguete-de-dados.png';

  final CreateListing _createListing;

  void _onStarted(_Started event, Emitter<PublishState> emit) {
    emit(const PublishState());
  }

  void _onNextStep(_NextStep event, Emitter<PublishState> emit) {
    if (!state.canProceed) return;

    if (state.currentStep < 3) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    } else {
      add(const PublishEvent.submit());
    }
  }

  void _onPreviousStep(_PreviousStep event, Emitter<PublishState> emit) {
    if (state.currentStep <= 0) return;
    emit(state.copyWith(currentStep: state.currentStep - 1));
  }

  Future<void> _onSubmit(_Submit event, Emitter<PublishState> emit) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final images = state.images.isNotEmpty ? state.images : [_defaultImageUrl];
      await _createListing(
        ListingDraft(
          title: state.title.trim(),
          publisher: state.publisher.trim().isEmpty ? null : state.publisher.trim(),
          category: state.category,
          description: state.description.trim(),
          duration: state.duration.trim().isEmpty ? null : state.duration.trim(),
          players: state.players.trim().isEmpty ? null : state.players.trim(),
          difficulty: state.difficulty,
          pricePerDay: state.pricePerDay,
          deposit: state.deposit,
          condition: state.condition,
          visibility: state.visibility,
          images: images
              .asMap()
              .entries
              .map((entry) => ListingImage(url: entry.value, type: entry.key == 0 ? 'hero' : 'gallery'))
              .toList(),
        ),
      );

      emit(state.copyWith(isSubmitting: false, success: true));
    } on Exception catch (error) {
      emit(state.copyWith(isSubmitting: false, errorMessage: 'No se pudo publicar: $error'));
    }
  }

  void _onPublishAnother(_PublishAnother event, Emitter<PublishState> emit) {
    emit(PublishState(formVersion: state.formVersion + 1));
  }

  void _onTitleChanged(_TitleChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(title: event.value));
  }

  void _onPublisherChanged(_PublisherChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(publisher: event.value));
  }

  void _onCategoryChanged(_CategoryChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(category: event.value));
  }

  void _onDescriptionChanged(_DescriptionChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(description: event.value));
  }

  void _onDurationChanged(_DurationChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(duration: event.value));
  }

  void _onPlayersChanged(_PlayersChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(players: event.value));
  }

  void _onDifficultyChanged(_DifficultyChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(difficulty: event.value));
  }

  void _onPricePerDayChanged(_PricePerDayChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(pricePerDay: event.value));
  }

  void _onDepositChanged(_DepositChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(deposit: event.value));
  }

  void _onConditionChanged(_ConditionChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(condition: event.value));
  }

  void _onVisibilityChanged(_VisibilityChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(visibility: event.value));
  }

  void _onImagesChanged(_ImagesChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(images: event.value));
  }
}
