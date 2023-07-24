abstract class Model {
  int? id;

  DateTime? createdAt;

  DateTime? updatedAt;

  Model({this.id, this.createdAt, this.updatedAt});

  Model.fromJson(Map<String, dynamic> json);

  String toJson();

  @override
  operator ==(other) => (other is Model && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
