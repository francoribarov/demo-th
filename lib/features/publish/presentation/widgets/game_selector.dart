import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/core/di/injection.dart';
import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/bloc/catalog_bloc.dart';

/// Widget to search and select a game from the catalog.
class GameSelector extends StatefulWidget {
  /// Creates a [GameSelector].
  const GameSelector({
    required this.selectedGameId,
    required this.onGameSelected,
    super.key,
  });

  /// The currently selected game ID.
  final String? selectedGameId;

  /// Callback when a game is selected.
  final ValueChanged<Game> onGameSelected;

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
    return BlocProvider(
      create: (_) => getIt<CatalogBloc>()..add(const CatalogEvent.loadGames()),
      child: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          final selectedGame = state.allGames.where((g) => g.id == widget.selectedGameId).firstOrNull;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selectedGame != null) ...[
                _SelectedGameCard(
                  game: selectedGame,
                  onClear: () {
                    context.read<CatalogBloc>().add(const CatalogEvent.clearSearch());
                    _searchController.clear();
                    // We can't clear the parent state easily without a clear callback or passing null,
                    // but the parent expects a Game object.
                    // Ideally we should have onClear or allow null in onGameSelected.
                    // For now, let's just show the search field again.
                    // Actually, if selectedGameId is not null, we show the card.
                    // If the user wants to change, they tap "Change".
                  },
                  onChange: () {
                    // Just focus the search to show results again?
                    // Or maybe we need a callback to clear selection in parent.
                    // The requirement is to select a game.
                    // Let's assume onGameSelected handles new selection.
                    setState(() {
                      _showResults = true;
                    });
                    _focusNode.requestFocus();
                  },
                ),
                const SizedBox(height: 16),
              ],

              if (selectedGame == null || _showResults)
                Column(
                  children: [
                    TextFormField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        labelText: 'Buscar juego',
                        hintText: 'Escribí el nombre del juego...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  context.read<CatalogBloc>().add(const CatalogEvent.search(query: ''));
                                },
                              )
                            : null,
                      ),
                      onChanged: (value) {
                        context.read<CatalogBloc>().add(CatalogEvent.search(query: value));
                        setState(() {
                          _showResults = true;
                        });
                      },
                    ),
                    if (_showResults && state.filteredGames.isNotEmpty)
                      Container(
                        constraints: const BoxConstraints(maxHeight: 300),
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacityValue(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: state.filteredGames.length,
                          separatorBuilder: (_, sepIndex) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final game = state.filteredGames[index];
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: CachedNetworkImage(
                                  imageUrl: game.images.isNotEmpty ? game.images.first : '',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  placeholder: (_, url) => const ColoredBox(color: AppColors.gameCream),
                                  errorWidget: (_, url, error) => const Icon(Icons.image_not_supported),
                                ),
                              ),
                              title: Text(game.title, style: AppTypography.bodyMedium),
                              subtitle: Text(
                                '${game.duration} min • ${game.players}',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.gameBrown.withOpacityValue(0.7),
                                ),
                              ),
                              onTap: () {
                                widget.onGameSelected(game);
                                _searchController.text = ''; // Clear search
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
                ),
            ],
          );
        },
      ),
    );
  }
}

class _SelectedGameCard extends StatelessWidget {
  const _SelectedGameCard({required this.game, required this.onClear, required this.onChange});

  final Game game;
  final VoidCallback onClear;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gameCream.withOpacityValue(0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppColors.gameRust.withOpacityValue(0.3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: game.images.isNotEmpty ? game.images.first : '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (_, url) => const ColoredBox(color: AppColors.gameCream),
              errorWidget: (_, url, error) => const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game.title, style: AppTypography.titleMedium),
                Text(
                  'Juego seleccionado',
                  style: AppTypography.labelSmall.copyWith(color: AppColors.gameRust),
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
