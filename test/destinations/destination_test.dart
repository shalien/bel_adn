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
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Destinations', () {});

  tearDownAll(() async {
    if (createdDestination != null && createdDestination.id != null) {
      await client.destinations.delete(createdDestination.id!);
    }
  });
}
