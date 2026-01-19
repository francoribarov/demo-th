import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_table_hopping/core/theme/app_colors.dart';
import 'package:mobile_table_hopping/core/theme/app_theme.dart';
import 'package:mobile_table_hopping/core/theme/app_typography.dart';
import 'package:mobile_table_hopping/features/catalog/domain/entities/game.dart';
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart';

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
    // We assume PublishBloc is provided by the parent page
    return BlocBuilder<PublishBloc, PublishState>(
      builder: (context, state) {
        final selectedGame = state.allGames
            .where((g) => g.id == widget.selectedGameId)
            .firstOrNull;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedGame != null) ...[
              _SelectedGameCard(
                game: selectedGame,
                onClear: () {
                  context
                      .read<PublishBloc>()
                      .add(const PublishEvent.searchGames('')); // Reset search
                  _searchController.clear();
                  // Ideally notify parent to clear selection, but current contract
                  // onGameSelected requires a Game. Parent handles logic.
                  // For now, focusing search usually implies re-selecting.
                },
                onChange: () {
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
                                context.read<PublishBloc>().add(
                                      const PublishEvent.searchGames(''),
                                    );
                              },
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      context
                          .read<PublishBloc>()
                          .add(PublishEvent.searchGames(value));
                      setState(() {
                        _showResults = true;
                      });
                    },
                    onTap: () {
                      if (!_showResults) {
                        setState(() {
                          _showResults = true;
                        });
                        context.read<PublishBloc>().add(
                              const PublishEvent.searchGames(''),
                            );
                      }
                    },
                  ),
                  if (_showResults)
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.isLoadingGames)
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          else if (state.filteredGames.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'No se encontraron juegos',
                                style: AppTypography.bodyMedium.copyWith(
                                  color:
                                      AppColors.gameBrown.withOpacityValue(0.7),
                                ),
                              ),
                            )
                          else ...[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
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
                                itemCount: state.filteredGames.length,
                                separatorBuilder: (_, sepIndex) =>
                                    const Divider(height: 1),
                                itemBuilder: (context, index) {
                                  final game = state.filteredGames[index];
                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: CachedNetworkImage(
                                        imageUrl: game.images.isNotEmpty
                                            ? game.images.first
                                            : '',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                        placeholder: (_, url) =>
                                            const ColoredBox(
                                          color: AppColors.gameCream,
                                        ),
                                        errorWidget: (_, url, error) =>
                                            const Icon(
                                                Icons.image_not_supported),
                                      ),
                                    ),
                                    title: Text(
                                      game.title,
                                      style: AppTypography.bodyMedium,
                                    ),
                                    subtitle: Text(
                                      '${game.duration} min • ${game.players}',
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.gameBrown
                                            .withOpacityValue(0.7),
                                      ),
                                    ),
                                    onTap: () {
                                      widget.onGameSelected(game);
                                      _searchController.text = '';
                                      context.read<PublishBloc>().add(
                                            const PublishEvent.searchGames(''),
                                          );
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
      },
    );
  }
}

class _SelectedGameCard extends StatelessWidget {
  const _SelectedGameCard({
    required this.game,
    required this.onClear,
    required this.onChange,
  });

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
              placeholder: (_, url) =>
                  const ColoredBox(color: AppColors.gameCream),
              errorWidget: (_, url, error) =>
                  const Icon(Icons.image_not_supported),
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
                  style: AppTypography.labelSmall
                      .copyWith(color: AppColors.gameRust),
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
