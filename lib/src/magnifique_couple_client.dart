import 'package:http/http.dart';

import '../src/data_access_object.dart';

class MagnifiqueCoupleClient extends BaseClient {
  final Client _client;

  String? accessToken;

  final String host;

  Uri _parsedUri;

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
      {required this.host,
      required this.accessToken,
      Client? client})
      : _client = client ?? Client(), _parsedUri = Uri.parse(host) {
    destinations = DestinationDataAccessObject(this, _parsedUri);
    medias = MediaDataAccessObject(this, _parsedUri);
    providerTypes = ProviderTypeDataAccessObject(this, _parsedUri);
    sources = SourceDataAccessObject(this, _parsedUri);
    topics = TopicDataAccessObject(this, _parsedUri);
    paths = PathDataAccessObject(this, _parsedUri);
    suppliers = SupplierDataAccessObject(this, _parsedUri);
    users = UserDataAccessObject(this, _parsedUri);
    searches = SearchDataAccessObject(this, _parsedUri);
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
