

import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';
import 'user_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final UserService _userService = UserService();

  //REGISTER
  Future<User?> createUserWithEmailPassword({required String name,required String email,required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        final userModel = UserModel(uId: user.uid, name: name, email: email);

        await _userService.addUser(userModel);
      }

      return user;
    } catch (e) {
      rethrow;
    }
  }

  //LOGIN
  Future<UserCredential> signInWithEmailPassword({required String email,required String password}) async {
    try {
      final credendial = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credendial;
    } catch (e) {
      rethrow;
    }
  }

  //LOGOUT
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  //CURRENT USER
  User? get currentUser => _firebaseAuth.currentUser;
}