import 'dart:convert';

import 'package:bel_adn/src/model/guild.dart';
import 'package:bel_adn/src/model/prohibited_domain.dart';
import 'package:bel_adn/src/model/user.dart';
import 'package:http/http.dart';

import 'cache/cache.dart';
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

abstract base class DataAccessObject<T extends Model> {
  final String resource;

  final Cache<T> cache = Cache<T>();

  final Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  final String host;

  final Client client;

  String get resourceUrl => "$host/api/$resource";

  DataAccessObject(
      {required this.resource, required this.host, required this.client});

  Future<Set<T>> index() async {
    Uri url = Uri.parse(resourceUrl);

    var response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      var decodedResponse = jsonDecode(response.body);

      Set<T> models = <T>{};

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
              case User:
                models.add(User.fromJson(element) as T);
                break;
              case Guild:
                models.add(Guild.fromJson(element) as T);
                break;
              case ProhibitedDomain:
                models.add(ProhibitedDomain.fromJson(element) as T);
                break;
              default:
                throw Exception('Unknown type');
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
      throw response;
    }

    var jsonDecoded = json.decode(response.body);

    if (jsonDecoded['data'] == null) {
      throw response;
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
      case User:
        value = User.fromJson(data) as T;
        break;
      case Guild:
        value = Guild.fromJson(data) as T;
        break;
      case ProhibitedDomain:
        value = ProhibitedDomain.fromJson(data) as T;
        break;
      default:
        throw Exception('Unknown type');
    }

    return value;
  }
}
