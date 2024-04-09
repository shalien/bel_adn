part of '../data_access_object.dart';

@immutable
final class SearchDataAccessObject extends DataAccessObject<Search> {
  const SearchDataAccessObject(MagnifiqueCoupleClient client, Uri baseUri)
      : super(endpoint: 'searches', client: client, baseUri: baseUri);

  @override
  Search fromJson(Map<String, dynamic> json) {
    return Search.fromJson(json, client);
  }

  @override
  Future<List<Search>> index() {
    // TODO: implement index
    throw UnimplementedError();
  }
}
