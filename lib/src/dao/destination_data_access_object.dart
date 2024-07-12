part of '../data_access_object.dart';

@immutable
final class DestinationDataAccessObject extends DataAccessObject<Destination> {
  @override
  const DestinationDataAccessObject(
      {required super.client, required super.baseUri})
      : super(endpoint: 'destinations');

  @override
  Destination fromJson(Map<String, dynamic> json) {
    return Destination.fromJson(json);
  }

  @override
  Future<List<Destination>> index(
      {int? id,
      String? filename,
      String? sha256,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? page = 1}) async {
    final Uri uri = fromParsedHost('/api/$endpoint', {
      if (id != null) 'id': id.toString(),
      if (filename != null) 'filename': filename,
      if (sha256 != null) 'sha256': sha256,
      if (createdAt != null) 'created_at': createdAt.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt.toIso8601String(),
      if (page != null) 'page': page.toString(),
    });

    Response response;

    try {
      response = await client.get(uri);
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    List<Destination> models = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)['data'];
      models = json.map((dynamic model) {
        Destination modelised = fromJson(model);

        return modelised;
      }).toList();
    } else {
      throw MagnifiqueException(response);
    }

    return models;
  }

  @override
  Future<Destination> update(int id, {String? filename, String? sha256}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri,
          body: jsonEncode({
            if (filename != null) 'filename': filename,
            if (sha256 != null) 'sha256': sha256,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body)['data'];
      return fromJson(json);
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<Destination> store({filename, sha256}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri,
          body: jsonEncode({
            'filename': filename,
            'sha256': sha256,
          }),
          headers: {
            'Content-Type': 'application/json',
          });
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 201) {
      final dynamic json = jsonDecode(response.body)['data'];
      return fromJson(json);
    } else {
      throw MagnifiqueException(response);
    }
  }
}
