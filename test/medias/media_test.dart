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

      final retrievedMedias =
          await client.medias.index(sourceId: testMedia.sourceId);

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

      final newMedia = testMedia.copyWith(
          link: Uri.parse(
              'https://new-${testMedia.link}-${DateTime.now().microsecondsSinceEpoch}'),
          sourceId: source.id,
          destinationId: destination.id,
          sha256: 'new-test-test');
    });

    test('Medias - Update', () async {
      final medias = await client.medias.index();
      final source = (await client.sources.index()).first;
      final destination = (await client.destinations.index()).first;

      final Media testMedia = medias.first;

      final newMedia = testMedia.copyWith(
          link: Uri.parse(
              'https://new-${testMedia.link}-${DateTime.now().microsecondsSinceEpoch}'),
          sourceId: source.id,
          destinationId: destination.id,
          sha256: 'new-test-test');
    });

    test('Media - Store', () async {
      final source = (await client.sources.index()).first;
      final destination = (await client.destinations.index()).first;

      final media = await client.medias.store(
        link: Uri.parse(
            'https://test.test/${DateTime.now().millisecondsSinceEpoch}'),
        sourceId: source.id,
        destinationId: destination.id,
        sha256: 'test-test-${DateTime.now().microsecondsSinceEpoch}',
      );

      expect(media, isA<Media>());
      expect(media.link, isA<Uri>());
      expect(media.sourceId, isA<int>());
      expect(media.destinationId, isA<int>());
      expect(media.id, isA<int>());
    });
  });
}
