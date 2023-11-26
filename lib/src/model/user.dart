part of '../model.dart';

final class User extends Model {
  final int? snowflake;

  final String name;

  final String? email;

  final String? password;

  static String generateEmail() =>
      '${String.fromCharCodes(List.generate(16, (index) => DateTime.now().microsecondsSinceEpoch.toString().codeUnitAt(index)))}@example.null';

  static String generatePassword() => String.fromCharCodes(List.generate(
      16,
      (index) =>
          DateTime.now().microsecondsSinceEpoch.toString().codeUnitAt(index)));

  const User(this.name, this.snowflake, this.email, this.password) : super();

  User.fromJson(super.json)
      : snowflake = json['snowflake'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        super.fromJson();

  @override
  Model copyWith(
      {int? snowflake, String? name, String? email, String? password}) {
    return User(
      name ?? this.name,
      snowflake ?? this.snowflake,
      email ?? this.email,
      password ?? this.password,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...?id != null ? {'id': id} : null,
      ...?createdAt != null ? {'created_at': createdAt.toString()} : null,
      ...?updatedAt != null ? {'updated_at': updatedAt.toString()} : null,
      'snowflake': snowflake,
      'name': name,
      'email': email,
      'password': password,
    });
  }
}
