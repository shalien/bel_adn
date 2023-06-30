import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Providers and links', () async {
    Provider one = await Provider.dao.show(3);

    List<ProviderLink> links = await one.providerLinksList;

    expect(links.length, 1);
  });
}
