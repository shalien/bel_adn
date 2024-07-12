import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  late MagnifiqueCoupleClient client;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Source CRUD', () {
    test('Source - Index', () async {
      final sources = await client.sources.index();

      expect(sources, isA<List<Source>>());
      expect(sources, isNotEmpty);
    });

    test('Source - Index - Link', () async {
      final sources = await client.sources.index();

      final Source testSource = sources.first;

      final retrievedSources =
          await client.sources.index(link: testSource.link);

      final retrievedSource = retrievedSources.first;

      expect(retrievedSource, isA<Source>());
      expect(retrievedSource.link, testSource.link);
      expect(retrievedSource.id, testSource.id);
      expect(retrievedSource.searchId, testSource.searchId);
      expect(retrievedSource.pathId, testSource.pathId);
      expect(retrievedSource.topicId, testSource.topicId);
      expect(retrievedSource.supplierId, testSource.supplierId);
    });
  });

  tearDownAll(() async {});
}
