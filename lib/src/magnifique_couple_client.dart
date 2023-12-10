import 'package:http/http.dart';

import '../src/data_access_object.dart';

class MagnifiqueCoupleClient extends BaseClient {
  final Client _client;

  String? accessToken;

  static String host = 'magnifiquecouple.projetretro.io';

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

  MagnifiqueCoupleClient({this.accessToken, Client? client})
      : _client = client ?? Client() {
    destinations = DestinationDataAccessObject(this);
    medias = MediaDataAccessObject(this);
    providerTypes = ProviderTypeDataAccessObject(this);
    sources = SourceDataAccessObject(this);
    topics = TopicDataAccessObject(this);
    paths = PathDataAccessObject(this);
    suppliers = SupplierDataAccessObject(this);
    users = UserDataAccessObject(this);
    searches = SearchDataAccessObject(this);

  }

  Future<String> getAccessToken(String username, String password, {String? deviceName}) async =>
      await users.getAccessToken(username, password, deviceName: deviceName);



  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(headers);

    if(accessToken != null && accessToken!.isNotEmpty) {
      request.headers.addAll({
        'Authorization': 'Bearer $accessToken',
    });
      }

    return _client.send(request);
  }
}
