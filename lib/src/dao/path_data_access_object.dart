

part of '../data_access_object.dart';

final class PathDataAccessObject extends DataAccessObject<Path> {

  const PathDataAccessObject(MagnifiqueCoupleClient client) : super('paths', client);

  @override
  Path fromJson(Map<String, dynamic> json) {
    return Path.fromJson(json);
  }

}