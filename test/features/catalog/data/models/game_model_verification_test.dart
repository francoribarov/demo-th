import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';

void main() {
  group('GameModel Deserialization', () {
    test('should correctly deserialize game with image objects and reviews',
        () {
      // JSON snippet updated to match current backend response structure
      const jsonString = '''
      {
        "id": "1",
        "title": "Catan",
        "description": "Un juego clásico...",
        "duration": 60,
        "players": "2-4 jugadores",
        "difficulty": "Medio",
        "rating": 4.8,
        "reviews": [
          {
            "id": "r1",
            "username": "User1",
            "rating": 5.0,
            "comment": "Great game!"
          }
        ],
        "categories": [
          {
            "id": 4,
            "name": "Estrategia",
            "icon": "♟️",
            "query": "Estrategia",
            "description": "Planificá a fondo..."
          }
        ],
        "images": [
          {
            "url": "https://example.com/image1.jpg"
          }
        ],
        "rules": {
           "video_url": "http://video",
           "rule_complete_url": "http://rules",
           "summary_rules": "summary"
        }
      }
      ''';

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      final gameModel = GameModel.fromJson(jsonMap);

      expect(gameModel.id, '1');
      expect(gameModel.title, 'Catan');
      expect(gameModel.images, isA<List<GameImageModel>>());
      expect(gameModel.images.length, 1);
      expect(gameModel.images.first.url, 'https://example.com/image1.jpg');

      expect(gameModel.reviews, isA<List<GameReviewModel>>());
      expect(gameModel.reviews.length, 1);
      expect(gameModel.reviews.first.comment, 'Great game!');

      // Verify conversion to entity
      final entity = gameModel.toDomainModel();
      expect(entity.images, isA<List<String>>());
      expect(entity.images.length, 1);
      expect(entity.images.first, 'https://example.com/image1.jpg');
      expect(entity.reviewsCount, 1);
      expect(entity.reviews.first.comment, 'Great game!');
    });

    test(
      'should correctly deserialize game with null rules providing defaults',
      () {
        const jsonString = '''
      {
        "id": "2",
        "title": "Azul",
        "description": "Un juego...",
        "duration": 0,
        "categories": [],
        "images": [],
        "reviews": [],
        "rules": null
      }
      ''';

        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        final gameModel = GameModel.fromJson(jsonMap);

        // rules field is default to empty model if null in json?
        // Actually, Freezed handles null if we make it nullable or provide logic,
        // but currently rules is Default(GameRulesModel()).
        // Let's see if fromJson handles nested nulls gracefully with defaults.
        // Since it's not nullable in the constructor but has a Default, keys missing will use default.
        // If "rules": null is passed, it might crash if not nullable.
        // Let's assume the backend might send null or omit it.
        // The test above used "rules": {... nulls ...}.

        expect(gameModel.rules.videoUrl, '');
      },
    );
  });
}
