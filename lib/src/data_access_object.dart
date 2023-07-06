import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:sha_env/sha_env.dart';

import 'cache/cache.dart';
import 'client/bel_adn_client.dart';
import 'model.dart';
import 'model/destination.dart';
import 'model/media.dart';
import 'model/provider.dart';
import 'model/provider_link.dart';
import 'model/provider_type.dart';
import 'model/source.dart';
import 'model/topic.dart';
import 'model/topic_alias.dart';
import 'model/unmanaged_reddit_host.dart';

@immutable
abstract class DataAccessObject<T extends Model> {
  static set host(String host) {
    try {
      Uri.parse(host);
    } catch (e) {
      throw Exception('Invalid host');
    }
    _host = host;
  }

  static String get host => _host;

  final String resource;

  static String _host = Platform.environment['MAGNIFIQUECOUPLE_HOST'] ??
      fromEnvironmentString('MAGNIFIQUECOUPLE_HOST',
          defaultValue: 'http://127.0.0.1:8000');

  final BelAdnClient client = BelAdnClient();

  final Cache<T> cache = Cache<T>();

  final Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  String get resourceUrl => "${DataAccessObject._host}/api/$resource";

  DataAccessObject({required this.resource});

  Future<List<T>> index() async {
    Uri url = Uri.parse(resourceUrl);

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);

      List<T> models = <T>[];

      if (decodedResponse['data'].isEmpty) {
        return models;
      }

      for (var element in decodedResponse['data']) {
        if (element['id'] != null) {
          if (cache.get(element['id']) != null) {
            models.add(cache.get(element['id'])!);
            continue;
          } else {
            switch (T) {
              case Destination:
                models.add(Destination.fromJson(element) as T);
                break;
              case Media:
                models.add(Media.fromJson(element) as T);
                break;
              case ProviderType:
                models.add(ProviderType.fromJson(element) as T);
                break;
              case Provider:
                models.add(Provider.fromJson(element) as T);
                break;
              case Source:
                models.add(Source.fromJson(element) as T);
                break;
              case Topic:
                models.add(Topic.fromJson(element) as T);
                break;
              case UnmanagedRedditHost:
                models.add(UnmanagedRedditHost.fromJson(element) as T);
                break;
              case ProviderLink:
                models.add(ProviderLink.fromJson(element) as T);
                break;
              case TopicAlias:
                models.add(TopicAlias.fromJson(element) as T);
                break;
            }
          }
        }
      }

      return models;
    } else {
      throw response;
    }
  }

  Future<T> show(int id) async {
    if (cache.get(id) != null) {
      return cache.get(id)!;
    }

    String uri = '$resourceUrl/$id';
    Uri url = Uri.parse(uri);

    var response = await client.get(url, headers: headers);

    if (response.statusCode != 200) {
      throw response;
    }

    var jsonDecoded = json.decode(response.body);

    if (jsonDecoded['data'] == null) {
      throw response;
    }

    T value = _resolveT(T, jsonDecoded['data']);

    cache.add(value);

    return value;
  }

  Future<T> update(T t) async {
    String uri = '$resourceUrl/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.put(url, body: t.toJson(), headers: headers);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    var jsonDecoded = json.decode(response.body);

    if (jsonDecoded['data'] == null) {
      throw Exception(response);
    }

    T value = _resolveT(T, jsonDecoded['data']);

    cache.replace(value);

    return value;
  }

  Future<T> store(T t) async {
    String uri = resourceUrl;
    Uri url = Uri.parse(uri);

    var response = await client.post(url, body: t.toJson(), headers: headers);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }

    var jsonDecoded = json.decode(response.body);

    if (jsonDecoded['data'] == null) {
      throw Exception(response);
    }

    T value = _resolveT(T, jsonDecoded['data']);

    cache.add(value);

    return value;
  }

  Future<bool> destroy(T t) async {
    if (cache.get(t.id!) != null) {
      cache.remove(t.id!);
    }

    String uri = '$resourceUrl/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.delete(url, headers: headers);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw response;
    }

    return true;
  }

  T _resolveT(Type t, data) {
    T value;

    switch (t) {
      case Destination:
        value = Destination.fromJson(data) as T;
        break;
      case Media:
        value = Media.fromJson(data) as T;
        break;
      case ProviderType:
        value = ProviderType.fromJson(data) as T;
        break;
      case Provider:
        value = Provider.fromJson(data) as T;
        break;
      case Source:
        value = Source.fromJson(data) as T;
        break;
      case Topic:
        value = Topic.fromJson(data) as T;
        break;
      case UnmanagedRedditHost:
        value = UnmanagedRedditHost.fromJson(data) as T;
        break;
      case ProviderLink:
        value = ProviderLink.fromJson(data) as T;
        break;
      case TopicAlias:
        value = TopicAlias.fromJson(data) as T;
        break;
      default:
        throw Exception('Unknown type');
    }

    return value;
  }
}
