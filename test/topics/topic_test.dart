import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test("test a topic with aliases {0} {1}", () async {
    Topic? topic;

    try {
      topic = await TopicDataAccessObject().show(1);
    } catch (e) {
      print(e);
    }

    if (topic == null) {
      return;
    }

    expect((await topic.providers).length, greaterThan(1));
  });

  test('All topic with providers', () async {
    Set<Topic> topics = await TopicDataAccessObject().index();

    int sum = 0;

    for (var topic in topics) {
      int length = (await topic.providers).length;

      if (length <= 0) {
        print(topic.name);
      }

      sum += (await topic.providers).length;
    }

    print(sum);

    for (var topic in topics) {
      int length = (await topic.providers).length;

      if (length <= 0) {
        print(topic.name);
      }

      sum += (await topic.providers).length;
    }

    expect(sum, greaterThan(1));
  });

  test('All topics with aliases', () async {
    Set<Topic> topics = await TopicDataAccessObject().index();

    int sum = 0;

    for (var topic in topics) {
      sum += (await topic.aliases).length;
    }

    print(sum);

    for (var topic in topics) {
      sum += (await topic.aliases).length;
    }

    expect(sum, greaterThan(0));
  });
}
