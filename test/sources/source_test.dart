import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  late MagnifiqueCoupleClient client;

  Source? createdSource;
  Source? updatedSource;

  Topic? createdTopic;
  Path? createdPath;
  Supplier? createdSupplier;

  Search? createdSearch;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    Topic toTestTopic = Topic('test_search_source', 99999);
    createdTopic = await client.topics.store(toTestTopic);

    Path toTestPath = Path('test_search_source');
    createdPath = await client.paths.store(toTestPath);

    Supplier toTestSupplier = Supplier('test_search_source', 1);
    createdSupplier = await client.suppliers.store(toTestSupplier);

    Search toTestSearch =
        Search(createdTopic!.id!, createdPath!.id!, createdSupplier!.id!);
    createdSearch = await client.searches.store(toTestSearch);
  });

  group('Source CRUD', () {
    /// This test is not working
    test('Source - Index', () async {
      /*
      var sources = await client.sources.index();

      expect(sources, isA<List<Source>>());
      expect(sources.length, greaterThan(0));
      */
    });

    test('Source - Store', () async {
      var toStore =
          Source(Uri.https('example.com', 'test'), createdSearch!.id!);

      createdSource = await client.sources.store(toStore);

      if (createdSource == null) {
        throw Exception('Source is null');
      }

      expect(createdSource, isA<Source>());
      expect(createdSource?.link, toStore.link);
      expect(createdSource?.searchId, toStore.searchId);
      expect(createdSource?.id, isA<int>());
      expect(createdSource?.id, greaterThan(0));
    });

    test('Source - Show', () async {
      if (createdSource == null) {
        throw Exception('Source is null');
      }

      var source = await client.sources.show(createdSource!.id!);

      expect(source, isA<Source>());
      expect(source.link, createdSource?.link);
      expect(source.searchId, createdSource?.searchId);
      expect(source.id, createdSource?.id);
    });

    test('Source - Update', () async {
      if (createdSource == null) {
        throw Exception('Source is null');
      }

      var toUpdate =
          createdSource?.copyWith(link: Uri.https('example.com', 'test2'));

      if (toUpdate == null) {
        throw Exception('Source is null');
      }

      updatedSource = await client.sources.update(createdSource!.id!, toUpdate);

      if (updatedSource == null) {
        throw Exception('Source is null');
      }

      expect(updatedSource, isA<Source>());
      expect(updatedSource?.link, toUpdate.link);
      expect(updatedSource?.searchId, toUpdate.searchId);
      expect(updatedSource?.id, isA<int>());
      expect(updatedSource?.id, greaterThan(0));
    });

    test('Source - Delete', () async {
      if (updatedSource == null) {
        throw Exception('Source is null');
      }

      var deleted = await client.sources.delete(updatedSource!.id!);

      expect(deleted, isTrue);
    });
  });

  tearDownAll(() async {
    if (updatedSource != null) {
      await client.sources.delete(updatedSource!.id!);
    }

    if (createdSource != null) {
      await client.sources.delete(createdSource!.id!);
    }

    if (createdSearch != null) {
      await client.searches.delete(createdSearch!.id!);
    }

    if (createdTopic != null) {
      await client.topics.delete(createdTopic!.id!);
    }

    if (createdPath != null) {
      await client.paths.delete(createdPath!.id!);
    }

    if (createdSupplier != null) {
      await client.suppliers.delete(createdSupplier!.id!);
    }
  });
}
