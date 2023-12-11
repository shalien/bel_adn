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

  test('Path -> searches', () async {
    var paths = await client.paths.index();

    var randomPath = paths.last;

    var suppliers = await randomPath.searches;

    expect(suppliers, isList);
    expect(suppliers, isNotEmpty);
  });

  test('Path -> sources', () async {
    var paths = await client.paths.index();

    var randomPath = paths.last;

    var sources = await client.paths.searches(randomPath);

    expect(sources, isList);
    expect(sources, isNotEmpty);
  });
}
