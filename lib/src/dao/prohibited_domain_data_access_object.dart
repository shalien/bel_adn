import 'package:bel_adn/src/data_access_object.dart';
import 'package:http/http.dart';

import '../model/prohibited_domain.dart';

final class ProhibitedDomainDataAccessObject
    extends DataAccessObject<ProhibitedDomain> {
  ProhibitedDomainDataAccessObject(String host, Client client)
      : super(resource: "prohibited_domains", host: host, client: client);
}
