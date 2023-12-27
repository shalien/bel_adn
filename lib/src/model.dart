import 'dart:convert';

import 'package:bel_adn/bel_adn.dart';
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
  final int? id;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final DateTime? deletedAt;

  final MagnifiqueCoupleClient? _client;

  const Model._internal(this.id, this.createdAt, this.updatedAt, this.deletedAt,
      [MagnifiqueCoupleClient? client])
      : _client = client;

  const Model() : this._internal(null, null, null, null, null);

  Model.fromJson(final Map<String, dynamic> json,
      [MagnifiqueCoupleClient? client])
      : id = json['id'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        deletedAt = json['deleted_at'] != null
            ? DateTime.parse(json['deleted_at'])
            : null,
        _client = client;

  @mustBeOverridden
  @mustCallSuper
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
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
      deletedAt.hashCode ^
      _client.hashCode;

  Model copyWith();
}
