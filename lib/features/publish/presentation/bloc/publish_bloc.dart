import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/core/services/image_upload_service.dart';
import 'package:mobile_table_hopping/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/domain/usecases/get_games.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/entities/publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_delivery_method.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_publication.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/get_delivery_methods.dart';
import 'package:mobile_table_hopping/features/publish/domain/validators/publication_validator.dart';

part 'publish_bloc.freezed.dart';
part 'publish_event.dart';
part 'publish_state.dart';

@injectable

/// Coordinates publish flow actions and side effects.
class PublishBloc extends Bloc<PublishEvent, PublishState> {
  /// Creates a publish bloc wired to the create publication use case.
  PublishBloc({
    required CreatePublication createPublication,
    required AuthBloc authBloc,
    required GetGames getGames,
    required CreateDeliveryMethod createDeliveryMethod,
    required GetDeliveryMethods getDeliveryMethods,
    required ImageUploadService imageUploadService,
  })  : _createPublication = createPublication,
        _authBloc = authBloc,
        _getGames = getGames,
        _createDeliveryMethod = createDeliveryMethod,
        _getDeliveryMethods = getDeliveryMethods,
        _imageUploadService = imageUploadService,
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
    on<_LoadGames>(_onLoadGames);
    on<_SearchGames>(_onSearchGames);
    on<_DeliveryMethodsChanged>(_onDeliveryMethodsChanged);
    on<_AddDeliveryMethod>(_onAddDeliveryMethod);
    on<_GetDeliveryMethods>(_onGetDeliveryMethods);
    on<_ToggleDeliveryMethod>(_onToggleDeliveryMethod);
    on<_PickMultipleImages>(_onPickMultipleImages);
  }

  final CreatePublication _createPublication;
  final AuthBloc _authBloc;
  final GetGames _getGames;
  final CreateDeliveryMethod _createDeliveryMethod;
  final GetDeliveryMethods _getDeliveryMethods;
  final ImageUploadService _imageUploadService;

  void _onStarted(_Started event, Emitter<PublishState> emit) {
    emit(const PublishState());
    add(const PublishEvent.loadGames());
    add(const PublishEvent.getDeliveryMethods());
  }

  void _onNextStep(_NextStep event, Emitter<PublishState> emit) {
    if (state.canProceed) {
      if (state.currentStep == 3) {
        add(const PublishEvent.submit());
      } else {
        emit(state.copyWith(currentStep: state.currentStep + 1));
      }
    }
  }

  void _onPreviousStep(_PreviousStep event, Emitter<PublishState> emit) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _onPublishAnother(_PublishAnother event, Emitter<PublishState> emit) {
    emit(PublishState(formVersion: state.formVersion + 1));
  }

  Future<void> _onSubmit(_Submit event, Emitter<PublishState> emit) async {
    if (!state.canProceed) return;

    final userId = _authBloc.state.session?.user?.id;
    if (userId == null) {
      emit(state.copyWith(errorMessage: 'Debes iniciar sesión para publicar.'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final draft = PublicationDraft(
        gameId: state.gameId,
        description: state.description,
        price: state.price,
        condition: state.condition,
        images: state.images
            .map(
              (url) => PublicationImage(
                url: url,
                type: 'image',
              ),
            )
            .toList(),
        deliveryMethods: state.deliveryMethods,
      );

      await _createPublication(draft, ownerId: userId);

      emit(
        state.copyWith(
          isSubmitting: false,
          success: true,
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

  void _onGameIdChanged(_GameIdChanged event, Emitter<PublishState> emit) {
    emit(
      state.copyWith(
        gameId: event.value,
        condition: '', // Reset condition when game changes
      ),
    );
  }

  void _onDescriptionChanged(
    _DescriptionChanged event,
    Emitter<PublishState> emit,
  ) {
    emit(state.copyWith(description: event.value));
  }

  void _onPriceChanged(_PriceChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(price: event.value));
  }

  void _onConditionChanged(
    _ConditionChanged event,
    Emitter<PublishState> emit,
  ) {
    emit(state.copyWith(condition: event.value));
  }

  void _onImagesChanged(_ImagesChanged event, Emitter<PublishState> emit) {
    emit(state.copyWith(images: event.value));
  }

  void _onDeliveryMethodsChanged(
    _DeliveryMethodsChanged event,
    Emitter<PublishState> emit,
  ) {
    emit(state.copyWith(deliveryMethods: event.value));
  }

  Future<void> _onLoadGames(
    _LoadGames event,
    Emitter<PublishState> emit,
  ) async {
    emit(state.copyWith(isLoadingGames: true));
    try {
      final games = await _getGames();
      emit(
        state.copyWith(
          isLoadingGames: false,
          allGames: games,
          filteredGames: games,
        ),
      );
    } on Object catch (_) {
      // Silently fail or handling error depending on UX requirements
      emit(state.copyWith(isLoadingGames: false));
    }
  }

  void _onSearchGames(_SearchGames event, Emitter<PublishState> emit) {
    final query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(filteredGames: state.allGames));
    } else {
      final filtered = state.allGames.where((game) {
        return game.title.toLowerCase().contains(query);
      }).toList();
      emit(state.copyWith(filteredGames: filtered));
    }
  }

  Future<void> _onAddDeliveryMethod(
    _AddDeliveryMethod event,
    Emitter<PublishState> emit,
  ) async {
    // Optimistically add to list or show loading?
    // For now, let's just make the call and then update.
    // Ideally we should have a loading state for this specific action or generic.
    emit(state.copyWith(isSubmitting: true));

    try {
      final newMethod = await _createDeliveryMethod(event.method);
      final updatedMethods = [...state.availableDeliveryMethods, newMethod];
      final selectedMethods = [...state.deliveryMethods, newMethod];
      emit(
        state.copyWith(
          availableDeliveryMethods: updatedMethods,
          deliveryMethods: selectedMethods, // Auto-select new method
          isSubmitting: false,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Error al crear método de entrega: $e',
        ),
      );
    }
  }

  Future<void> _onGetDeliveryMethods(
    _GetDeliveryMethods event,
    Emitter<PublishState> emit,
  ) async {
    emit(state.copyWith(isLoadingDeliveryMethods: true));
    try {
      final methods = await _getDeliveryMethods();
      emit(
        state.copyWith(
          isLoadingDeliveryMethods: false,
          deliveryMethods: [], // Reset selection? Or default to all?
          // Let's default to empty so user chooses, or all.
          // User request: "Select methods". Usually explicit selection is better.
          // IF editing, we should keep existing. But this is fresh publish.
          // If we want to be nice, maybe pre-select all if it's the first load?
          // Let's keep selection empty or existing if re-entering step.
          // BUT if we reload, we might lose selection if we reset.
          // Better: keep state.deliveryMethods, just update available.

          availableDeliveryMethods: methods,
        ),
      );
    } on Object catch (_) {
      // Silently fail or handling error depending on UX requirements
      emit(state.copyWith(isLoadingDeliveryMethods: false));
    }
  }

  void _onToggleDeliveryMethod(
    _ToggleDeliveryMethod event,
    Emitter<PublishState> emit,
  ) {
    // Check if method is currently selected
    // We compare by ID assuming ID is unique and present.
    // If ID is null (optimistic?), use object equality or index? String ID is safe.
    final exists = state.deliveryMethods
        .any((m) => m.id == event.method.id && m.id != null);

    List<DeliveryMethod> updated;
    if (exists) {
      updated =
          state.deliveryMethods.where((m) => m.id != event.method.id).toList();
    } else {
      updated = [...state.deliveryMethods, event.method];
    }
    emit(state.copyWith(deliveryMethods: updated));
  }

  Future<void> _onPickMultipleImages(
    _PickMultipleImages event,
    Emitter<PublishState> emit,
  ) async {
    try {
      final imagePaths = await _imageUploadService.pickMultipleImages();
      if (imagePaths.isNotEmpty) {
        emit(state.copyWith(isUploadingImage: true));
        final imageUrls = await _imageUploadService.uploadImages(imagePaths);
        emit(
          state.copyWith(
            images: [...state.images, ...imageUrls],
            isUploadingImage: false,
          ),
        );
      }
    } on Object catch (e) {
      emit(
        state.copyWith(
          isUploadingImage: false,
          errorMessage: 'Error al subir imágenes: $e',
        ),
      );
    }
  }
}
