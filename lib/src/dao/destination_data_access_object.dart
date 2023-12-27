part of '../data_access_object.dart';

@immutable
final class DestinationDataAccessObject extends DataAccessObject<Destination> {
  @override
  const DestinationDataAccessObject(MagnifiqueCoupleClient client)
      : super('destinations', client);

  @override
  Destination fromJson(Map<String, dynamic> json) {
    return Destination.fromJson(json, _client);
  }
}
