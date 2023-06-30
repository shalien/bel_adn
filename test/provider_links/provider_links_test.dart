import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Provider links test', () async {
    ProviderLink one = await ProviderLink.dao.show(3);

    List<int> providers = one.providers;

    expect(providers.length, 1);
  });

  test('Sync link and provider', () async {
    List<ProviderLink> links = await ProviderLink.dao.index();
    List<Provider> providers = await Provider.dao.index();

    links.shuffle();
    providers.shuffle();

    List<Provider> subList = providers.sublist(0, 5);
    List<ProviderLink> subLinks = links.sublist(0, 5);

    for (ProviderLink link in subLinks) {
      link.providers.addAll(subList.map((e) => e.id!).toList());

      ProviderLink.dao.update(link);

      expect(link.providers.length, 6);
    }
  });
}
