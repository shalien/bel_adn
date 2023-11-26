import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  test('Topic', () async {
    var client = MagnifiqueCoupleClient(
      await File('.env').readAsString(),
    );

    var topics = await client.topics.index();

    var randomTopic = topics[0];

    var paths = await client.topics.paths(randomTopic);

    for (Path path in paths) {
      print(path.content);
    }
  });
}
