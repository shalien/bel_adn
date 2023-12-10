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

abstract base class Model {
  final int? id;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final MagnifiqueCoupleClient? _client;

  const Model._internal(this.id, this.createdAt, this.updatedAt, this._client);

  const Model() : this._internal(null, null, null, null);

  Model.fromJson(Map<String, dynamic> json, {MagnifiqueCoupleClient? client})
      : id = json['id'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null,
        _client = client;

  String toJson();

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
          updatedAt == other.updatedAt;

  @override
  @mustBeOverridden
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;

  Model copyWith();
}
