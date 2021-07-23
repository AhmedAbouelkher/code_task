import 'package:firebase_auth/firebase_auth.dart' as fire_auth;

abstract class BaseAuth {
  User? get currentUser;
  bool get isUserLoggedIn => currentUser != null;
  Future<User?> createUserWithEmailAndPassword({required String email, required String password});
  Future<User?> signInWithEmailAndPassword({required String email, required String password});
  Future<void> signOut();
  Future<void> updateUsername(String username);
  String? get username;
}

class User {
  final String? uid;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  const User({
    this.uid,
    this.email,
    this.displayName,
    this.phoneNumber,
  });

  static User? fromFirebaseAuth(fire_auth.User? firebaseUser) {
    if (firebaseUser == null) return null;
    return User(
      uid: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      email: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }
}

class FireAuth implements BaseAuth {
  final _auth = fire_auth.FirebaseAuth.instance;

  @override
  Future<User?> createUserWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final firebaseUser = userCred.user;
      return User.fromFirebaseAuth(firebaseUser);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final firebaseUser = userCred.user;
      return User.fromFirebaseAuth(firebaseUser);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  User? get currentUser => User.fromFirebaseAuth(_auth.currentUser);

  @override
  bool get isUserLoggedIn => currentUser != null;

  @override
  Future<void> updateUsername(String username) {
    // TODO: implement updateUsername
    throw UnimplementedError();
  }

  @override
  // TODO: implement username
  String? get username => throw UnimplementedError();
}
