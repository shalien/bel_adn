import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  test('Path -> suppliers', () async {
    var client = MagnifiqueCoupleClient(
      await File('.env').readAsString(),
    );

    var paths = await client.paths.index();

    var randomPath = paths.last;

    var suppliers = await client.paths.suppliers(randomPath);

    expect(suppliers, isList);
    expect(suppliers, isNotEmpty);
  });

  test('Path -> topics', () async {
    var client = MagnifiqueCoupleClient(
      await File('.env').readAsString(),
    );

    var paths = await client.paths.index();

    var randomPath = paths.last;

    var topics = await client.paths.topics(randomPath);

    expect(topics, isList);
    expect(topics, isNotEmpty);
  });

  test('Path -> sources', () async {
    var client = MagnifiqueCoupleClient(
      await File('.env').readAsString(),
    );

    var paths = await client.paths.index();

    var randomPath = paths.last;

    var sources = await client.paths.sources(randomPath);

    expect(sources, isList);
    expect(sources, isNotEmpty);
  });
}
