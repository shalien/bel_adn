import 'package:bel_adn/src/dao/guild_data_access_object.dart';
import 'package:bel_adn/src/dao/user_data_access_object.dart';

import '../../bel_adn.dart';

final Map<String, MagnifiqueCoupleClient> _clients = {};

final class MagnifiqueCoupleClient {
  BelAdnClient _internal;

  final String accessToken;

  static String _host = 'https://magnifiquecouple.projetretro.io';

  late final DestinationDataAccessObject destinations;

  late final MediaDataAccessObject medias;

  late final ProviderDataAccessObject providers;

  late final ProviderLinkDataAccessObject providerLinks;

  late final ProviderTypeDataAccessObject providerTypes;

  late final SourceDataAccessObject sources;

  late final TopicDataAccessObject topics;

  late final TopicAliasDataAccessObject topicAliases;

  late final UserDataAccessObject users;

  late final GuildDataAccessObject guilds;

  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'user-agent': 'bel_adn:cbJKqzlZ8soXvU_tvP5KWw:3.0.1 u/Shalien93',
  };

  MagnifiqueCoupleClient._({required this.accessToken})
      : _internal = BelAdnClient() {
    assert(() {
      _host = 'http://localhost:8000';
      return true;
    }());

    destinations = DestinationDataAccessObject(_host, _internal);
    medias = MediaDataAccessObject(_host, _internal);
    providers = ProviderDataAccessObject(_host, _internal);
    providerLinks = ProviderLinkDataAccessObject(_host, _internal);
    providerTypes = ProviderTypeDataAccessObject(_host, _internal);
    sources = SourceDataAccessObject(_host, _internal);
    topics = TopicDataAccessObject(_host, _internal);
    topicAliases = TopicAliasDataAccessObject(_host, _internal);
    users = UserDataAccessObject(_host, _internal);
    guilds = GuildDataAccessObject(_host, _internal);

    if (accessToken.isEmpty) {
      throw ArgumentError.value(accessToken, 'accessToken', 'Cannot be empty');
    }

    headers.addAll({'Authorization': 'Bearer $accessToken'});
    _internal.defaultHeaders = headers;
  }

  factory MagnifiqueCoupleClient({required String accessToken}) {
    if (_clients.containsKey(accessToken)) {
      return _clients[accessToken]!;
    }

    return _clients[accessToken] = MagnifiqueCoupleClient._(
      accessToken: accessToken,
    );
  }
}
