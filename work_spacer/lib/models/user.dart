import 'package:mobx/mobx.dart';
import 'package:work_spacer/i18n.dart';

part 'user.g.dart';

class User = _User with _$User;

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
  senior,
  officeAdministrator,
  executive,
  mid,
  junior,
  intern,
}

final Map<Role, String> roleNames = {
  Role.senior: translate.senior,
  Role.officeAdministrator: translate.offAdmin,
  Role.executive: translate.executive,
  Role.mid: translate.mid,
  Role.junior: translate.junior,
  Role.intern: translate.intern,
};
