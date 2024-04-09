part of '../model.dart';

@immutable
final class User extends Model {
  final int? snowflake;

  final String name;

  final String? email;

  final String? password;

  const User({
    required this.snowflake,
    required this.name,
    required this.email,
    required this.password,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
  });

  User.fromJson(super.json)
      : snowflake = json['snowflake'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        super.fromJson();

  @override
  User copyWith(
      {int? snowflake, String? name, String? email, String? password}) {
    return User(
      snowflake: snowflake ?? this.snowflake,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      id: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  @override
  String toJson() {
    return jsonEncode({
      ...jsonDecode(super.toJson()),
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
            super == (other) &&
            snowflake == other.snowflake &&
            name == other.name &&
            email == other.email &&
            password == other.password;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      snowflake.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode;
}
