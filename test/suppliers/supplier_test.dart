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
    var supplier = await client.suppliers.show(1);

    var pt = await client.suppliers.providerType(supplier);

    print(pt);
  });

  test('Test', () async {
    var supplier = await client.suppliers.show(1);

    var pt = await client.suppliers.searches(supplier);

    print(pt);
  });
}
