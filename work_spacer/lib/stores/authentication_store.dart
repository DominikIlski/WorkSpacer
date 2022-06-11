import 'package:mobx/mobx.dart';

part 'authentication_store.g.dart';

class AuthenticationStore = _AuthenticationStore with _$AuthenticationStore;

abstract class _AuthenticationStore with Store {
  @observable
  int? userId;

  @observable
  bool isAdmin = false;

  @observable
  bool inProgress = false;

  @action
  logIn() async {
    inProgress = true;
    //TODO: handle backend
    await Future.delayed(const Duration(seconds: 2));
    userId = 1;
    isAdmin = false;
    //CHANGE ^ FROM BACKEND
    inProgress = false;
  }

  @action
  logOut() {
    //TODO: handle backend
    userId = null;
    isAdmin = false;
  }
}
