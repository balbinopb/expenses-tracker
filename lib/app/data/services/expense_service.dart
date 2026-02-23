import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/expense_model.dart';

class ExpenseService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  Future<void> addExpense(String userId, ExpenseModel expense) async {
    final docRef = await _usersCollection
        .doc(userId)
        .collection('expenses')
        .add(expense.toMap());

    await docRef.update({'id': docRef.id});
  }

  Stream<List<ExpenseModel>> getExpenses(String userId) {
    final expensesCollection = _usersCollection
        .doc(userId)
        .collection('expenses');

    return expensesCollection
        .orderBy('time', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ExpenseModel.fromDocumentSnapshot(doc))
              .toList(),
        );
  }

  Future<void> updateExpense(String userId, ExpenseModel expense) async {
    // print("test=======working===================");

    await _usersCollection
        .doc(userId)
        .collection('expenses')
        .doc(expense.id)
        .update(expense.toMap());
  }

  Future<void> deleteExpense(String userId, String expenseId) async {
    await _usersCollection
        .doc(userId)
        .collection('expenses')
        .doc(expenseId)
        .delete();
  }


}
