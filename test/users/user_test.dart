import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Show all users', () async {
    var client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );

    var users = await client.users.index();

    for (User user in users) {
      print('${user.id} ${user.name} ${user.snowflake}');
    }
  });
}
