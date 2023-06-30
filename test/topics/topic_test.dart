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

    expect(topic.aliases.length, equals(1));
  });
}
