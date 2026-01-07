import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/publish/domain/usecases/create_publication.dart';
import 'package:mobile_table_hopping/features/publish/presentation/bloc/publish_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCreatePublication extends Mock implements CreatePublication {}

void main() {
  late MockCreatePublication mockCreatePublication;
  late PublishBloc publishBloc;

  setUp(() {
    mockCreatePublication = MockCreatePublication();
    publishBloc = PublishBloc(createPublication: mockCreatePublication);
  });

  tearDown(() async {
    await publishBloc.close();
  });

  group('PublishBloc', () {
    test('initial state should be PublishState', () {
      expect(publishBloc.state, const PublishState());
    });

    blocTest<PublishBloc, PublishState>(
      'updates gameId and canProceed status',
      build: () => publishBloc,
      act: (bloc) => bloc.add(const PublishEvent.gameIdChanged(123)),
      expect: () => [
        const PublishState(gameId: 123),
      ],
      verify: (bloc) {
        expect(bloc.state.canProceed, false); // No description/price yet
      },
    );

    blocTest<PublishBloc, PublishState>(
      'canProceed is true when basics are valid',
      build: () => publishBloc,
      act: (bloc) {
        bloc
          ..add(const PublishEvent.gameIdChanged(123))
          ..add(const PublishEvent.descriptionChanged('A very long and descriptive text for the game.'))
          ..add(const PublishEvent.priceChanged(100));
      },
      skip: 2,
      expect: () => [
        const PublishState(
          gameId: 123,
          description: 'A very long and descriptive text for the game.',
          price: 100,
        ),
      ],
      verify: (bloc) {
        expect(bloc.state.canProceed, true);
      },
    );
  });
}
