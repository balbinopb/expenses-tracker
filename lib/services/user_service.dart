import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_tracker/models/user_model.dart';

class UserService {
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection('users');

  //CREATE/ADD USER TO FIRESTORE COLLECTION
  Future<void> addUser(UserModel user) async {
    await userCollection.doc(user.uId).set(user.toJson());
  }

  //READ
  Future<UserModel?> getUserById(String id) async {
    final doc = await userCollection.doc(id).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  //UPDATE
  Future<void> updateUser(UserModel user) async {
    await userCollection.doc(user.uId).update(user.toJson());
  }

  //DELETE
  Future<void> deleteUser(String id) async {
    await userCollection.doc(id).delete();
  }
}
