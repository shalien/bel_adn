import 'dart:convert';

import 'package:http/http.dart';

import '../data_access_object.dart';
import '../model/guild.dart';
import '../model/user.dart';

final class GuildDataAccessObject extends DataAccessObject<Guild> {
  GuildDataAccessObject(String host, Client client)
      : super(resource: "guilds", host: host, client: client);

  Future<Set<User>> users(int snowflake) async {
    Uri uri = Uri.parse("$resourceUrl/$snowflake/users");

    var response = await client.get(uri);

    if (response.statusCode == 200) {
      Set<User> users = Set<User>.from(
        jsonDecode(response.body)['data'].map(
          (user) => User.fromJson(user),
        ),
      );

      return users;
    } else {
      throw Exception("Failed to find users for guild $snowflake");
    }
  }
}
