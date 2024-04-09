part of '../data_access_object.dart';

@immutable
final class DestinationDataAccessObject extends DataAccessObject<Destination> {
  @override
  const DestinationDataAccessObject(MagnifiqueCoupleClient client, Uri baseUri)
      : super(endpoint: 'destinations', client: client, baseUri: baseUri);

  @override
  Destination fromJson(Map<String, dynamic> json) {
    return Destination.fromJson(json, client);
  }

  @override
  Future<List<Destination>> index() {
    // TODO: implement index
    throw UnimplementedError();
  }
}
