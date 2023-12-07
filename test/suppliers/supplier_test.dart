

import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  test('Test', () async {
    var client = MagnifiqueCoupleClient(
        await File('.env').readAsString(),
    );

    var supplier = await client.suppliers.show(1);

    var pt = await client.suppliers.providerType(supplier);

    print(pt);

  });

  test('Test', () async {
    var client = MagnifiqueCoupleClient(
      await File('.env').readAsString(),
    );

    var supplier = await client.suppliers.show(1);

    var pt = await client.suppliers.paths(supplier);

    print(pt);

  });


}