import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  group('Test the Provider DAO', () {
    final providerDAO =
        ProviderDataAccessObject("https://magnifiquecouple.projetretro.io");

    test("Get topic from provider with id 1", () async {
      final List<Provider> topic = await providerDAO.getByTopicId(1);

      expect(topic, isList);
    });
  });
}
