import 'package:bel_adn/bel_adn.dart';
import 'package:http/http.dart';

import '../model/guild.dart';

final class GuildDataAccessObject extends DataAccessObject<Guild> {
  GuildDataAccessObject(String host, Client client)
      : super(resource: "guilds", host: host, client: client);
}
