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
      accessToken: await File('.env').readAsString(),
    );

    Topic toTestTopic = Topic('test_search', 99999);
    testTopic = await client.topics.store(toTestTopic);

    Path toTestPath = Path('test_search');
    testPath = await client.paths.store(toTestPath);

    Supplier toTestSupplier = Supplier('test_search', 1);
    testSupplier = await client.suppliers.store(toTestSupplier);
  });

  group('Search - CRUD', () {
    test('Search - Index', () async {
      var searches = await client.searches.index();

      expect(searches, isA<List<Search>>());
      expect(searches.length, greaterThan(0));
    });

    test('Search - Store', () async {
      var toStore = Search(testTopic!.id!, testPath!.id!, testSupplier!.id!);

      createdSearch = await client.searches.store(toStore);

      if (createdSearch == null) {
        throw Exception('Search is null');
      }

      expect(createdSearch, isA<Search>());
      expect(createdSearch?.topicId, toStore.topicId);
      expect(createdSearch?.pathId, toStore.pathId);
      expect(createdSearch?.supplierId, toStore.supplierId);
      expect(createdSearch?.id, isA<int>());
      expect(createdSearch?.id, greaterThan(0));
    });

    test('Search - Show', () async {
      if (createdSearch == null) {
        throw Exception('Search is null');
      }

      var search = await client.searches.show(createdSearch!.id!);

      expect(search, isA<Search>());
      expect(search.topicId, createdSearch?.topicId);
      expect(search.pathId, createdSearch?.pathId);
      expect(search.supplierId, createdSearch?.supplierId);
      expect(search.id, createdSearch?.id);
    });

    test('Search - Update', () async {
      if (createdSearch == null) {
        throw Exception('Search is null');
      }

      Topic updateTopic = await client.topics.show(2);

      Search? toUpdate = createdSearch?.copyWith(topicId: updateTopic.id!);

      updatedSearch =
          await client.searches.update(createdSearch!.id!, toUpdate!);

      expect(updatedSearch, isA<Search>());
      expect(updatedSearch?.topicId, toUpdate.topicId);
      expect(updatedSearch?.pathId, toUpdate.pathId);
      expect(updatedSearch?.supplierId, toUpdate.supplierId);
      expect(updatedSearch?.id, toUpdate.id);
    });

    test('Search - Delete', () async {
      if (updatedSearch == null) {
        throw Exception('Search is null');
      }

      var deleted = await client.searches.delete(updatedSearch!.id!);

      expect(deleted, isTrue);
    });
  });

  tearDownAll(() async {
    if (testTopic != null) {
      await client.topics.delete(testTopic!.id!);
    }

    if (testPath != null) {
      await client.paths.delete(testPath!.id!);
    }

    if (testSupplier != null) {
      await client.suppliers.delete(testSupplier!.id!);
    }

    if (createdSearch != null) {
      await client.searches.delete(createdSearch!.id!);
    }
  });
}
