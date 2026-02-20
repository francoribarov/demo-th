import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/services/image_upload_service.dart';
import 'package:mobile_table_hopping/data/mapper/my_publications/publish_delivery_method_to_my_publications.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_detail.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/domain/params/my_publications/update_publication_params.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_games_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/delete_publication_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/get_publication_detail_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/update_publication_use_case.dart';
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
    required GetPublicationDetailUseCase getPublicationDetail,
    required UpdatePublicationUseCase updatePublication,
    required DeletePublicationUseCase deletePublication,
    required GetGamesUseCase getGames,
    required GetDeliveryMethods getDeliveryMethods,
    required ImageUploadService imageUploadService,
  })  : _getPublicationDetail = getPublicationDetail,
        _updatePublication = updatePublication,
        _deletePublication = deletePublication,
        _getGames = getGames,
        _getDeliveryMethods = getDeliveryMethods,
        _imageUploadService = imageUploadService,
        super(const EditPublicationState()) {
    _registerEventHandlers();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Constants
  // ─────────────────────────────────────────────────────────────────────────

  /// Maximum step index in the edit flow (0-indexed).
  static const int maxStep = 3;

  /// Minimum step index in the edit flow.
  static const int minStep = 0;

  // ─────────────────────────────────────────────────────────────────────────
  // Dependencies
  // ─────────────────────────────────────────────────────────────────────────

  final GetPublicationDetailUseCase _getPublicationDetail;
  final UpdatePublicationUseCase _updatePublication;
  final DeletePublicationUseCase _deletePublication;
  final GetGamesUseCase _getGames;
  final GetDeliveryMethods _getDeliveryMethods;
  final ImageUploadService _imageUploadService;

  // ─────────────────────────────────────────────────────────────────────────
  // Event Registration
  // ─────────────────────────────────────────────────────────────────────────

  void _registerEventHandlers() {
    // Initialization
    on<_Started>(_onStarted);
    on<_DescriptionChanged>(_onDescriptionChanged);
    on<_PriceChanged>(_onPriceChanged);
    on<_ConditionChanged>(_onConditionChanged);
    on<_ImagesChanged>(_onImagesChanged);
    on<_DeliveryMethodsChanged>(_onDeliveryMethodsChanged);
    on<_ToggleDeliveryMethod>(_onToggleDeliveryMethod);

    // Navigation
    on<_NextStep>(_onNextStep);
    on<_PreviousStep>(_onPreviousStep);
    on<_PickImage>(_onPickImage);
    on<_PickMultipleImages>(_onPickMultipleImages);
    on<_RemoveImage>(_onRemoveImage);

    // Actions
    on<_Submit>(_onSubmit);
    on<_Delete>(_onDelete);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Initialization Handler
  // ─────────────────────────────────────────────────────────────────────────

  Future<void> _onStarted(
    _Started event,
    Emitter<EditPublicationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, publicationId: event.publicationId));

    try {
      final gamesResult = await _getGames();
      final deliveryMethods = await _getDeliveryMethods();
      final games = gamesResult.fold<List<Game>>(
        (_) => const [],
        (value) => value,
      );
      final mappedDeliveryMethods = deliveryMethods
          .map((method) => method.toMyPublicationsModel())
          .toList();

      // Load publication details using Either pattern
      final publicationResult = await _getPublicationDetail(event.publicationId);

      publicationResult.fold(
        // Error case
        (error) {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: error.message,
            ),
          );
        },
        // Success case
        (publication) {
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
              availableDeliveryMethods: mappedDeliveryMethods,
            ),
          );
        },
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
    if (state.currentStep < maxStep) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onPreviousStep(
    _PreviousStep event,
    Emitter<EditPublicationState> emit,
  ) {
    if (state.currentStep > minStep) {
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

    final params = UpdatePublicationParams(
      id: state.publicationId!,
      description: state.description,
      condition: state.condition,
      price: state.price,
      images: state.images,
      deliveryMethodIds:
          state.deliveryMethods.map((m) => m.id ?? '').toList(),
    );

    final result = await _updatePublication(params);

    result.fold(
      // Error case
      (error) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: error.message,
          ),
        );
      },
      // Success case
      (updated) {
        emit(
          state.copyWith(
            isSubmitting: false,
            success: true,
            publication: updated,
            hasChanges: false,
          ),
        );
      },
    );
  }

  Future<void> _onDelete(
    _Delete event,
    Emitter<EditPublicationState> emit,
  ) async {
    emit(state.copyWith(isDeleting: true, errorMessage: null));

    final result = await _deletePublication(state.publicationId!);

    result.fold(
      // Error case
      (error) {
        emit(
          state.copyWith(
            isDeleting: false,
            errorMessage: error.message,
          ),
        );
      },
      // Success case
      (_) {
        emit(state.copyWith(isDeleting: false, deleted: true));
      },
    );
  }

  Future<void> _onPickImage(
    _PickImage event,
    Emitter<EditPublicationState> emit,
  ) async {
    final imagePath = await _imageUploadService.pickImageFromGallery();
    if (imagePath != null) {
      await _uploadAndAddImages([imagePath], emit);
    }
  }

  Future<void> _onPickMultipleImages(
    _PickMultipleImages event,
    Emitter<EditPublicationState> emit,
  ) async {
    final imagePaths = await _imageUploadService.pickMultipleImages();
    if (imagePaths.isNotEmpty) {
      await _uploadAndAddImages(imagePaths, emit);
    }
  }

  Future<void> _uploadAndAddImages(
    List<String> imagePaths,
    Emitter<EditPublicationState> emit,
  ) async {
    try {
      emit(state.copyWith(isUploadingImage: true));
      final imageUrls = await _imageUploadService.uploadImages(imagePaths);
      emit(
        state.copyWith(
          images: [...state.images, ...imageUrls],
          hasChanges: true,
          isUploadingImage: false,
        ),
      );
    } on Object catch (e) {
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
    final isValidIndex = event.index >= 0 && event.index < state.images.length;
    if (isValidIndex) {
      final updatedImages = [...state.images]..removeAt(event.index);
      emit(state.copyWith(images: updatedImages, hasChanges: true));
    }
  }
}
