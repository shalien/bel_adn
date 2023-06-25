import '../models/provider_type.dart';
import 'data_access_object.dart';

ProviderTypeDataAccessObject? _providerTypeDataAccessObject;

class ProviderTypeDataAccessObject extends DataAccessObject<ProviderType> {
  ProviderTypeDataAccessObject._(String host) : super(host, "providertypes");

  factory ProviderTypeDataAccessObject(String host) {
    return _providerTypeDataAccessObject ??=
        ProviderTypeDataAccessObject._(host);
  }

  @override
  Future<bool> update(ProviderType t) {
    throw UnimplementedError();
  }
}
