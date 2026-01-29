import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/services/image_upload_service.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/my_publication_details/domain/entities/publication_detail.dart';
import 'package:mobile_table_hopping/features/my_publication_details/domain/usecases/delete_publication.dart';
import 'package:mobile_table_hopping/features/my_publication_details/domain/usecases/get_publication_detail.dart';
import 'package:mobile_table_hopping/features/my_publication_details/domain/usecases/update_publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/get_delivery_methods.dart';

part 'edit_publication_bloc.freezed.dart';
part 'edit_publication_event.dart';
part 'edit_publication_state.dart';

@injectable

/// Bloc that manages the edit publication flow.
class EditPublicationBloc
    extends Bloc<EditPublicationEvent, EditPublicationState> {
  /// Creates the bloc with required use cases.
  EditPublicationBloc({
    required GetPublicationDetail getPublicationDetail,
    required UpdatePublication updatePublication,
    required DeletePublication deletePublication,
    required GetGames getGames,
    required GetDeliveryMethods getDeliveryMethods,
    required ImageUploadService imageUploadService,
  })  : _getPublicationDetail = getPublicationDetail,
        _updatePublication = updatePublication,
        _deletePublication = deletePublication,
        _getGames = getGames,
        _getDeliveryMethods = getDeliveryMethods,
        _imageUploadService = imageUploadService,
        super(const EditPublicationState()) {
    on<_Started>(_onStarted);
    on<_DescriptionChanged>(_onDescriptionChanged);
    on<_PriceChanged>(_onPriceChanged);
    on<_ConditionChanged>(_onConditionChanged);
    on<_ImagesChanged>(_onImagesChanged);
    on<_DeliveryMethodsChanged>(_onDeliveryMethodsChanged);
    on<_ToggleDeliveryMethod>(_onToggleDeliveryMethod);
    on<_Submit>(_onSubmit);
    on<_Delete>(_onDelete);
    on<_NextStep>(_onNextStep);
    on<_PreviousStep>(_onPreviousStep);
    on<_PickImage>(_onPickImage);
    on<_PickMultipleImages>(_onPickMultipleImages);
    on<_RemoveImage>(_onRemoveImage);
  }

  final GetPublicationDetail _getPublicationDetail;
  final UpdatePublication _updatePublication;
  final DeletePublication _deletePublication;
  final GetGames _getGames;
  final GetDeliveryMethods _getDeliveryMethods;
  final ImageUploadService _imageUploadService;

  Future<void> _onStarted(
    _Started event,
    Emitter<EditPublicationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, publicationId: event.publicationId));

    try {
      // Load publication details, games, and delivery methods in parallel
      final results = await Future.wait([
        _getPublicationDetail(event.publicationId),
        _getGames(),
        _getDeliveryMethods(),
      ]);

      final publication = results[0] as PublicationDetail;
      final games = results[1] as List<Game>;
      final deliveryMethods = results[2] as List<DeliveryMethod>;

      emit(
        state.copyWith(
          isLoading: false,
          publication: publication,
          gameId: publication.gameId,
          description: publication.description,
          condition: publication.condition,
          price: publication.price,
          images: publication.images.map((i) => i.url).toList(),
          deliveryMethods: publication.deliveryMethods,
          allGames: games,
          availableDeliveryMethods: deliveryMethods,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onDescriptionChanged(
    _DescriptionChanged event,
    Emitter<EditPublicationState> emit,
  ) {
    emit(state.copyWith(description: event.value, hasChanges: true));
  }

  void _onPriceChanged(
    _PriceChanged event,
    Emitter<EditPublicationState> emit,
  ) {
    emit(state.copyWith(price: event.value, hasChanges: true));
  }

  void _onConditionChanged(
    _ConditionChanged event,
    Emitter<EditPublicationState> emit,
  ) {
    emit(state.copyWith(condition: event.value, hasChanges: true));
  }

  void _onImagesChanged(
    _ImagesChanged event,
    Emitter<EditPublicationState> emit,
  ) {
    emit(state.copyWith(images: event.value, hasChanges: true));
  }

  void _onDeliveryMethodsChanged(
    _DeliveryMethodsChanged event,
    Emitter<EditPublicationState> emit,
  ) {
    emit(state.copyWith(deliveryMethods: event.value, hasChanges: true));
  }

  void _onToggleDeliveryMethod(
    _ToggleDeliveryMethod event,
    Emitter<EditPublicationState> emit,
  ) {
    final exists = state.deliveryMethods
        .any((m) => m.id == event.method.id && m.id != null);

    List<DeliveryMethod> updated;
    if (exists) {
      updated =
          state.deliveryMethods.where((m) => m.id != event.method.id).toList();
    } else {
      updated = [...state.deliveryMethods, event.method];
    }
    emit(state.copyWith(deliveryMethods: updated, hasChanges: true));
  }

  void _onNextStep(_NextStep event, Emitter<EditPublicationState> emit) {
    if (state.currentStep < 3) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onPreviousStep(
      _PreviousStep event, Emitter<EditPublicationState> emit) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> _onSubmit(
    _Submit event,
    Emitter<EditPublicationState> emit,
  ) async {
    if (!state.hasChanges) {
      emit(state.copyWith(success: true));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final update = PublicationUpdate(
        description: state.description,
        condition: state.condition,
        price: state.price,
        images: state.images,
        deliveryMethodIds:
            state.deliveryMethods.map((m) => m.id ?? '').toList(),
      );

      final updated = await _updatePublication(state.publicationId!, update);

      emit(
        state.copyWith(
          isSubmitting: false,
          success: true,
          publication: updated,
          hasChanges: false,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDelete(
    _Delete event,
    Emitter<EditPublicationState> emit,
  ) async {
    emit(state.copyWith(isDeleting: true, errorMessage: null));

    try {
      await _deletePublication(state.publicationId!);
      emit(state.copyWith(isDeleting: false, deleted: true));
    } on Object catch (e) {
      emit(
        state.copyWith(
          isDeleting: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onPickImage(
    _PickImage event,
    Emitter<EditPublicationState> emit,
  ) async {
    try {
      final imagePath = await _imageUploadService.pickImageFromGallery();
      if (imagePath != null) {
        emit(state.copyWith(isUploadingImage: true));
        final imageUrl = await _imageUploadService.uploadImage(imagePath);
        emit(
          state.copyWith(
            images: [...state.images, imageUrl],
            hasChanges: true,
            isUploadingImage: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isUploadingImage: false,
          errorMessage: 'Error al subir imagen: $e',
        ),
      );
    }
  }

  Future<void> _onPickMultipleImages(
    _PickMultipleImages event,
    Emitter<EditPublicationState> emit,
  ) async {
    try {
      final imagePaths = await _imageUploadService.pickMultipleImages();
      if (imagePaths.isNotEmpty) {
        emit(state.copyWith(isUploadingImage: true));
        final imageUrls = await _imageUploadService.uploadImages(imagePaths);
        emit(
          state.copyWith(
            images: [...state.images, ...imageUrls],
            hasChanges: true,
            isUploadingImage: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isUploadingImage: false,
          errorMessage: 'Error al subir imágenes: $e',
        ),
      );
    }
  }

  void _onRemoveImage(
    _RemoveImage event,
    Emitter<EditPublicationState> emit,
  ) {
    if (event.index >= 0 && event.index < state.images.length) {
      final updatedImages = [...state.images]..removeAt(event.index);
      emit(state.copyWith(images: updatedImages, hasChanges: true));
    }
  }
}
