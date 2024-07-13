import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Path CRUD', () {
    test('Path - Index', () async {
      final paths = await client.paths.index();

      expect(paths, isA<List<Path>>());
      expect(paths, isNotEmpty);
    });

    test('Path - Index - Content', () async {
      final paths = await client.paths.index();

      final Path testPath = paths.first;

      final retrievedPaths =
          await client.paths.index(content: testPath.content);

      final retrievedPath = retrievedPaths.first;

      expect(retrievedPath, isA<Path>());
      expect(retrievedPath.content, testPath.content);
      expect(retrievedPath.id, testPath.id);
    });

    test('Path - Create', () async {
      final path = await client.paths.store(
        content: 'test-${DateTime.now().microsecondsSinceEpoch}',
      );

      expect(path, isA<Path>());
    });
  });

  tearDownAll(() async {});
}
