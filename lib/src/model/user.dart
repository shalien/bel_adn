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

  User.fromJson(super.json, {super.client})
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

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is User &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt &&
            snowflake == other.snowflake &&
            name == other.name &&
            email == other.email &&
            password == other.password;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      snowflake.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode;
}
