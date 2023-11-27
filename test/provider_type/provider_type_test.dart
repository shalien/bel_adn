

import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  test('Test', () async {
    var client = MagnifiqueCoupleClient(
        await File('.env').readAsString(),
    );

   var providerType = await client.providerTypes.show(1);

    print(providerType);

  });
}