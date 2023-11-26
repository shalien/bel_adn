part of '../data_access_object.dart';

final class UserDataAccessObject extends DataAccessObject<User> {
  const UserDataAccessObject(MagnifiqueCoupleClient client)
      : super('users', client);

  Future<User> findBySnowflake(String snowflake) async {
    if (snowflake.isEmpty) {
      throw Exception("Snowflake cannot be empty");
    }

    Uri uri =
        Uri.parse("${MagnifiqueCoupleClient.host}/api/snowflake/$snowflake");

    var response = await _client.get(uri);

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body)['data']);

      return user;
    } else {
      throw Exception("Failed to find user $snowflake");
    }
  }

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }
}
