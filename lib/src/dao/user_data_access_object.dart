import 'package:http/http.dart';

import '../data_access_object.dart';
import '../model/user.dart';

final class UserDataAccessObject extends DataAccessObject<User> {
  static UserDataAccessObject? _userDataAccessObject;

  factory UserDataAccessObject(String host, Client client) {
    return _userDataAccessObject ??= UserDataAccessObject._(host, client);
  }

  UserDataAccessObject._(String host, Client client)
      : super(resource: 'users', host: host, client: client);
}
