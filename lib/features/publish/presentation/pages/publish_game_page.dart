import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/core/utils/formatters.dart';
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart';

/// Publish game page matching PublishGame.tsx wizard.
class PublishGamePage extends StatelessWidget {
  /// Creates the publish game page.
  const PublishGamePage({super.key});

  static const _categories = ['Estrategia', 'Cooperativo', 'Familiar', 'Fiesta', 'Experto', 'Abstracto'];

  static const _difficulties = ['Fácil', 'Medio', 'Difícil', 'Experto'];
  static const _conditions = [
    ('new', 'Nuevo', 'Sellado o usado una vez'),
    ('like_new', 'Como nuevo', 'Excelente estado, sin marcas'),
    ('good', 'Buen estado', 'Uso normal, todo completo'),
    ('fair', 'Aceptable', 'Desgaste visible pero funcional'),
    ('worn', 'Usado', 'Muy jugado, puede faltar algo'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublishBloc, PublishState>(
      builder: (context, state) {
        if (state.success) {
          return _SuccessView(
            title: state.title,
            onBackHome: () => context.go('/'),
            onPublishAnother: () => context.read<PublishBloc>().add(const PublishEvent.publishAnother()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Publicar juego'),
            leading: IconButton(icon: const Icon(Icons.close), onPressed: () => context.go('/')),
          ),
          body: Column(
            children: [
              // Progress indicator
              _StepIndicator(currentStep: state.currentStep, steps: const ['Datos', 'Fotos', 'Precio', 'Revisión']),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: IndexedStack(
                    index: state.currentStep,
                    children: [
                      _DataStep(
                        formVersion: state.formVersion,
                        title: state.title,
                        publisher: state.publisher,
                        category: state.category,
                        description: state.description,
                        duration: state.duration,
                        players: state.players,
                        difficulty: state.difficulty,
                        categories: _categories,
                        difficulties: _difficulties,
                        onTitleChanged: (v) => context.read<PublishBloc>().add(PublishEvent.titleChanged(v)),
                        onPublisherChanged: (v) => context.read<PublishBloc>().add(PublishEvent.publisherChanged(v)),
                        onCategoryChanged: (v) => context.read<PublishBloc>().add(PublishEvent.categoryChanged(v)),
                        onDescriptionChanged: (v) =>
                            context.read<PublishBloc>().add(PublishEvent.descriptionChanged(v)),
                        onDurationChanged: (v) => context.read<PublishBloc>().add(PublishEvent.durationChanged(v)),
                        onPlayersChanged: (v) => context.read<PublishBloc>().add(PublishEvent.playersChanged(v)),
                        onDifficultyChanged: (v) => context.read<PublishBloc>().add(PublishEvent.difficultyChanged(v)),
                      ),
                      _PhotosStep(
                        images: state.images,
                        onImagesChanged: (v) => context.read<PublishBloc>().add(PublishEvent.imagesChanged(v)),
                      ),
                      _PriceStep(
                        formVersion: state.formVersion,
                        pricePerDay: state.pricePerDay,
                        deposit: state.deposit,
                        condition: state.condition,
                        visibility: state.visibility,
                        conditions: _conditions,
                        onPriceChanged: (v) => context.read<PublishBloc>().add(PublishEvent.pricePerDayChanged(v)),
                        onDepositChanged: (v) => context.read<PublishBloc>().add(PublishEvent.depositChanged(v)),
                        onConditionChanged: (v) => context.read<PublishBloc>().add(PublishEvent.conditionChanged(v)),
                        onVisibilityChanged: (v) => context.read<PublishBloc>().add(PublishEvent.visibilityChanged(v)),
                      ),
                      _ReviewStep(
                        title: state.title,
                        publisher: state.publisher,
                        category: state.category,
                        description: state.description,
                        duration: state.duration,
                        players: state.players,
                        difficulty: state.difficulty,
                        pricePerDay: state.pricePerDay,
                        deposit: state.deposit,
                        condition: state.condition,
                        visibility: state.visibility,
                        images: state.images,
                        conditions: _conditions,
                      ),
                    ],
                  ),
                ),
              ),

              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    state.errorMessage!,
                    style: AppTypography.bodySmall.copyWith(color: AppColors.destructive, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Navigation buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  border: Border(top: BorderSide(color: AppColors.gameBrown.withOpacityValue(0.1))),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      if (state.currentStep > 0)
                        Expanded(
                          child: OutlinedButton(
                            onPressed: state.isSubmitting
                                ? null
                                : () => context.read<PublishBloc>().add(const PublishEvent.previousStep()),
                            child: const Text('Anterior'),
                          ),
                        ),
                      if (state.currentStep > 0) const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: (!state.canProceed || state.isSubmitting)
                              ? null
                              : () => context.read<PublishBloc>().add(const PublishEvent.nextStep()),
                          child: state.isSubmitting
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : Text(state.currentStep == 3 ? 'Publicar' : 'Siguiente'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep, required this.steps});
  final int currentStep;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: AppColors.gameCream.withOpacityValue(0.5)),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Expanded(
              child: Container(
                height: 2,
                color: index ~/ 2 < currentStep ? AppColors.gameRust : AppColors.gameBrown.withOpacityValue(0.2),
              ),
            );
          }

          final stepIndex = index ~/ 2;
          final isActive = stepIndex <= currentStep;
          // isCurrent could be used for additional styling if needed
          // final isCurrent = stepIndex == currentStep;

          return Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: isActive ? AppColors.gameRust : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? AppColors.gameRust : AppColors.gameBrown.withOpacityValue(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '${stepIndex + 1}',
                style: AppTypography.labelMedium.copyWith(color: isActive ? Colors.white : AppColors.gameBrown),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _DataStep extends StatelessWidget {
  const _DataStep({
    required this.formVersion,
    required this.title,
    required this.publisher,
    required this.category,
    required this.description,
    required this.duration,
    required this.players,
    required this.difficulty,
    required this.categories,
    required this.difficulties,
    required this.onTitleChanged,
    required this.onPublisherChanged,
    required this.onCategoryChanged,
    required this.onDescriptionChanged,
    required this.onDurationChanged,
    required this.onPlayersChanged,
    required this.onDifficultyChanged,
  });
  final int formVersion;
  final String title;
  final String publisher;
  final String category;
  final String description;
  final String duration;
  final String players;
  final String difficulty;
  final List<String> categories;
  final List<String> difficulties;
  final void Function(String) onTitleChanged;
  final void Function(String) onPublisherChanged;
  final void Function(String) onCategoryChanged;
  final void Function(String) onDescriptionChanged;
  final void Function(String) onDurationChanged;
  final void Function(String) onPlayersChanged;
  final void Function(String) onDifficultyChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Datos del juego', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Contanos sobre el juego que querés publicar',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Title
        TextFormField(
          key: ValueKey('publish_title_$formVersion'),
          initialValue: title,
          decoration: const InputDecoration(labelText: 'Nombre del juego *', hintText: 'Ej: Catan, Pandemic, Azul...'),
          onChanged: onTitleChanged,
        ),
        const SizedBox(height: 16),

        // Publisher
        TextFormField(
          key: ValueKey('publish_publisher_$formVersion'),
          initialValue: publisher,
          decoration: const InputDecoration(labelText: 'Editorial', hintText: 'Ej: Devir, Z-Man Games...'),
          onChanged: onPublisherChanged,
        ),
        const SizedBox(height: 16),

        // Category
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Categoría'),
          initialValue: category,
          items: categories.map((c) {
            return DropdownMenuItem(value: c, child: Text(c));
          }).toList(),
          onChanged: (v) => onCategoryChanged(v ?? category),
        ),
        const SizedBox(height: 16),

        // Description
        TextFormField(
          key: ValueKey('publish_description_$formVersion'),
          initialValue: description,
          decoration: const InputDecoration(
            labelText: 'Descripción *',
            hintText: 'Contá de qué trata el juego...',
            alignLabelWithHint: true,
          ),
          maxLines: 4,
          onChanged: onDescriptionChanged,
        ),
        const SizedBox(height: 24),

        Text('Detalles técnicos', style: AppTypography.titleMedium),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                key: ValueKey('publish_duration_$formVersion'),
                initialValue: duration,
                decoration: const InputDecoration(labelText: 'Duración', hintText: '60-90 min'),
                onChanged: onDurationChanged,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                key: ValueKey('publish_players_$formVersion'),
                initialValue: players,
                decoration: const InputDecoration(labelText: 'Jugadores', hintText: '2-4'),
                onChanged: onPlayersChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Dificultad'),
          initialValue: difficulty,
          items: difficulties.map((d) {
            return DropdownMenuItem(value: d, child: Text(d));
          }).toList(),
          onChanged: (v) => onDifficultyChanged(v ?? difficulty),
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}

class _PhotosStep extends StatelessWidget {
  const _PhotosStep({required this.images, required this.onImagesChanged});
  final List<String> images;
  final void Function(List<String>) onImagesChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fotos', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Agregá fotos del juego para que los inquilinos lo vean',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Photo upload placeholder
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Carga de imágenes próximamente')));
          },
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.gameCream.withOpacityValue(0.5),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.3)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_photo_alternate_outlined, size: 48, color: AppColors.gameBrown.withOpacityValue(0.5)),
                const SizedBox(height: 16),
                Text(
                  'Tocá para agregar fotos',
                  style: AppTypography.bodyMedium.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                ),
                const SizedBox(height: 4),
                Text(
                  'La primera foto será la portada',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.5)),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: Colors.amber[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Las publicaciones con fotos de calidad tienen 3x más reservas',
                  style: AppTypography.bodySmall.copyWith(color: Colors.amber[900]),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}

class _PriceStep extends StatelessWidget {
  const _PriceStep({
    required this.formVersion,
    required this.pricePerDay,
    required this.deposit,
    required this.condition,
    required this.visibility,
    required this.conditions,
    required this.onPriceChanged,
    required this.onDepositChanged,
    required this.onConditionChanged,
    required this.onVisibilityChanged,
  });
  final int formVersion;
  final int pricePerDay;
  final int deposit;
  final String condition;
  final String visibility;
  final List<(String, String, String)> conditions;
  final void Function(int) onPriceChanged;
  final void Function(int) onDepositChanged;
  final void Function(String) onConditionChanged;
  final void Function(String) onVisibilityChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Precio y condición', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Definí el precio de alquiler y el estado del juego',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Condition
        Text('Estado del juego', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        ...conditions.map((c) {
          final isSelected = condition == c.$1;
          return GestureDetector(
            onTap: () => onConditionChanged(c.$1),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.gameCream : AppColors.card,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(
                  color: isSelected ? AppColors.gameRust : AppColors.gameBrown.withOpacityValue(0.2),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.$2, style: AppTypography.titleSmall),
                        Text(
                          c.$3,
                          style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected) const Icon(Icons.check_circle, color: AppColors.gameRust),
                ],
              ),
            ),
          );
        }),

