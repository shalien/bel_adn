

part of '../model.dart';

final class Supplier extends Model {

  final String host;

  const Supplier(this.host) : super();

  Supplier.fromJson(super.json) :
        host = json['host'], super.fromJson();

  @override
  Supplier copyWith({String? host}) {
    return Supplier(host ?? this.host);
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'host': host,
    });
  }

}