import 'dart:convert';

import 'package:http/http.dart';

import '../data_access_object.dart';
import '../model/user.dart';

final class UserDataAccessObject extends DataAccessObject<User> {
  static UserDataAccessObject? _userDataAccessObject;

  factory UserDataAccessObject(String host, Client client) {
    return _userDataAccessObject ??= UserDataAccessObject._(host, client);
  }

  UserDataAccessObject._(String host, Client client)
      : super(resource: 'users', host: host, client: client);

  Future<User> findBySnowflake(String snowflake) async {
    if (snowflake.isEmpty) {
      throw Exception("Snowflake cannot be empty");
    }

    Uri uri = Uri.parse("$resourceUrl/snowflake/$snowflake");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body)['data']);

      return user;
    } else {
      throw Exception("Failed to find user $snowflake");
    }
  }
}
