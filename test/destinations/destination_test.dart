import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Destination media', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    var element = await client.destinations.show(126472);

    print(element.filename);
  });
}
