import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );
  });

  test('Test', () async {
    var providerType = await client.providerTypes.show(1);

    print(providerType);
  });

  test('Test', () async {
    var providerType = await client.providerTypes.show(1);

    var pt = await client.providerTypes.suppliers(providerType);

    print(pt);
  });
}
