import 'package:mobx/mobx.dart';
import 'package:work_spacer/models/filter.dart';
import 'package:work_spacer/models/user.dart';
import 'package:work_spacer/stores/filter_store.dart';

part 'role_management_store.g.dart';

class RoleManagementStore = _RoleManagementStore with _$RoleManagementStore;

abstract class _RoleManagementStore with Store {
  final FilterStore filterStore = FilterStore([
    FilterParameter.id,
    FilterParameter.name,
    FilterParameter.surname,
  ]);

  @observable
  bool inProgress = false;

  @observable
  ObservableList<User>? _users;

  @computed
  ObservableList<User> get users => ObservableList.of(
        (_users ?? <User>[]).where((user) {
          final isIdValid = _checkFilterEqual(FilterParameter.id, user.id);
          final isNameValid =
              _checkFilterEqual(FilterParameter.name, user.name.toLowerCase());
          final isSurnameValid = _checkFilterEqual(
              FilterParameter.surname, user.surname.toLowerCase());

          return isIdValid && isNameValid && isSurnameValid;
        }).toList(),
      );

  bool _checkFilterEqual(FilterParameter filter, dynamic userAttribute) {
    final filterValue = filterStore.filters[filter];
    if (filterValue != null && filterValue != userAttribute) {
      return false;
    } else {
      return true;
    }
  }

  @action
  fetchUsers() async {
    inProgress = true;
    //TODO handle backend
    await Future.delayed(const Duration(milliseconds: 500));
    _users = ObservableList.of(
      usersDummy..sort((user1, user2) => user1.compareTo(user2)),
    );
    inProgress = false;
  }

  @action
  setUserRole(User user, Role role) {
    //TODO handle backend
    _users?.singleWhere((element) => element == user).setRole(role);
  }
}

final List<User> usersDummy = [
  User(
    id: 1,
    name: "John",
    surname: "Kowalsky",
    role: Role.senior,
  ),
  User(
    id: 2,
    name: "Mark",
    surname: "Zucker",
    role: Role.intern,
  ),
  User(
    id: 3,
    name: "Donna",
    surname: "Paulsen",
    role: Role.executive,
  ),
  User(
    id: 4,
    name: "Chris",
    surname: "Bacon",
    role: Role.mid,
  ),
];
