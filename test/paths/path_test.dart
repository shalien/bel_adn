import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  Path path = Path('test');
  Path? createdPath;
  Path? updatedPath;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Path CRUD', () {
    test('Path - Index', () async {
      var paths = await client.paths.index();

      expect(paths, isA<List<Path>>());
      expect(paths.length, greaterThan(0));
    });

    test('Path - Store', () async {
      var toStore = Path('test');

      createdPath = await client.paths.store(toStore);

      if (createdPath == null) {
        throw Exception('Path is null');
      }

      expect(createdPath, isA<Path>());
      expect(createdPath?.content, toStore.content);
      expect(createdPath?.id, isA<int>());
      expect(createdPath?.id, greaterThan(0));
    });

    test('Path - Show', () async {
      if (createdPath == null) {
        throw Exception('Path is null');
      }

      var path = await client.paths.show(createdPath!.id!);

      expect(path, isA<Path>());
      expect(path.content, createdPath?.content);
      expect(path.id, createdPath?.id);
    });

    test('Path - Update', () async {
      if (createdPath == null) {
        throw Exception('Path is null');
      }

      Path? toUpdate = createdPath?.copyWith(content: 'test2');

      if (toUpdate == null) {
        throw Exception('Path to update is null');
      }

      updatedPath = await client.paths.update(createdPath!.id!, toUpdate);

      expect(updatedPath, isA<Path>());
      expect(updatedPath?.content, toUpdate.content);
      expect(updatedPath?.id, createdPath?.id);
    });

    test('Path - Delete', () async {
      if (updatedPath == null) {
        throw Exception('Path is null');
      }

      await client.paths.delete(updatedPath!.id!);

      expect(true, isTrue);
    });
  });

  tearDownAll(() async {
    if (createdPath != null && createdPath!.id != null) {
      await client.paths.delete(createdPath!.id!);
    }
  });
}
