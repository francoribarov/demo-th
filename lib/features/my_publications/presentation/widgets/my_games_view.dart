import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/features/catalog/presentation/widgets/game_card.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/my_publications_bloc.dart';

class MyGamesView extends StatelessWidget {
  const MyGamesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyPublicationsBloc, MyPublicationsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (message) => Center(child: Text('Error: $message')),
          success: (games) {
            if (games.isEmpty) {
              return const Center(
                child: Text('No has publicado ningún juego.'),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: games.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final game = games[index];
                return GameCard(
                  game: game,
                  // TODO(FRAN): Add edit/delete actions if needed
                  onTap: () {
                    // Navigate to details or edit page
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
