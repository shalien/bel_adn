import 'dart:convert';

import 'package:bel_adn/src/client/bel_adn_client.dart';
import 'package:meta/meta.dart';

import '../models.dart';
import 'model.dart';

@immutable
abstract class DataAccessObject<T extends Model> {
  final String resource;

  final String host;

  final BelAdnClient client = BelAdnClient();

  final Cache<T> cache = Cache<T>();

  final Map<String, String> headers = <String, String>{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  String get resourceUrl => "$host/api/$resource";

  DataAccessObject(this.host, this.resource);

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
            }
          }
        }
      }

      return models;
    } else {
      throw Exception(response);
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
      throw Exception(response);
    }

    var jsonDecoded = json.decode(response.body);

    if (jsonDecoded['data'] == null) {
      throw Exception(response);
    }

    switch (T) {
      case Destination:
        return Destination.fromJson(jsonDecoded['data']) as T;
      case Media:
        return Media.fromJson(jsonDecoded['data']) as T;
      case ProviderType:
        return ProviderType.fromJson(jsonDecoded['data']) as T;
      case Provider:
        return Provider.fromJson(jsonDecoded['data']) as T;
      case Source:
        return Source.fromJson(jsonDecoded['data']) as T;
      case Topic:
        return Topic.fromJson(jsonDecoded['data']) as T;
      case UnmanagedRedditHost:
        return UnmanagedRedditHost.fromJson(jsonDecoded['data']) as T;
    }

    throw Exception(response);
  }

  Future<bool> update(T t);

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

    switch (T) {
      case Destination:
        return Destination.fromJson(jsonDecoded['data']) as T;
      case Media:
        return Media.fromJson(jsonDecoded['data']) as T;
      case ProviderType:
        return ProviderType.fromJson(jsonDecoded['data']) as T;
      case Provider:
        return Provider.fromJson(jsonDecoded['data']) as T;
      case Source:
        return Source.fromJson(jsonDecoded['data']) as T;
      case Topic:
        return Topic.fromJson(jsonDecoded['data']) as T;
      case UnmanagedRedditHost:
        return UnmanagedRedditHost.fromJson(jsonDecoded['data']) as T;
    }

    throw Exception('Unknown type');
  }

  Future<bool> destroy(T t) async {
    if (cache.get(t.id!) != null) {
      cache.remove(t.id!);
    }

    String uri = '$resourceUrl/${t.id}';
    Uri url = Uri.parse(uri);

    var response = await client.delete(url, headers: headers);

    return response.statusCode == 200;
  }
}
