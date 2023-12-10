part of '../data_access_object.dart';

final class DestinationDataAccessObject extends DataAccessObject<Destination> {
  const DestinationDataAccessObject(MagnifiqueCoupleClient client)
      : super('destinations', client);

  @override
  Destination fromJson(Map<String, dynamic> json) {
    return Destination.fromJson(json,client: _client);
  }
}
