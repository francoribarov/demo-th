import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/bloc/rental_requests_bloc.dart';
import 'package:mobile_table_hopping/features/my_publications/presentation/widgets/rental_request_card.dart';

class MyPublicationsPage extends StatelessWidget {
  const MyPublicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Publicaciones'),
      ),
      body: BlocBuilder<RentalRequestsBloc, RentalRequestsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            failure: (message) => Center(child: Text('Error: $message')),
            success: (requests) {
              if (requests.isEmpty) {
                return const Center(
                  child: Text('No se encontraron solicitudes de alquiler.'),
                );
              }
              return ListView.builder(
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index];
                  return RentalRequestCard(
                    request: request,
                    onAccept: () {
                      context.read<RentalRequestsBloc>().add(
                        RentalRequestsEvent.accepted(request.id),
                      );
                    },
                    onReject: () {
                      context.read<RentalRequestsBloc>().add(
                        RentalRequestsEvent.rejected(request.id),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
