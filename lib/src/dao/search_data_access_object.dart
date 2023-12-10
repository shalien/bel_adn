

part of '../data_access_object.dart';

final class SearchDataAccessObject extends DataAccessObject {
  const SearchDataAccessObject(MagnifiqueCoupleClient client)
      : super('searches', client);

  @override
  Search fromJson(Map<String, dynamic> json) {
    return Search.fromJson(json, client: _client);
  }
}