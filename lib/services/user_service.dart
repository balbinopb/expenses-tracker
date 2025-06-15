
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_tracker/models/user_model.dart';

class UserService {
  final CollectionReference userCollection= FirebaseFirestore.instance.collection('users');


  //CREATE/ADD USER TO FIRESTORE COLLECTION
  Future<void> addUser(UserModel user)async{
    await userCollection.doc(user.uId).set(user.toJson());
  }

  //READ
  Stream<List<UserModel>> getAllUser(){
    return userCollection.snapshots().map((snapshot){
      return snapshot.docs.map((doc){
        return UserModel.fromJson(doc.data() as Map<String ,dynamic>);
      }).toList();
    });
  }

  //UPDATE
  Future<void> updateUser(UserModel user)async{
    await userCollection.doc(user.uId).update(user.toJson());
  }

  //DELETE
  Future<void> deleteUser(String id)async{
    await userCollection.doc(id).delete();
  }

}