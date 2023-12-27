import 'dart:io';
import 'dart:math';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  late MagnifiqueCoupleClient client;

  Destination? createdDestination;
  Destination? updatedDestination;
  Destination? copiedWithNewNameDestination;

  String testDestinationName = String.fromCharCodes(
      List.generate(10, (index) => Random().nextInt(33) + 89));

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Destinations', () {
    /// dont work yet
    test('Destinations - Index', () async {
      expect(true, true);
    });

    test('Destinations - Store', () async {
      var toStore = Destination(testDestinationName);

      createdDestination = await client.destinations.store(toStore);

      if (createdDestination == null) {
        throw Exception('Destination is null');
      }

      expect(createdDestination, isA<Destination>());
      expect(createdDestination?.filename, testDestinationName);
      expect(createdDestination?.id, isA<int>());
      // is superior at 0
      expect(createdDestination?.id, greaterThan(0));
    });

    test('Destinations - Show', () async {
      if (createdDestination == null) {
        throw Exception('Destination is null');
      }

      var destination = await client.destinations.show(createdDestination!.id!);

      expect(destination, isA<Destination>());
      expect(destination.filename, createdDestination?.filename);
      expect(destination.id, createdDestination?.id);
    });

    test('Destination - CopyWith', () {
      if (createdDestination == null) {
        throw Exception('Destination is null');
      }

      copiedWithNewNameDestination =
          createdDestination?.copyWith(filename: 'test2');

      expect(copiedWithNewNameDestination, isA<Destination>());
      expect(copiedWithNewNameDestination?.filename, 'test2');
      expect(copiedWithNewNameDestination?.id, createdDestination?.id);
    });

    test('Destinations - Update', () async {
      if (createdDestination == null || copiedWithNewNameDestination == null) {
        throw Exception('Destination is null');
      }

      updatedDestination = await client.destinations
          .update(createdDestination!.id!, copiedWithNewNameDestination!);

      expect(updatedDestination, isA<Destination>());
      expect(
          updatedDestination?.filename, copiedWithNewNameDestination?.filename);
      expect(updatedDestination?.id, copiedWithNewNameDestination?.id);
    });

    test('Destinations - Delete', () async {
      if (updatedDestination == null) {
        throw Exception('Destination is null');
      }

      await client.destinations.delete(updatedDestination!.id!);

      expect(true, true);
    });
  });

  tearDownAll(() async {
    if (createdDestination != null && createdDestination!.id != null) {
      await client.destinations.delete(createdDestination!.id!);
    }
  });
}
