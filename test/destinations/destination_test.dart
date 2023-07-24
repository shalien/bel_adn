import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Destination media', () async {
    Destination destination = await DestinationDataAccessObject().show(1);
  });
}
