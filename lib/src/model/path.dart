

part of '../model.dart';

final class Path extends Model {

  final String content;

  const Path(this.content) : super();

  Path.fromJson(super.json) :
        content = json['content'], super.fromJson();


  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'content': content,
    });
  }

  @override
  Model copyWith({String? content}) {
    return Path(
      content ?? this.content,
    );
  }

}