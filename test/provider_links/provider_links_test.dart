import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Provider links test', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    ProviderLink one = await client.providerLinks.show(3);

    print(one);
  });
}