        const SizedBox(height: 24),

        // Price
        Text('Precio por día (UYU)', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        TextFormField(
          key: ValueKey('publish_price_$formVersion'),
          initialValue: pricePerDay.toString(),
          decoration: const InputDecoration(prefixText: r'$ ', hintText: '50'),
          keyboardType: TextInputType.number,
          onChanged: (v) => onPriceChanged(int.tryParse(v) ?? pricePerDay),
        ),

        const SizedBox(height: 16),

        // Deposit
        Text('Depósito de garantía (UYU)', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        TextFormField(
          key: ValueKey('publish_deposit_$formVersion'),
          initialValue: deposit.toString(),
          decoration: const InputDecoration(prefixText: r'$ ', hintText: '500'),
          keyboardType: TextInputType.number,
          onChanged: (v) => onDepositChanged(int.tryParse(v) ?? deposit),
        ),

        const SizedBox(height: 24),

        // Visibility
        Text('Visibilidad', style: AppTypography.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onVisibilityChanged('public'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: visibility == 'public' ? AppColors.gameCream : AppColors.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(
                      color: visibility == 'public' ? AppColors.gameRust : AppColors.gameBrown.withOpacityValue(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.public, color: visibility == 'public' ? AppColors.gameRust : AppColors.gameBrown),
                      const SizedBox(height: 8),
                      Text('Público', style: AppTypography.labelMedium),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () => onVisibilityChanged('private'),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: visibility == 'private' ? AppColors.gameCream : AppColors.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(
                      color: visibility == 'private' ? AppColors.gameRust : AppColors.gameBrown.withOpacityValue(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.lock, color: visibility == 'private' ? AppColors.gameRust : AppColors.gameBrown),
                      const SizedBox(height: 8),
                      Text('Privado', style: AppTypography.labelMedium),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}

class _ReviewStep extends StatelessWidget {
  const _ReviewStep({
    required this.title,
    required this.publisher,
    required this.category,
    required this.description,
    required this.duration,
    required this.players,
    required this.difficulty,
    required this.pricePerDay,
    required this.deposit,
    required this.condition,
    required this.visibility,
    required this.images,
    required this.conditions,
  });
  final String title;
  final String publisher;
  final String category;
  final String description;
  final String duration;
  final String players;
  final String difficulty;
  final int pricePerDay;
  final int deposit;
  final String condition;
  final String visibility;
  final List<String> images;
  final List<(String, String, String)> conditions;

  @override
  Widget build(BuildContext context) {
    final conditionLabel = conditions.firstWhere((c) => c.$1 == condition, orElse: () => ('', condition, '')).$2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Revisión', style: AppTypography.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Revisá que todo esté correcto antes de publicar',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
        ),
        const SizedBox(height: 24),

        // Preview card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: AppColors.gameBrown.withOpacityValue(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.gameCream,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: const Center(child: Icon(Icons.image, size: 48, color: AppColors.gameBrown)),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.gameCream,
                      borderRadius: BorderRadius.circular(AppTheme.radius2xl),
                    ),
                    child: Text(category, style: AppTypography.categoryChip),
                  ),
                  Text(visibility == 'public' ? '🌍 Público' : '🔒 Privado', style: AppTypography.labelSmall),
                ],
              ),
              const SizedBox(height: 12),
              Text(title.isEmpty ? 'Sin título' : title, style: AppTypography.headlineMedium),
              if (publisher.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  publisher,
                  style: AppTypography.bodySmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                description.isEmpty ? 'Sin descripción' : description,
                style: AppTypography.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  if (duration.isNotEmpty) _InfoChip(icon: Icons.timer, label: duration),
                  if (players.isNotEmpty) _InfoChip(icon: Icons.people, label: players),
                  _InfoChip(icon: Icons.psychology, label: difficulty),
                  _InfoChip(icon: Icons.grade, label: conditionLabel),
                ],
              ),
              const Divider(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Precio por día',
                        style: AppTypography.labelSmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.6)),
                      ),
                      Text(CurrencyFormatter.formatUYU(pricePerDay), style: AppTypography.price),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Depósito',
                        style: AppTypography.labelSmall.copyWith(color: AppColors.gameBrown.withOpacityValue(0.6)),
                      ),
                      Text(CurrencyFormatter.formatUYU(deposit), style: AppTypography.titleMedium),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.gameBrown),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.labelSmall),
      ],
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.title, required this.onBackHome, required this.onPublishAnother});
  final String title;
  final VoidCallback onBackHome;
  final VoidCallback onPublishAnother;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(color: Colors.green[50], shape: BoxShape.circle),
                child: Icon(Icons.check_circle, size: 64, color: Colors.green[600]),
              ),
              const SizedBox(height: 32),
              Text('¡Juego publicado!', style: AppTypography.displaySmall, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text(
                'Tu juego "$title" ya está disponible para alquilar.',
                style: AppTypography.bodyLarge.copyWith(color: AppColors.gameBrown.withOpacityValue(0.7)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: onBackHome,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
                child: const Text('Volver al inicio'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onPublishAnother,
                style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
                child: const Text('Publicar otro juego'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
