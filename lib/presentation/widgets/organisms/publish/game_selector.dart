import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/domain/model/catalog/game.dart';
import 'package:mobile_table_hopping/presentation/widgets/atoms/atoms.dart';
import 'package:mobile_table_hopping/presentation/widgets/molecules/common/search_input_field.dart';

/// Widget to search and select a game from the catalog.
class GameSelector extends StatefulWidget {
  /// Creates a [GameSelector].
  const GameSelector({
    required this.selectedGameId,
    required this.allGames,
    required this.filteredGames,
    required this.isLoadingGames,
    required this.onSearchChanged,
    required this.onSearchCleared,
    required this.onGameSelected,
    this.onCreateGamePressed,
    super.key,
  });

  /// The currently selected game ID.
  final String? selectedGameId;
  final List<Game> allGames;
  final List<Game> filteredGames;
  final bool isLoadingGames;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;

  /// Callback when a game is selected.
  final ValueChanged<Game> onGameSelected;

  /// Callback to open the create-game flow.
  final VoidCallback? onCreateGamePressed;

  @override
  State<GameSelector> createState() => _GameSelectorState();
}

class _GameSelectorState extends State<GameSelector> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _showResults = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedGame = widget.allGames
        .where((g) => g.id == widget.selectedGameId)
        .firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedGame != null) ...[
          _SelectedGameCard(
            game: selectedGame,
            onChange: () {
              setState(() {
                _showResults = true;
              });
              _focusNode.requestFocus();
            },
          ),
          const SizedBox(height: AppTheme.spacingLg),
        ],
        if (selectedGame == null || _showResults)
          Column(
            children: [
              SearchInputField(
                controller: _searchController,
                focusNode: _focusNode,
                labelText: 'Buscar juego',
                hintText: 'Escribí el nombre del juego...',
                onClear: () {
                  _searchController.clear();
                  widget.onSearchCleared();
                  setState(() {});
                },
                onChanged: (value) {
                  widget.onSearchChanged(value);
                  setState(() {
                    _showResults = true;
                  });
                },
                onTap: () {
                  if (!_showResults) {
                    setState(() {
                      _showResults = true;
                    });
                    widget.onSearchCleared();
                  }
                },
                onSubmitted: (_) => _focusNode.unfocus(),
              ),
              if (_showResults)
                Container(
                  constraints: const BoxConstraints(maxHeight: 300),
                  margin: const EdgeInsets.only(top: AppTheme.spacingSm),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    boxShadow: AppTheme.shadowMd,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.isLoadingGames)
                        const Padding(
                          padding: EdgeInsets.all(AppTheme.spacingLg),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (widget.filteredGames.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(AppTheme.spacingLg),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.search_off_rounded,
                                size: 32,
                                color: AppColors.textTertiary,
                              ),
                              const SizedBox(height: AppTheme.spacingSm),
                              Text(
                                'No se encontraron juegos',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                              if (widget.onCreateGamePressed != null) ...[
                                const SizedBox(height: AppTheme.spacingMd),
                                Text(
                                  '¿No encontrás tu juego?',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacingSm),
                                TextButton.icon(
                                  onPressed: () {
                                    _focusNode.unfocus();
                                    setState(() => _showResults = false);
                                    widget.onCreateGamePressed!();
                                  },
                                  icon: const Icon(Icons.add_circle_outline),
                                  label: const Text('Crear juego nuevo'),
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.gameRust,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      else ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            AppTheme.spacingLg,
                            AppTheme.spacingMd,
                            AppTheme.spacingLg,
                            AppTheme.spacingXs,
                          ),
                          child: Text(
                            _searchController.text.isEmpty
                                ? 'Sugerencias'
                                : 'Resultados',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.gameRust,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: widget.filteredGames.length,
                            separatorBuilder: (context, index) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final game = widget.filteredGames[index];
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusXs,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: game.images.isNotEmpty
                                        ? game.images.first
                                        : '',
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const ColoredBox(
                                          color: AppColors.gameCream,
                                        ),
                                    errorWidget: (context, url, error) =>
                                        const MediaPlaceholder(
                                          icon: Icons.image_not_supported,
                                          backgroundColor: AppColors.gameCream,
                                          iconColor: AppColors.gameBrown,
                                        ),
                                  ),
                                ),
                                title: Text(
                                  game.title,
                                  style: AppTypography.bodyMedium,
                                ),
                                subtitle: Text(
                                  '${game.duration} min • ${game.players}',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.gameBrown.withOpacityValue(
                                      0.7,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  widget.onGameSelected(game);
                                  _searchController.clear();
                                  widget.onSearchCleared();
                                  setState(() {
                                    _showResults = false;
                                  });
                                  _focusNode.unfocus();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _SelectedGameCard extends StatelessWidget {
  const _SelectedGameCard({
    required this.game,
    required this.onChange,
  });

  final Game game;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      variant: SurfaceCardVariant.subtle,
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      borderColor: AppColors.gameRust.withOpacityValue(0.3),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            child: CachedNetworkImage(
              imageUrl: game.images.isNotEmpty ? game.images.first : '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (_, url) =>
                  const ColoredBox(color: AppColors.gameCream),
              errorWidget: (_, url, error) => const MediaPlaceholder(
                icon: Icons.image_not_supported,
                backgroundColor: AppColors.gameCream,
                iconColor: AppColors.gameBrown,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game.title, style: AppTypography.titleMedium),
                Text(
                  'Juego seleccionado',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.gameRust,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onChange,
            child: const Text('Cambiar'),
          ),
        ],
      ),
    );
  }
}
