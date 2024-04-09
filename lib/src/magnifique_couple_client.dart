import 'package:http/http.dart';

import '../src/data_access_object.dart';

class MagnifiqueCoupleClient extends BaseClient {
  final Client _client;

  String? accessToken;

  final String host;

  final Uri _parsedUri;

  late final DestinationDataAccessObject destinations;

  late final MediaDataAccessObject medias;

  late final ProviderTypeDataAccessObject providerTypes;

  late final SourceDataAccessObject sources;

  late final TopicDataAccessObject topics;

  late final UserDataAccessObject users;

  late final PathDataAccessObject paths;

  late final SupplierDataAccessObject suppliers;

  late final SearchDataAccessObject searches;

  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'user-agent': 'bel_adn:cbJKqzlZ8soXvU_tvP5KWw:3.0.1 u/Shalien93',
  };

  MagnifiqueCoupleClient(
      {required this.host, required this.accessToken, Client? client})
      : _client = client ?? Client(),
        _parsedUri = Uri.parse(host) {
    destinations =
        DestinationDataAccessObject(client: this, baseUri: _parsedUri);
    medias = MediaDataAccessObject(client: this, baseUri: _parsedUri);
    paths = PathDataAccessObject(client: this, baseUri: _parsedUri);
    providerTypes =
        ProviderTypeDataAccessObject(client: this, baseUri: _parsedUri);
    searches = SearchDataAccessObject(client: this, baseUri: _parsedUri);
    sources = SourceDataAccessObject(client: this, baseUri: _parsedUri);
    suppliers = SupplierDataAccessObject(client: this, baseUri: _parsedUri);
    topics = TopicDataAccessObject(client: this, baseUri: _parsedUri);
    users = UserDataAccessObject(client: this, baseUri: _parsedUri);
  }

  Future<String> getAccessToken(String username, String password,
          {String? deviceName}) async =>
      await users.getAccessToken(username, password, deviceName: deviceName);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(headers);

    if (accessToken != null && accessToken!.isNotEmpty) {
      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
      });
    }

    return _client.send(request);
  }
}
