import '../data_access_object.dart';
import '../model/destination.dart';

class DestinationDataAccessObject extends DataAccessObject<Destination> {
  static DestinationDataAccessObject? _destinationDataAccessObject;

  DestinationDataAccessObject._() : super(resource: "destinations");

  factory DestinationDataAccessObject() {
    return _destinationDataAccessObject ??= DestinationDataAccessObject._();
  }
}
