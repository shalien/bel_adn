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

  test('Path -> suppliers', () async {


    var paths = await client.paths.index();

    var randomPath = paths.last;

    var suppliers = await client.paths.searches(randomPath);

    expect(suppliers, isList);
    expect(suppliers, isNotEmpty);
  });

  test('Path -> topics', () async {


    var paths = await client.paths.index();

    var randomPath = paths.last;

    var topics = await client.paths.searches(randomPath);

    expect(topics, isList);
    expect(topics, isNotEmpty);
  });

  test('Path -> sources', () async {

    var paths = await client.paths.index();

    var randomPath = paths.last;

    var sources = await client.paths.searches(randomPath);

    expect(sources, isList);
    expect(sources, isNotEmpty);
  });
}
