import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test("test a topic with aliases {0} {1}", () async {
    Topic? topic;

    try {
      topic = await Topic.dao.show(1);
    } catch (e) {
      print(e);
    }

    if (topic == null) {
      return;
    }

    expect((await topic.providers).length, greaterThan(1));
  });

  test('All topic with providers', () async {
    List<Topic> topics = await Topic.dao.index();

    int sum = 0;

    for (var topic in topics) {
      sum += (await topic.providers).length;
    }

    print(sum);

    expect(sum, greaterThan(1));
  });

  test('All topics with aliases', () async {
    List<Topic> topics = await Topic.dao.index();

    int sum = 0;

    for (var topic in topics) {
      sum += (await topic.aliases).length;
    }

    print(sum);

    expect(sum, greaterThan(0));
  });
}