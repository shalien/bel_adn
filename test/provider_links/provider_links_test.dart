import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Provider links test', () async {
    ProviderLink one = await ProviderLink.dao.show(3);

    List<Provider> providers = await one.providers;

    expect(providers.length, 1);
  });
}
