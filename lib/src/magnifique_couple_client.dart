import 'package:http/http.dart';

import '../src/data_access_object.dart';

class MagnifiqueCoupleClient extends BaseClient {
  final Client _client;

  final String accessToken;

  static String host = 'magnifiquecouple.projetretro.io';

  late final DestinationDataAccessObject destinations;

  late final MediaDataAccessObject medias;

  late final ProviderTypeDataAccessObject providerTypes;

  late final SourceDataAccessObject sources;

  late final TopicDataAccessObject topics;

  late final UserDataAccessObject users;

  late final PathDataAccessObject paths;

  late final SupplierDataAccessObject suppliers;

  final Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'user-agent': 'bel_adn:cbJKqzlZ8soXvU_tvP5KWw:3.0.1 u/Shalien93',
  };

  MagnifiqueCoupleClient(this.accessToken, {Client? client})
      : _client = client ?? Client() {
    destinations = DestinationDataAccessObject(this);
    medias = MediaDataAccessObject(this);
    providerTypes = ProviderTypeDataAccessObject(this);
    sources = SourceDataAccessObject(this);
    topics = TopicDataAccessObject(this);
    paths = PathDataAccessObject(this);
    suppliers = SupplierDataAccessObject(this);
    users = UserDataAccessObject(this);

    if (accessToken.isEmpty) {
      throw ArgumentError.value(accessToken, 'accessToken', 'Cannot be empty');
    }

    headers.addAll({'Authorization': 'Bearer $accessToken'});
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(headers);
    return _client.send(request);
  }
}
