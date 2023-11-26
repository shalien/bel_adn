import 'dart:convert';

part 'model/destination.dart';
part 'model/media.dart';
part 'model/provider_type.dart';
part 'model/source.dart';
part 'model/topic.dart';
part 'model/user.dart';
part 'model/path.dart';
part 'model/supplier.dart';

abstract base class Model {
  final int? id;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  const Model._internal(this.id, this.createdAt, this.updatedAt);

  const Model() : this._internal(null, null, null);

  Model.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        updatedAt = json['updated_at'] != null
            ? DateTime.parse(json['updated_at'])
            : null;

  String toJson();

  @override
  String toString() {
    return toJson();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Model &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => id.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;

  Model copyWith();
}
