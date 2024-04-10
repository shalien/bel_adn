part of '../data_access_object.dart';

@immutable
final class SearchDataAccessObject extends DataAccessObject<Search> {
  const SearchDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'searches');

  @override
  Search fromJson(Map<String, dynamic> json) {
    return Search.fromJson(json);
  }

  @override
  Future<List<Search>> index(
      {int? topicId, int? pathId, int? supplierId, int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (topicId != null) 'topic_id': topicId.toString(),
      if (pathId != null) 'path_id': pathId.toString(),
      if (supplierId != null) 'supplier_id': supplierId.toString(),
    });

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Search> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Search modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }
}
