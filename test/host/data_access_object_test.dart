import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() {
  test('Test host changing', () {
    String host = DataAccessObject.host;

    print(host);

    DataAccessObject.host = 'https://magnifiquecouple.projetretro.io';

    host = DataAccessObject.host;

    print(host);
  });
}
