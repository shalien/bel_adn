import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Providers and links', () async {
    Provider one = await ProviderDataAccessObject().show(3);

    ProviderLink link = await one.providerLink;

    expect(link, isNotNull);
  });

  test('Providers sources', () async {
    Provider one = await ProviderDataAccessObject().show(3);

    Set<Source> sources = await one.sources;

    for (var source in sources) {
      print(source.link);
    }

    expect(sources.length, greaterThan(0));
  });
}
