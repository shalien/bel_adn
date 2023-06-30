import '../data_access_object.dart';
import '../model/provider_link.dart';

final class ProviderLinkDataAccessObject
    extends DataAccessObject<ProviderLink> {
  static ProviderLinkDataAccessObject? _providerLinkDataAccessObject;

  ProviderLinkDataAccessObject._() : super(resource: 'provider_links');

  factory ProviderLinkDataAccessObject() {
    return _providerLinkDataAccessObject ??= ProviderLinkDataAccessObject._();
  }
}
