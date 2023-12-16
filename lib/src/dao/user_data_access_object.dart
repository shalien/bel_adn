part of '../data_access_object.dart';

@immutable
final class UserDataAccessObject extends DataAccessObject<User> {
  const UserDataAccessObject(MagnifiqueCoupleClient client)
      : super('users', client);

  Future<User> findBySnowflake(String snowflake) async {
    if (snowflake.isEmpty) {
      throw Exception("Snowflake cannot be empty");
    }

    Uri uri = Uri.https(
        MagnifiqueCoupleClient.host, '/api/$endpoint/snowflake/$snowflake');

    var response = await _client.get(uri);

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body)['data'], _client);

      return user;
    } else {
      throw Exception("Failed to find user $snowflake");
    }
  }

  Future<String> getAccessToken(String username, String password,
      {String? deviceName}) async {
    Uri uri = Uri.https(MagnifiqueCoupleClient.host, '/api/$endpoint/token');

    var response = await _client.post(uri,
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
    return User.fromJson(json, _client);
  }
}
