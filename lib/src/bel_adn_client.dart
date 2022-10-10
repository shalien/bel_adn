import 'dart:convert';

import 'package:http/http.dart';

import 'utils.dart';

Future<Response> head(Uri url, {Map<String, String>? headers}) =>
    BelAdnClient().head(url, headers: headers);

Future<Response> get(Uri url, {Map<String, String>? headers}) =>
    BelAdnClient().get(url, headers: headers);

Future<Response> post(Uri url,
        {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
    BelAdnClient().post(url, headers: headers, body: body, encoding: encoding);

Future<Response> put(Uri url,
        {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
    BelAdnClient().put(url, headers: headers, body: body, encoding: encoding);

Future<Response> patch(Uri url,
        {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
    BelAdnClient().patch(url, headers: headers, body: body, encoding: encoding);

Future<Response> delete(Uri url,
        {Map<String, String>? headers, Object? body, Encoding? encoding}) =>
    BelAdnClient()
        .delete(url, headers: headers, body: body, encoding: encoding);

class BelAdnClient extends BaseClient {
  final Client _inner = Client();

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) {
    headers == null
        ? headers = {'user-agent': userAgent}
        : headers['user-agent'] = userAgent;
    return super.head(url, headers: headers);
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) {
    headers == null
        ? headers = {'user-agent': userAgent}
        : headers['user-agent'] = userAgent;
    return super.get(url, headers: headers);
  }

  @override
  Future<Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    headers == null
        ? headers = {'user-agent': userAgent}
        : headers['user-agent'] = userAgent;
    return super.post(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    headers == null
        ? headers = {'user-agent': userAgent}
        : headers['user-agent'] = userAgent;
    return super.put(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    headers == null
        ? headers = {'user-agent': userAgent}
        : headers['user-agent'] = userAgent;
    return super.patch(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    headers == null
        ? headers = {'user-agent': userAgent}
        : headers['user-agent'] = userAgent;
    return super.delete(url, headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers['user-agent'] = userAgent;
    return _inner.send(request);
  }
}
