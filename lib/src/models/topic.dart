import 'dart:convert';

import '../dao/model.dart';

class Topic extends Model {
  final String _name;

  String get name => _name;

  final int _order;

  int get order => _order;

  Topic(this._name, this._order, {id}) : super(id: id);

  factory Topic.fromJson(Map json) {
    return Topic(json['name'], json['order'], id: json['id']);
  }

  @override
  String toJson() {
    return json.encode({
      ...?id != null ? {'id': id} : null,
      'name': name,
      'order': order
    });
  }
}
