import 'package:expenses_tracker/models/user_model.dart';
import 'package:expenses_tracker/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService(); //create instance userService

  //REGISTER
  Future<User?> register(String name, String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
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
  Future<User?> login(String email, String password) async {
    try {
      final credendial = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credendial.user;
    } catch (e) {
      rethrow;
    }
  }

  //LOGOUT
  Future<void> logOut() async {
    await _auth.signOut();
  }

  //CURRENT USER
  User? get currentUser => _auth.currentUser;
}
