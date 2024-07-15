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

    test('Source - Create', () async {
      var topic = (await client.topics.index(name: 'test')).first;
      var path = (await client.paths.index(content: 'test')).first;
      var providerType = (await client.providerTypes.index(name: 'test')).first;
      var supplier =
          (await client.suppliers.index(providerTypeId: providerType.id)).first;

      final search = await client.searches.index(
        topicId: topic.id,
        pathId: path.id,
        supplierId: supplier.id,
      );

      var source = await client.sources.store(
          link: Uri.parse(
              'https://test.test/${DateTime.now().millisecondsSinceEpoch}'),
          searchId: search.first.id,
          pathId: search.first.pathId,
          topicId: search.first.topicId,
          supplierId: search.first.supplierId);

      expect(source, isA<Source>());
      expect(source.link, isA<Uri>());
      expect(source.searchId, isA<int>());
      expect(source.pathId, isA<int>());
      expect(source.topicId, isA<int>());
      expect(source.supplierId, isA<int>());
      expect(source.id, isA<int>());
    });
  });

  tearDownAll(() async {});
}
