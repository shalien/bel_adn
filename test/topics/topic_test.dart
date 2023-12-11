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

  test('Topic', () async {
    var topics = await client.topics.index();

    var randomTopic = topics[0];

    var paths = await client.topics.searches(randomTopic);

    for (var path in paths) {
      print(path);
    }
  });

  test('test topic cache', () async {
    var topics = await client.topics.index();

    var randomTopic = topics[0];

    print(randomTopic);

    var topic = await client.topics.show(randomTopic.id!);

    print(topic);
  });
}
