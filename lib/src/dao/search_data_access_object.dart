part of '../data_access_object.dart';

@immutable
final class SearchDataAccessObject extends DataAccessObject<Search> {
  const SearchDataAccessObject(MagnifiqueCoupleClient client)
      : super('searches', client);

  @override
  Search fromJson(Map<String, dynamic> json) {
    return Search.fromJson(json, _client);
  }
}
