import '../models/unmanaged_reddit_host.dart';
import 'data_access_object.dart';

UnmanagedRedditHostDataAccessObject? _unmanagedRedditHostDataAccessObject;

class UnmanagedRedditHostDataAccessObject
    extends DataAccessObject<UnmanagedRedditHost> {
  UnmanagedRedditHostDataAccessObject._(String host)
      : super(host, 'unmanagedreddithosts');

  factory UnmanagedRedditHostDataAccessObject(String host) {
    return _unmanagedRedditHostDataAccessObject ??=
        UnmanagedRedditHostDataAccessObject._(host);
  }

  @override
  Future<bool> update(UnmanagedRedditHost t) {
    throw UnimplementedError();
  }
}
