import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  late MagnifiqueCoupleClient client;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );
  });

  test('Destination media', () async {
    var element = await client.destinations.show(102);

    print(element.filename);
  });

  test('Destination', () async {
    var element = await client.destinations.show(102);

    var source = await client.sources.showByDestination(element.filename);

    print(source);
  });
}
