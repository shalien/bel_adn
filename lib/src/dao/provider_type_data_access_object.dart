import 'package:http/http.dart';

import '../data_access_object.dart';
import '../model/provider_type.dart';

final class ProviderTypeDataAccessObject
    extends DataAccessObject<ProviderType> {
  static ProviderTypeDataAccessObject? _providerTypeDataAccessObject;

  ProviderTypeDataAccessObject._(String host, Client client)
      : super(resource: "provider_types", host: host, client: client);

  factory ProviderTypeDataAccessObject(String host, Client client) {
    return _providerTypeDataAccessObject ??=
        ProviderTypeDataAccessObject._(host, client);
  }
}
