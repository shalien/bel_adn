

import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  test('Test', () async {
    var client = MagnifiqueCoupleClient(
        await File('.env').readAsString(),
    );

    var paths = await client.suppliers.index();

    var randomPath = paths.first;

    var providerType = await client.suppliers.providerType(randomPath);

    print(providerType);

  });
}