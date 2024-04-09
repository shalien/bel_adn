import 'dart:io';
import 'dart:math';

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
    test('Topics - Index', () async {
      var topics = await client.topics.index();

      expect(topics, isA<List<Topic>>());
      expect(topics.length, greaterThan(0));
    });

    test('Topics - Index - Anal', () async {
      var topics = await client.topics.index(name: 'anal');

      expect(topics, isA<List<Topic>>());
      expect(topics.length, 1);
      expect(topics.first.name.toLowerCase(), 'anal');
    });

    test('Topics - Store', () async {
      var toStore = Topic('test', Random().nextInt(1000));

      createdTopic = await client.topics.store(toStore);

      if (createdTopic == null) {
        throw Exception('Topic is null');
      }

      expect(createdTopic, isA<Topic>());
      expect(createdTopic?.name, toStore.name);
      expect(createdTopic?.id, isA<int>());
      expect(createdTopic?.id, greaterThan(0));
    });

    test('Topics - Show', () async {
      if (createdTopic == null) {
        throw Exception('Topic is null');
      }

      var topic = await client.topics.show(createdTopic!.id!);

      expect(topic, isA<Topic>());
      expect(topic.name, createdTopic?.name);
      expect(topic.id, createdTopic?.id);
    });

    test('Topics - Update', () async {
      if (createdTopic == null) {
        throw Exception('Topic is null');
      }

      Topic? toUpdate = createdTopic?.copyWith(order: Random().nextInt(1000));

      if (toUpdate == null) {
        throw Exception('Topic is null');
      }

      updatedTopic = await client.topics.update(createdTopic!.id!, toUpdate);

      if (updatedTopic == null) {
        throw Exception('Topic is null');
      }

      expect(updatedTopic, isA<Topic>());
      expect(updatedTopic?.name, toUpdate.name);
      expect(updatedTopic?.id, createdTopic?.id);
    });

    test('Topics - Destroy', () async {
      if (createdTopic == null) {
        throw Exception('Topic is null');
      }

      await client.topics.delete(updatedTopic!.id!);

      expect(true, isTrue);
    });
  });

  tearDownAll(() async {
    if (createdTopic != null) {
      await client.topics.delete(createdTopic!.id!);
    }
  });
}
