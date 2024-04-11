import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  Search? createdSearch;
  Search? updatedSearch;

  Topic? testTopic;
  Path? testPath;
  Supplier? testSupplier;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Search - CRUD', () {
    test('Search - Index', () async {
      final searches = await client.searches.index();

      expect(searches, isA<List<Search>>());
      expect(searches, isNotEmpty);
    });

    test('Search - Index - Path', () async {
      final paths = await client.paths.index();
      final testPath = paths.first;

      final searches = await client.searches.index(pathId: testPath.id);

      expect(searches, isA<List<Search>>());
      expect(searches, isNotEmpty);
    });

    test('Search - Index - Topic', () async {
      final topics = await client.topics.index();
      final testTopic = topics.first;

      final searches = await client.searches.index(topicId: testTopic.id);

      expect(searches, isA<List<Search>>());
      expect(searches, isNotEmpty);
    });

    test('Search - Index - Supplier', () async {
      final suppliers = await client.suppliers.index();
      final testSupplier = suppliers.first;

      final searches = await client.searches.index(supplierId: testSupplier.id);

      expect(searches, isA<List<Search>>());
      expect(searches, isNotEmpty);
    });
  });

  tearDownAll(() async {});
}
