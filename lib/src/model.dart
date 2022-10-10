abstract class Model {
  int? id;

  DateTime? createdAt;

  DateTime? updatedAt;

  Model({this.id, this.createdAt, this.updatedAt});

  Model.fromJson(Map json) {
    id = json['id'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  String toJson();
}
