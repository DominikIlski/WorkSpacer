import 'package:firebase_auth/firebase_auth.dart';
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
  logIn(String email, String password) async {
    inProgress = true;
    var userCred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    var user = userCred.user;
    var token = await user!.getIdTokenResult(true);
    userId = token.claims!['strapiId'];
    isAdmin =  token.claims!['admin'];
    inProgress = false;
  }

  @action
  logOut() {
    FirebaseAuth.instance.signOut();
    userId = null;
    isAdmin = false;
  }
}
