

import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {

  test('Creating a source', () async {
    var client = MagnifiqueCoupleClient(
      await File('.env').readAsString(),
    );

    var paths = await client.paths.index();

    var randomPath = paths[0];

    Source newSource = Source(Uri.https('example.com', '/'), randomPath.id!);

    var source = await client.sources.store(newSource);

    print(source);


});
}