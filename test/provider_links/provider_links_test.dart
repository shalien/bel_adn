import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Provider links test', () async {
    ProviderLink one = await ProviderLink.dao.show(3);

    List<Provider> providers = await one.providers;

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
      link.providersIds.addAll(subList.map((e) => e.id!).toList());

      ProviderLink.dao.update(link);

      expect((await link.providers).length, greaterThanOrEqualTo(5));
    }
  });

  test('Create and destroy', () async {
    List<Provider> providers = await Provider.dao.index();
    providers.shuffle();

    List<ProviderType> types = await ProviderType.dao.index();
    types.shuffle();

    ProviderLink pl = ProviderLink(
        providersIds: providers.sublist(0, 5).map((e) => e.id!).toList(),
        link: Uri.parse('http://test.com'),
        providerTypeId: types.first.id!);

    ProviderLink npl = await ProviderLink.dao.store(pl);

    print(npl.id);

    ProviderLink.dao.destroy(npl);
  });
}
