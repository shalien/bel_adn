part of '../model.dart';

@immutable
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

  const User._internal(
      super.id,
      super.createdAt,
      super.updatedAt,
      super.deletedAt,
      this.snowflake,
      this.name,
      this.email,
      this.password,
      super.client)
      : super._internal();

  User.fromJson(super.json, super.client)
      : snowflake = json['snowflake'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        super.fromJson();

  @override
  User copyWith(
      {int? snowflake, String? name, String? email, String? password}) {
    return User._internal(
        id,
        createdAt,
        updatedAt,
        deletedAt,
        snowflake ?? this.snowflake,
        name ?? this.name,
        email ?? this.email,
        password ?? this.password,
        _client);
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
