import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Show all users', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    var users = await client.users.index();

    for (User user in users) {
      print('${user.id} ${user.name} ${user.snowflake}');
    }
  });

  test('Insert User', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    User newUser = User(
        name: 'Demo',
        snowflake: 1234567890,
        email: User.generateEmail(),
        password: User.generatePassword());

    User user = await client.users.store(newUser);

    print('${user.id} ${user.name} ${user.snowflake}');
  });

  test('Find by Snowflake', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    User snowflaked = await client.users.findBySnowflake('1234567890');

    print('${snowflaked.id} ${snowflaked.name} ${snowflaked.snowflake}');
  });
}
