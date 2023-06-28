import '../data_access_object.dart';
import '../model/unmanaged_reddit_host.dart';

class UnmanagedRedditHostDataAccessObject
    extends DataAccessObject<UnmanagedRedditHost> {
  static UnmanagedRedditHostDataAccessObject?
      _unmanagedRedditHostDataAccessObject;

  UnmanagedRedditHostDataAccessObject._()
      : super(resource: 'unmanagedreddithosts');

  factory UnmanagedRedditHostDataAccessObject() {
    return _unmanagedRedditHostDataAccessObject ??=
        UnmanagedRedditHostDataAccessObject._();
  }
}
