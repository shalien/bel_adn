import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:bel_adn/src/model/prohibited_domain.dart';
import 'package:test/scaffolding.dart';

void main() async {
  test('Create Prohibited Domain', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    ProhibitedDomain prohibitedDomain = ProhibitedDomain(domain: 'demo.com');

    ProhibitedDomain newProhibitedDomain =
        await client.prohibitedDomains.store(prohibitedDomain);

    print('${newProhibitedDomain.id} ${newProhibitedDomain.domain}');
  });

  test('Show Prohibited Domain', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    Set<ProhibitedDomain> prohibitedDomain =
        await client.prohibitedDomains.index();

    for (var prohibitedDomain in prohibitedDomain) {
      print('${prohibitedDomain.id} ${prohibitedDomain.domain}');
    }
  });
}
