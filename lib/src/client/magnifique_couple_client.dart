import 'package:bel_adn/src/dao/user_data_access_object.dart';

import '../../bel_adn.dart';

final Map<String, MagnifiqueCoupleClient> _clients = {};

final class MagnifiqueCoupleClient {
  final BelAdnClient _internal;

  final String accessToken;

  static final String _host = 'https://magnifiquecouple.projetretro.io';

  late final DestinationDataAccessObject destinations;

  late final MediaDataAccessObject medias;

  late final ProviderDataAccessObject providers;

  late final ProviderLinkDataAccessObject providerLinks;

  late final ProviderTypeDataAccessObject providerTypes;

  late final SourceDataAccessObject sources;

  late final TopicDataAccessObject topics;

  late final TopicAliasDataAccessObject topicAliases;

  late final UserDataAccessObject users;

  MagnifiqueCoupleClient._({BelAdnClient? client, required this.accessToken})
      : _internal = client ?? BelAdnClient() {
    destinations = DestinationDataAccessObject(_host, _internal);
    medias = MediaDataAccessObject(_host, _internal);
    providers = ProviderDataAccessObject(_host, _internal);
    providerLinks = ProviderLinkDataAccessObject(_host, _internal);
    providerTypes = ProviderTypeDataAccessObject(_host, _internal);
    sources = SourceDataAccessObject(_host, _internal);
    topics = TopicDataAccessObject(_host, _internal);
    topicAliases = TopicAliasDataAccessObject(_host, _internal);
    users = UserDataAccessObject(_host, _internal);

    if (accessToken.isEmpty) {
      throw ArgumentError.value(accessToken, 'accessToken', 'Cannot be empty');
    }

    BelAdnClient.defaultHeaders
        .addAll({'Authorization': 'Bearer $accessToken'});
  }

  factory MagnifiqueCoupleClient(
      {required String accessToken, BelAdnClient? client}) {
    if (_clients.containsKey(accessToken)) {
      return _clients[accessToken]!;
    }

    return _clients[accessToken] = MagnifiqueCoupleClient._(
      accessToken: accessToken,
      client: client,
    );
  }
}
