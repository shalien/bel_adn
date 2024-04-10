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

  group('Medias', () {

    test('Medias - Index', () async {
      final medias = await client.medias.index();
      expect(medias, isA<List<Media>>());
      expect(medias, isNotEmpty);
    });

    test('Medias - Index - Link', () async {

      final medias = await client.medias.index();

      final Media testMedia = medias.first;

      final retrievedMedias = await client.medias.index(link: testMedia.link);

      final retrievedMedia = retrievedMedias.first;

      expect(retrievedMedia, isA<Media>());
      expect(retrievedMedia.link, testMedia.link);
      expect(retrievedMedia.id, testMedia.id);
      expect(retrievedMedia.destinationId, testMedia.destinationId);
      expect(retrievedMedia.sourceId, testMedia.sourceId);
      expect(retrievedMedia.sha256, testMedia.sha256);
    });

    test('Medias - Index - source_id', () async {

      final medias = await client.medias.index();

      final Media testMedia = medias.first;

      final retrievedMedias = await client.medias.index(sourceId: testMedia.sourceId);

      final retrievedMedia = retrievedMedias.first;

      expect(retrievedMedia, isA<Media>());
      expect(retrievedMedia.link, testMedia.link);
      expect(retrievedMedia.id, testMedia.id);
      expect(retrievedMedia.destinationId, testMedia.destinationId);
      expect(retrievedMedia.sourceId, testMedia.sourceId);
      expect(retrievedMedia.sha256, testMedia.sha256);
    });

    test('Medias - Store - CopyWith', () async {
      final medias = await client.medias.index();
      final source = (await client.sources.index()).first;
      final destination = (await client.destinations.index()).first;

      final Media testMedia = medias.first;

      final newMedia = testMedia.copyWith(link: Uri.parse('https://new-${testMedia.link}-${DateTime.now().microsecondsSinceEpoch}'), sourceId: source.id,
          destinationId: destination.id, sha256: 'new-test-test');

      final createdMedia = await client.medias.store(newMedia);

      expect(createdMedia, isA<Media>());
      expect(createdMedia.link, newMedia.link);
      expect(createdMedia.sourceId, newMedia.sourceId);
      expect(createdMedia.destinationId, newMedia.destinationId);
      expect(createdMedia.sha256, newMedia.sha256);
    });

    test('Medias - Update', () async {
      final medias = await client.medias.index();
      final source = (await client.sources.index()).first;
      final destination = (await client.destinations.index()).first;

      final Media testMedia = medias.first;

      final newMedia = testMedia.copyWith(link: Uri.parse('https://new-${testMedia.link}-${DateTime.now().microsecondsSinceEpoch}'), sourceId: source.id,
          destinationId: destination.id, sha256: 'new-test-test');

      final updateMedia = await client.medias.update(testMedia.id!, newMedia);

      expect(updateMedia, isA<Media>());
      expect(updateMedia.link, newMedia.link);
      expect(updateMedia.sourceId, newMedia.sourceId);
      expect(updateMedia.destinationId, newMedia.destinationId);
      expect(updateMedia.sha256, newMedia.sha256);
    });

  });


}