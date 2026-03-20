import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/data/mapper/my_publications/publish_delivery_method_to_my_publications.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_detail.dart';
import 'package:mobile_table_hopping/domain/model/my_publications/publication_primitives.dart';
import 'package:mobile_table_hopping/domain/model/publish/delivery_method.dart'
    as publish;
import 'package:mobile_table_hopping/domain/params/my_publications/update_publication_params.dart';
import 'package:mobile_table_hopping/domain/usecase/catalog/get_games_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/delete_publication_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/get_publication_detail_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/my_publications/update_publication_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/publish/get_delivery_methods_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/upload/upload_images_use_case.dart';
import 'package:mobile_table_hopping/domain/validators/publication/publication_validator.dart';
import 'package:mobile_table_hopping/presentation/blocs/common/publication_form_state.dart';
import 'package:mobile_table_hopping/presentation/gateway/image_picker_gateway.dart';
import 'package:mobile_table_hopping/presentation/validators/publication_validation_error_mapper.dart';

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
    required GetDeliveryMethodsUseCase getDeliveryMethods,
    required ImagePickerGateway imagePickerGateway,
    required UploadImagesUseCase uploadImages,
  }) : _getPublicationDetail = getPublicationDetail,
       _updatePublication = updatePublication,
       _deletePublication = deletePublication,
       _getGames = getGames,
       _getDeliveryMethods = getDeliveryMethods,
       _gateway = imagePickerGateway,
       _uploadImages = uploadImages,
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
  final GetDeliveryMethodsUseCase _getDeliveryMethods;
  final ImagePickerGateway _gateway;
  final UploadImagesUseCase _uploadImages;

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
      final games = gamesResult.fold<List<Game>>(
        (_) => const [],
        (value) => value,
      );
      final deliveryMethodsResult = await _getDeliveryMethods();
      final deliveryMethods = deliveryMethodsResult
          .fold<List<publish.DeliveryMethod>>(
            (_) => const [],
            (value) => value,
          );
      final mappedDeliveryMethods = deliveryMethods
          .map((method) => method.toMyPublicationsModel())
          .toList();

      // Load publication details using Either pattern
      final publicationResult = await _getPublicationDetail(
        event.publicationId,
      );

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
              images: publication.images.map((i) => i.url).toList(),
              deliveryMethods: publication.deliveryMethods,
              allGames: games,
              availableDeliveryMethods: mappedDeliveryMethods,
              form: PublicationFormState(
                gameId: publication.gameId,
                description: publication.description,
                condition: publication.condition,
                price: publication.price,
                descriptionError:
                    PublicationValidationErrorMapper.mapDescriptionError(
                      PublicationValidator.validateDescription(
                        publication.description,
                      ),
                    ),
                conditionError:
                    PublicationValidationErrorMapper.mapConditionError(
                      PublicationValidator.validateCondition(
                        publication.condition,
                      ),
                    ),
                priceError: PublicationValidationErrorMapper.mapPriceError(
                  PublicationValidator.validatePricing(publication.price),
                ),
              ),
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
    emit(
      state.copyWith(
        hasChanges: true,
        form: state.form.copyWith(
          description: event.value,
          descriptionError:
              PublicationValidationErrorMapper.mapDescriptionError(
                PublicationValidator.validateDescription(event.value),
              ),
        ),
      ),
    );
  }

  void _onPriceChanged(
    _PriceChanged event,
    Emitter<EditPublicationState> emit,
  ) {
    emit(
      state.copyWith(
        hasChanges: true,
        form: state.form.copyWith(
          price: event.value,
          priceError: PublicationValidationErrorMapper.mapPriceError(
            PublicationValidator.validatePricing(event.value),
          ),
        ),
      ),
    );
  }

  void _onConditionChanged(
    _ConditionChanged event,
    Emitter<EditPublicationState> emit,
  ) {
    emit(
      state.copyWith(
        hasChanges: true,
        form: state.form.copyWith(
          condition: event.value,
          conditionError: PublicationValidationErrorMapper.mapConditionError(
            PublicationValidator.validateCondition(event.value),
          ),
        ),
      ),
    );
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
    final exists = state.deliveryMethods.any(
      (m) => m.id == event.method.id && m.id != null,
    );

    List<DeliveryMethod> updated;
    if (exists) {
      updated = state.deliveryMethods
          .where((m) => m.id != event.method.id)
          .toList();
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
      description: state.form.description,
      condition: state.form.condition,
      price: state.form.price,
      images: state.images,
      deliveryMethodIds: state.deliveryMethods.map((m) => m.id ?? '').toList(),
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
    final imagePath = await _gateway.pickImageFromGallery();
    if (imagePath != null) {
      await _uploadAndAddImages([imagePath], emit);
    }
  }

  Future<void> _onPickMultipleImages(
    _PickMultipleImages event,
    Emitter<EditPublicationState> emit,
  ) async {
    final imagePaths = await _gateway.pickMultipleImages();
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

      final result = await _uploadImages(imagePaths);
      result.fold(
        (error) {
          emit(
            state.copyWith(
              isUploadingImage: false,
              errorMessage: 'Error al subir imágenes: ${error.message}',
            ),
          );
        },
        (imageUrls) {
          emit(
            state.copyWith(
              images: [...state.images, ...imageUrls],
              hasChanges: true,
              isUploadingImage: false,
            ),
          );
        },
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
