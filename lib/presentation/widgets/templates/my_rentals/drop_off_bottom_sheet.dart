import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/presentation/blocs/rental/drop_off_bloc/drop_off_bloc.dart';

Future<bool?> showDropOffBottomSheet(BuildContext context, String rentalId) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => BlocProvider(
      create: (context) => getIt<DropOffBloc>(),
      child: _DropOffContent(rentalId: rentalId),
    ),
  );
}

class _DropOffContent extends StatelessWidget {
  const _DropOffContent({required this.rentalId});

  final String rentalId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DropOffBloc, DropOffState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pop(); // Close sheet
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Devolver juego',
              style: AppTypography.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Para finalizar el alquiler, sacá una foto de dónde estás depositando el juego.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            BlocBuilder<DropOffBloc, DropOffState>(
              builder: (context, state) {
                return _ImagePickerArea(
                  imagePath: state.imagePath,
                  onPick: () => context.read<DropOffBloc>().add(
                    const DropOffEvent.pickImage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            BlocBuilder<DropOffBloc, DropOffState>(
              builder: (context, state) {
                return FilledButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          context.read<DropOffBloc>().add(
                            DropOffEvent.submit(rentalId),
                          );
                        },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.gameRust,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: state.isSubmitting
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Confirmar devolución'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePickerArea extends StatelessWidget {
  const _ImagePickerArea({
    required this.imagePath,
    required this.onPick,
  });

  final String? imagePath;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return GestureDetector(
        onTap: onPick,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: FileImage(File(imagePath!)),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withValues(alpha: 0.3),
            ),
            child: const Center(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 48,
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onPick,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.gameBrown.withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: 48,
              color: AppColors.gameBrown.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 12),
            Text(
              'Tomar foto',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.gameBrown,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
