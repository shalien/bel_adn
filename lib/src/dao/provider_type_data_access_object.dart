part of '../data_access_object.dart';

final class ProviderTypeDataAccessObject
    extends DataAccessObject<ProviderType> {
  const ProviderTypeDataAccessObject(MagnifiqueCoupleClient client)
      : super('provider_types', client);

  @override
  ProviderType fromJson(Map<String, dynamic> json) {
    return ProviderType.fromJson(json);
  }
}
