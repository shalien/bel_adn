

import 'package:http/http.dart';

class MagnifiqueException implements Exception {
  final Response response;

  String get  message => response.body;
  int get code => response.statusCode;

  MagnifiqueException(this.response);

  @override
  String toString() {
    return 'MagnifiqueException{message: $message, code: $code}';
  }
}