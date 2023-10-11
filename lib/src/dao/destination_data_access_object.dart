import 'package:http/http.dart';

import '../data_access_object.dart';
import '../model/destination.dart';

final class DestinationDataAccessObject extends DataAccessObject<Destination> {
  static DestinationDataAccessObject? _destinationDataAccessObject;

  DestinationDataAccessObject._(String host, Client client)
      : super(resource: "destinations", host: host, client: client);

  factory DestinationDataAccessObject(String host, Client client) {
    return _destinationDataAccessObject ??=
        DestinationDataAccessObject._(host, client);
  }
}
