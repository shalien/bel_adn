import 'dart:math';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  group('Test the topic DAO', () {
    final topicDAO =
        TopicDataAccessObject("https://magnifiquecouple.projetretro.io");

    test("Get all topics", () async {
      final List<Topic> topics = await topicDAO.getAll();

      expect(topics, isA<List<Topic>>());
    });

    test("Get topic with id 1", () async {
      final Topic topic = await topicDAO.getById(1);

      expect(topic, isA<Topic>());
    });
  });
}
