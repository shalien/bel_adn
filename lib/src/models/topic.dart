import 'dart:convert';

import '../model.dart';

class Topic extends Model {
  final String _name;

  String get name => _name;

  final int _order;

  int get order => _order;

  Topic(this._name, this._order, {id, createdAt, updatedAt})
      : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  Topic.fromJson(Map json)
      : _name = json['name'],
        _order = json['order'],
        super.fromJson(json);

  @override
  String toJson() {
    return json.encode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt} : null,
      'name': name,
      'order': order
    });
  }
}
