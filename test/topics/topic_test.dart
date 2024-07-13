import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  late MagnifiqueCoupleClient client;

  Topic? createdTopic;
  Topic? updatedTopic;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Topics CRUD', () {

    test('Topics - Index - Name', () async {
      final topics = await client.topics.index(name: 'test');

      expect(topics, isA<List<Topic>>());
      expect(topics, isNotEmpty);
    });

    test('Topics - Create', () async {
      final topic = await client.topics.store(
        name: 'test',
      );

      createdTopic = topic;

      expect(topic, isA<Topic>());
      expect(topic.name, 'test');
    });
  });

  tearDownAll(() async {});
}
