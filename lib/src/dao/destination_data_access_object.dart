import '../models/destination.dart';
import 'data_access_object.dart';

DestinationDataAccessObject? _destinationDataAccessObject;

class DestinationDataAccessObject extends DataAccessObject<Destination> {
  DestinationDataAccessObject._(String host) : super(host, "destinations");

  factory DestinationDataAccessObject(String host) {
    return _destinationDataAccessObject ??= DestinationDataAccessObject._(host);
  }

  @override
  Future<bool> update(Destination t) {
    throw UnimplementedError();
  }
}
