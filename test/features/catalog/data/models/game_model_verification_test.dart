import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_table_hopping/features/catalog/data/models/game_model.dart';

void main() {
  group('GameModel Deserialization', () {
    test('should correctly deserialize game with image objects', () {
      // JSON snippet from the user's error report
      const jsonString = '''
      {
        "id": 1,
        "title": "Catan",
        "description": "Un juego clásico...",
        "duration": 0,
        "players": "2-4 jugadores",
        "difficulty": "Medio",
        "rating": 4.8,
        "reviews": 156,
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
        "availability": [],
        "price": 100
      }
      ''';

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      final gameModel = GameModel.fromJson(jsonMap);

      expect(gameModel.id, '1');
      expect(gameModel.title, 'Catan');
      expect(gameModel.images, isA<List<GameImageModel>>());
      expect(gameModel.images.length, 1);
      expect(gameModel.images.first.url, 'https://example.com/image1.jpg');

      // Verify conversion to entity
      final entity = gameModel.toDomainModel();
      expect(entity.images, isA<List<String>>());
      expect(entity.images.length, 1);
      expect(entity.images.first, 'https://example.com/image1.jpg');
    });

    test(
      'should correctly deserialize game with null rules providing defaults',
      () {
        const jsonString = '''
      {
        "id": 2,
        "title": "Azul",
        "description": "Un juego...",
        "duration": 0,
        "players": "2-4 jugadores",
        "difficulty": "Medio",
        "rating": 4.8,
        "reviews": 10,
        "categories": [],
        "images": [],
        "price": 50,
        "rules": {
          "video_url": null,
          "rule_complete_url": null,
          "summary_rules": null
        }
      }
      ''';

        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        final gameModel = GameModel.fromJson(jsonMap);

        expect(gameModel.rules, isNotNull);
        expect(gameModel.rules?.videoUrl, '');
        expect(gameModel.rules?.ruleCompleteUrl, '');
        expect(gameModel.rules?.summaryRules, '');
      },
    );

    test(
      'should correctly deserialize game with null review fields providing defaults',
      () {
        const jsonString = '''
      {
        "id": 3,
        "title": "Catan",
        "description": "Un juego...",
        "duration": 0,
        "players": "2-4 jugadores",
        "difficulty": "Medio",
        "rating": 4.8,
        "reviews": 1,
        "categories": [],
        "images": [],
        "price": 45,
        "reviews_list": [
          {
            "user_id": null,
            "rating": null,
            "comment": null,
            "name": null
          }
        ]
      }
      ''';

        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        final gameModel = GameModel.fromJson(jsonMap);

        expect(gameModel.reviewsList.length, 1);
        expect(gameModel.reviewsList.first.userId, '');
        expect(gameModel.reviewsList.first.rating, 0.0);
        expect(gameModel.reviewsList.first.comment, '');
        expect(gameModel.reviewsList.first.name, isNull);
      },
    );

    test('should return null owner ID when owner_id is null', () {
      const jsonString = '''
      {
        "id": 1,
        "title": "Catan",
        "description": "...",
        "duration": 0,
        "players": "...",
        "difficulty": "...",
        "rating": 4.8,
        "reviews": 1,
        "categories": [],
        "images": [],
        "price": 45,
        "owner_id": null
      }
      ''';

      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      final gameModel = GameModel.fromJson(jsonMap);

      expect(gameModel.ownerId, isNull);
    });
  });
}
