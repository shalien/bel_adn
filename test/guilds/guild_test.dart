import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  test('Create a guild', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    Guild guild = Guild(name: 'Demo', snowflake: 1234567890);

    Guild newGuild = await client.guilds.store(guild);

    print('${newGuild.id} ${newGuild.name} ${newGuild.snowflake}');
  });

  test('Show a guild', () async {
    var client = MagnifiqueCoupleClient(
      accessToken: await File('.env').readAsString(),
    );

    Guild guild = await client.guilds.show(1234567890);

    print('${guild.id} ${guild.name} ${guild.snowflake}');
  });
}
