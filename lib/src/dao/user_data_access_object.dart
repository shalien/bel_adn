part of '../data_access_object.dart';

@immutable
final class UserDataAccessObject extends DataAccessObject<User> {
  const UserDataAccessObject({required super.client, required super.baseUri})
      : super(endpoint: 'users');

  Future<String> getAccessToken(String username, String password,
      {String? deviceName}) async {
    Uri uri = fromParsedHost('/api/$endpoint/token');

    var response = await client.post(uri,
        body: jsonEncode({
          'email': username,
          'password': password,
          ...deviceName != null ? {'device_name': deviceName} : {},
        }));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  Future<List<User>> index() {
    throw UnimplementedError();
  }

  @override
  Future<User> update(int id, {String? email, String? password}) async {
    final Uri uri = fromParsedHost('/api/$endpoint/$id');

    Response response;

    try {
      response = await client.put(uri, body: {
        if (email != null) 'email': email,
        if (password != null) 'password': password,
      });
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body)['data']);
    } else {
      throw MagnifiqueException(response);
    }
  }

  @override
  Future<User> store({email, password, passwordConfirmation}) async {
    final Uri uri = fromParsedHost('/api/$endpoint');

    Response response;

    try {
      response = await client.post(uri, body: {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
    } on ClientException {
      rethrow;
    } on Exception {
      rethrow;
    }

    if (response.statusCode == 201) {
      return fromJson(jsonDecode(response.body)['data']);
    } else {
      throw MagnifiqueException(response);
    }
  }
}
