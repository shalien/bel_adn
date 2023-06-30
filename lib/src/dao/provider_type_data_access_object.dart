import '../data_access_object.dart';
import '../model/provider_type.dart';

class ProviderTypeDataAccessObject extends DataAccessObject<ProviderType> {
  static ProviderTypeDataAccessObject? _providerTypeDataAccessObject;

  ProviderTypeDataAccessObject._() : super(resource: "provider_types");

  factory ProviderTypeDataAccessObject() {
    return _providerTypeDataAccessObject ??= ProviderTypeDataAccessObject._();
  }
}
