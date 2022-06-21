import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';
import 'package:work_spacer/i18n.dart';

part 'user.g.dart';
// ignore: invalid_annotation_target
@JsonSerializable(explicitToJson: true)
class User extends _User with _$User{
  User({
    required super.id,
    required super.name,
    required super.surname,
    required super.role,
  });
   factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}

abstract class _User with Store {
  _User({
    required this.id,
    required this.name,
    required this.surname,
    required this.role,
  });

  final int id;
  final String name;
  final String surname;

  @observable
  @JsonKey(name: 'position')
  Role role;

  @action
  setRole(Role newRole) {
    role = newRole;
  }

  int compareTo(User other) {
    if (surname == other.surname) {
      if (name == other.name) {
        return roleNames[role]!.compareTo(roleNames[other.role]!);
      } else {
        return name.compareTo(other.name);
      }
    } else {
      return surname.compareTo(other.surname);
    }
  }
}

enum Role {
  @JsonValue('senior') senior,
  @JsonValue('officeAdministrator') officeAdministrator,
  @JsonValue('executive') executive,
  @JsonValue('mid') mid,
  @JsonValue('junior') junior,
  @JsonValue('intern') intern,
}

final Map<Role, String> roleNames = {
  Role.senior: translate.senior,
  Role.officeAdministrator: translate.offAdmin,
  Role.executive: translate.executive,
  Role.mid: translate.mid,
  Role.junior: translate.junior,
  Role.intern: translate.intern,
};
