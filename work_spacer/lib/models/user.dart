import 'package:mobx/mobx.dart';

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

const Map<Role, String> roleNames = {
  Role.senior: 'Senior',
  Role.officeAdministrator: 'Office Administrator',
  Role.executive: 'Executive',
  Role.mid: 'Mid',
  Role.junior: 'Junior',
  Role.intern: 'Intern',
};
