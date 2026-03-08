import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_table_hopping/domain/usecase/rental/drop_off_rental_use_case.dart';
import 'package:mobile_table_hopping/domain/usecase/upload/upload_images_use_case.dart';
import 'package:mobile_table_hopping/presentation/gateway/image_picker_gateway.dart';

part 'drop_off_event.dart';
part 'drop_off_state.dart';
part 'drop_off_bloc.freezed.dart';

@injectable
class DropOffBloc extends Bloc<DropOffEvent, DropOffState> {
  DropOffBloc(
    this._gateway,
    this._dropOffRentalUseCase,
    this._uploadImagesUseCase,
  ) : super(DropOffState.initial()) {
    on<_Started>(_onStarted);
    on<_PickImage>(_onPickImage);
    on<_Submit>(_onSubmit);
  }

  final ImagePickerGateway _gateway;
  final DropOffRentalUseCase _dropOffRentalUseCase;
  final UploadImagesUseCase _uploadImagesUseCase;

  void _onStarted(_Started event, Emitter<DropOffState> emit) {
    emit(DropOffState.initial());
  }

  Future<void> _onPickImage(
    _PickImage event,
    Emitter<DropOffState> emit,
  ) async {
    final file = await _gateway.pickImageFromCamera();
    if (file == null) return;

    emit(
      state.copyWith(
        imagePath: file,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onSubmit(
    _Submit event,
    Emitter<DropOffState> emit,
  ) async {
    if (state.imagePath == null) {
      emit(state.copyWith(errorMessage: 'Debe seleccionar una imagen.'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final uploadResult = await _uploadImagesUseCase([state.imagePath!]);

    await uploadResult.fold(
      (error) async {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: 'Error al subir imagen: ${error.message}',
          ),
        );
      },
      (imageUrls) async {
        if (imageUrls.isEmpty) {
          emit(
            state.copyWith(
              isSubmitting: false,
              errorMessage: 'Error al obtener la imagen subida.',
            ),
          );
          return;
        }

        final result = await _dropOffRentalUseCase(
          event.rentalId,
          imageUrls.first,
        );

        result.fold(
          (error) {
            emit(
              state.copyWith(
                isSubmitting: false,
                errorMessage: error.message,
              ),
            );
          },
          (_) {
            emit(
              state.copyWith(
                isSubmitting: false,
                isSuccess: true,
              ),
            );
          },
        );
      },
    );
  }
}
