import 'package:http/http.dart';

import '../data_access_object.dart';
import '../model/unmanaged_reddit_host.dart';

final class UnmanagedRedditHostDataAccessObject
    extends DataAccessObject<UnmanagedRedditHost> {
  static UnmanagedRedditHostDataAccessObject?
      _unmanagedRedditHostDataAccessObject;

  UnmanagedRedditHostDataAccessObject._(String host, Client client)
      : super(resource: 'unmanaged_hosts', host: host, client: client);

  factory UnmanagedRedditHostDataAccessObject(String host, Client client) {
    return _unmanagedRedditHostDataAccessObject ??=
        UnmanagedRedditHostDataAccessObject._(host, client);
  }
}
