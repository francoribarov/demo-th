import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_listing.dart';
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCreateListing extends Mock implements CreateListing {}

void main() {
  late MockCreateListing mockCreateListing;
  late PublishBloc publishBloc;

  setUp(() {
    mockCreateListing = MockCreateListing();
    publishBloc = PublishBloc(createListing: mockCreateListing);
  });

  tearDown(() async {
    await publishBloc.close();
  });

  group('PublishBloc', () {
    test('initial state should be PublishState', () {
      expect(publishBloc.state, const PublishState());
    });

    blocTest<PublishBloc, PublishState>(
      'updates title and canProceed status',
      build: () => publishBloc,
      act: (bloc) => bloc.add(const PublishEvent.titleChanged('Catan')),
      expect: () => [
        const PublishState(title: 'Catan'),
      ],
      verify: (bloc) {
        expect(bloc.state.canProceed, false); // No description yet
      },
    );

    blocTest<PublishBloc, PublishState>(
      'canProceed is true when basics are valid',
      build: () => publishBloc,
      act: (bloc) {
        bloc
          ..add(const PublishEvent.titleChanged('Catan'))
          ..add(const PublishEvent.descriptionChanged('A very long and descriptive text for the game.'));
      },
      skip: 1,
      expect: () => [
        const PublishState(
          title: 'Catan',
          description: 'A very long and descriptive text for the game.',
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.canProceed, true);
      },
    );
  });
}
