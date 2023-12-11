import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  late MagnifiqueCoupleClient client;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );
  });

  test('Creating a source', () async {
    var paths = await client.paths.index();

    var randomPath = paths[0];

    Source newSource = Source(Uri.https('example.com', '/'), randomPath.id!,
        randomPath.id!, randomPath.id!);

    var source = await client.sources.store(newSource);

    print(source);
  });
}
