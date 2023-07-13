import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:http/io_client.dart';

Future<Response> head(Uri url, {Map<String, String>? headers}) =>
    BelAdnClient().head(url, headers: headers);

Future<Response> get(Uri url, {Map<String, String>? headers}) =>
    BelAdnClient().get(url, headers: headers);

Future<Response> post(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) =>
    BelAdnClient().post(url, headers: headers, body: body, encoding: encoding);

Future<Response> put(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) =>
    BelAdnClient().put(url, headers: headers, body: body, encoding: encoding);

Future<Response> patch(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) =>
    BelAdnClient().patch(url, headers: headers, body: body, encoding: encoding);

Future<Response> delete(
  Uri url, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) =>
    BelAdnClient()
        .delete(url, headers: headers, body: body, encoding: encoding);

final class BelAdnClient extends BaseClient {
  static final Map<String, String> defaultHeaders = {
    'user-agent': 'bel_adn:cbJKqzlZ8soXvU_tvP5KWw:2.0.0 u/Shalien93'
  };

  static final HttpClient _innerHttpClient = HttpClient()
    ..badCertificateCallback = (cert, host, port) =>
        host.toLowerCase().contains('projetretro') ? true : false;

  static final BelAdnClient _instance = BelAdnClient._();

  Client _inner;

  BelAdnClient._() : _inner = RetryClient(IOClient(_innerHttpClient));

  factory BelAdnClient() {
    return _instance;
  }

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) {
    headers == null ? headers = defaultHeaders : headers.addAll(defaultHeaders);
    return super.head(url, headers: headers);
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) {
    headers == null ? headers = defaultHeaders : headers.addAll(defaultHeaders);
    return super.get(url, headers: headers);
  }

  @override
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    headers == null ? headers = defaultHeaders : headers.addAll(defaultHeaders);

    return super.post(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    headers == null ? headers = defaultHeaders : headers.addAll(defaultHeaders);

    return super.put(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    headers == null ? headers = defaultHeaders : headers.addAll(defaultHeaders);

    return super.patch(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    headers == null ? headers = defaultHeaders : headers.addAll(defaultHeaders);

    return super.delete(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(defaultHeaders);

    Future<StreamedResponse> response;

    try {
      response = _inner.send(request);
    } catch (e) {
      print((e as Exception).toString());
      response = send(request);
    }

    return response;
  }
}
