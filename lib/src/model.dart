import 'dart:convert';

import 'package:meta/meta.dart';

part 'model/destination.dart';
part 'model/media.dart';
part 'model/provider_type.dart';
part 'model/source.dart';
part 'model/topic.dart';
part 'model/user.dart';
part 'model/path.dart';
part 'model/supplier.dart';
part 'model/search.dart';

@immutable
abstract base class Model {
  final int id;

  final DateTime createdAt;

  final DateTime updatedAt;

  final DateTime? deletedAt;

  const Model(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});

  Model.fromJson(final Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['created_at']),
        updatedAt = DateTime.parse(json['updated_at']),
        deletedAt = json['deleted_at'] != null
            ? DateTime.parse(json['deleted_at'])
            : null;

  @mustBeOverridden
  @mustCallSuper
  String toJson() {
    return jsonEncode({
      'id': id,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      ...?deletedAt != null ? {'deleted_at': deletedAt.toString()} : null,
    });
  }

  @override
  String toString() {
    return toJson();
  }

  @override
  @mustBeOverridden
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Model &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          deletedAt == other.deletedAt;

  @override
  @mustBeOverridden
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode;

  copyWith();
}
