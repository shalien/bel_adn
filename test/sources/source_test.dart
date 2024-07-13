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
      final sources = await client.sources.index(link: Uri.parse('https://www.reddit.com/r/FreckledRedheads/comments/1e1lmer/feeling_cute_today_irtr/'));

      expect(sources, isA<List<Source>>());
      expect(sources, isEmpty);
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

    test('Create a source', () async {

      var search = await client.searches.index();

      final source = await client.sources.store(
        link: Uri.parse('https://jddgdflgdjlgjldgjlddsfkjfdgfgjf.fooee/oday_irtr/${DateTime.now()}'),
        pathId: search.first.pathId,
        topicId: search.first.topicId,
        supplierId: search.first.supplierId,
        searchId: search.first.id,
      );

      print(source);

    });

  });

  tearDownAll(() async {});
}
