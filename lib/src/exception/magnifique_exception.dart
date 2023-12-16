import 'package:http/http.dart';
import 'package:meta/meta.dart';

@immutable
final class MagnifiqueException implements Exception {
  final Response response;

  String get message => response.body;
  int get statusCode => response.statusCode;

  const MagnifiqueException(this.response);

  @override
  String toString() {
    return 'MagnifiqueException : {code: $statusCode,  message: $message}';
  }
}
