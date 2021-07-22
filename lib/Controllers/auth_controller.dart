import 'package:code_task/Helpers/PreferencesUtils/preferences_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:code_task/Helpers/exceptions.dart';
import 'package:code_task/Helpers/regex.dart';

///Client's Username DB ID key.
const kUsernameKey = "user_name_key";

///Used as auth controller and a mid layer between Firebase Auth and the app itself.
///
///Used with `provider` as `ChangeNotifier` class.
///
///Always use the static mehtode `AuthController.get(BuildContext)` to get an read only instance.
///Use `AuthController.watch(BuildContext)` to get real-time updates.
class AuthController extends ChangeNotifier {
  ///Retuns a read-only shared instance of the class `AuthController`.
  static AuthController get(BuildContext context) => context.read<AuthController>();

  ///Whatchs changes in a shared instance of the class `AuthController`.
  static AuthController watch(BuildContext context) => context.watch<AuthController>();

  ///Returns an instance using the default [FirebaseApp].
  final _auth = FirebaseAuth.instance;

  //? Register user
  ///Registers an new user with his `email` and `password`.
  ///
  ///returns `UserCredential` which contains current user meta data.
  ///
  ///Exceptions:
  ///- `WeakPasswordException()`: user entered a weak password.
  ///- `EmailAlreadyUsedException()`: user entered an invalid email.
  ///
  ///See also:
  ///- `isValidPassword(String)`.
  ///- `isValidEmail(String)`.
  ///
  Future<UserCredential?> registerUser(String email, String password) async {
    assert(isValidPassword(password),
        "You provided an invalid user password, password must has at least on character and its lenth > 6.");
    assert(isValidEmail(email), "You should provide a valid user E-mail.");
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyUsedException();
      }
    } catch (e) {
      rethrow;
    }
  }

  //? Login user
  ///Login an old user with his `email` and `password`.
  ///
  ///returns `UserCredential` which contains current user meta data.
  ///
  ///Exceptions:
  ///- `WeakPasswordException()`: user entered a weak password.
  ///- `EmailAlreadyUsedException()`: user entered an invalid email.
  ///
  ///See also:
  ///- `isValidPassword(String)`.
  ///- `isValidEmail(String)`.
  ///
  Future<UserCredential?> loginUser(String email, String password) async {
    // assert(isValidPassword(password),
    //     "You provided an invalid user password, password must has at least on character and its lenth > 6.");
    assert(isValidEmail(email), "You should provide a valid user E-mail.");
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyUsedException();
      }
    }
  }

  //? Logout user
  ///Signs out the current user.
  Future<void> logout() async {
    return await FirebaseAuth.instance.signOut();
  }

  //? Get current user data
  ///Returns the current [User] if they are currently signed-in, or null if not.
  User? get currentUser => _auth.currentUser;

  ///Checks wheather there is a current used signed in or not.
  bool get isUserLoggedIn => currentUser != null;

  //? Change username
  ///Updates currrent username localy.
  Future<void> updateUsername(String username) async {
    assert(username.length > 4, "Username have to be more than 4 characters in lenght.");
    assert(PreferenceUtils.instance != null,
        "PreferenceUtils wasn't initialized, Did you forget to call `PreferenceUtils.init()`?");
    final _currentUsername = this.username;
    if (_currentUsername == username) return;
    await PreferenceUtils.instance!.saveValueWithKey<String>(kUsernameKey, username);
    _username = username;
    notifyListeners();
  }

  //? Get username
  String? _username;

  ///Current user's Username.
  String? get username {
    if (_username != null) return _username;
    final _savedUsername = PreferenceUtils.instance!.getValueWithKey<String>(kUsernameKey);
    _username = _savedUsername;
    return _username;
  }
}
