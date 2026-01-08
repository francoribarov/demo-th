import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/validators/publication_validator.dart';

part 'publish_bloc.freezed.dart';
part 'publish_event.dart';
part 'publish_state.dart';

@injectable
/// Coordinates publish flow actions and side effects.
class PublishBloc extends Bloc<PublishEvent, PublishState> {
  /// Creates a publish bloc wired to the create publication use case.
  PublishBloc({required CreatePublication createPublication})
    : _createPublication = createPublication,
      super(const PublishState()) {
    on<_Started>(_onStarted);
    on<_NextStep>(_onNextStep);
    on<_PreviousStep>(_onPreviousStep);
    on<_Submit>(_onSubmit);
    on<_PublishAnother>(_onPublishAnother);
    on<_GameIdChanged>(_onGameIdChanged);
    on<_DescriptionChanged>(_onDescriptionChanged);
    on<_PriceChanged>(_onPriceChanged);
    on<_ConditionChanged>(_onConditionChanged);
    on<_ImagesChanged>(_onImagesChanged);
    on<_DeliveryMethodsChanged>(_onDeliveryMethodsChanged);
  }

  final CreatePublication _createPublication;
  static const _defaultImageUrl = 'https://via.placeholder.com/300'; // Temporary placeholder

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

  void _onPublishAnother(_PublishAnother event, Emitter<PublishState> emit) {
    emit(PublishState(formVersion: state.formVersion + 1));
  }

  Future<void> _onSubmit(_Submit event, Emitter<PublishState> emit) async {
    if (state.isSubmitting) return;
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final images = state.images.isNotEmpty ? state.images : [_defaultImageUrl];
      await _createPublication(
        PublicationDraft(
          gameId: state.gameId,
          description: state.description.trim(),
          price: state.price,
          condition: state.condition,
          images: images
              .asMap()
              .entries
              .map((entry) => PublicationImage(url: entry.value, type: entry.key == 0 ? 'hero' : 'gallery'))
              .toList(),
          deliveryMethods: state.deliveryMethods,
        ),
      );

      emit(state.copyWith(isSubmitting: false, success: true));
    } on Exception catch (error) {
      emit(state.copyWith(isSubmitting: false, errorMessage: 'No se pudo publicar: $error'));
    }
  }

  void _onGameIdChanged(_GameIdChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(gameId: event.value));
  }

  void _onDescriptionChanged(_DescriptionChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(description: event.value));
  }

  void _onPriceChanged(_PriceChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(price: event.value));
  }

  void _onConditionChanged(_ConditionChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(condition: event.value));
  }

  void _onImagesChanged(_ImagesChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(images: event.value));
  }

  void _onDeliveryMethodsChanged(_DeliveryMethodsChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(deliveryMethods: event.value));
  }
}
