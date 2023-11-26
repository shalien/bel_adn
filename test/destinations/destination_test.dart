import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Destination media', () async {
    var client = MagnifiqueCoupleClient(
      await File('.env').readAsString(),
    );

    var element = await client.destinations.show(102);

    print(element.filename);
  });
}
