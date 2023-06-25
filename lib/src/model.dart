import 'data_access_object.dart';

abstract class Model {
  static late DataAccessObject dao;

  int? id;

  DateTime? createdAt;

  DateTime? updatedAt;

  Model({this.id, this.createdAt, this.updatedAt});

  Model.fromJson(Map<String, dynamic> json);

  String toJson();

  Future<Model> store() {
    return dao.store(this);
  }

  Future<bool> update() {
    return dao.update(this);
  }

  Future<bool> destroy() {
    return dao.destroy(this);
  }
}
