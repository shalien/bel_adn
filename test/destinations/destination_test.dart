import 'dart:io';
import 'dart:math';

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

  group('Destinations', () {
    test('Destinations - Index', () async {
      final destinations = await client.destinations.index();
      expect(destinations, isA<List<Destination>>());
      expect(destinations, isNotEmpty);
    });

    test('Destinations - Index - Filename', () async {

      final destinations = await client.destinations.index();

      final Destination testDestination = destinations.first;

      final retrievedDestinations = await client.destinations.index(filename: testDestination.filename);

      final retrievedDestination = retrievedDestinations.first;

      expect(retrievedDestination, isA<Destination>());
      expect(retrievedDestination.filename, testDestination.filename);
      expect(retrievedDestination.id, testDestination.id);
      expect(retrievedDestination.sha256, testDestination.sha256);
    });

    test('Destinations - Store - CopyWith', () async {
      final destinations = await client.destinations.index();

      final Destination testDestination = destinations.first;

      final newDestination = testDestination.copyWith(filename: 'new-${testDestination.filename}-${DateTime.now().microsecondsSinceEpoch}', sha256: 'new-test-test');

      final createdDestination = await client.destinations.store(newDestination);

      expect(createdDestination, isA<Destination>());
      expect(createdDestination.filename, newDestination.filename);
      expect(createdDestination.sha256, newDestination.sha256);
    });

    test('Destinations - Update', () async {
      final destinations = await client.destinations.index();

      final Destination testDestination = destinations.first;

      final newDestination = testDestination.copyWith(filename: 'new-${testDestination.filename}-${DateTime.now().microsecondsSinceEpoch}', sha256: 'new-test-test-${DateTime.now().microsecondsSinceEpoch}');

      final updateDestination = await client.destinations.update(testDestination.id!, newDestination);

      expect(updateDestination, isA<Destination>());
      expect(updateDestination.filename, newDestination.filename);
      expect(updateDestination.sha256, newDestination.sha256);
    });

    test('Destinations - Destroy', () async {
      final destinations = await client.destinations.index();

      final Destination testDestination = destinations.first;

      final hasBeenDestroyed = await client.destinations.destroy(testDestination.id!);

      expect(hasBeenDestroyed, true);

    });

  });

  tearDownAll(() async {

  });
}
