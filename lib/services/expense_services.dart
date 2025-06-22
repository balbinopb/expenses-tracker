import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense_model.dart';

class ExpenseService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  Future<void> addExpense(String userId, ExpenseModel expense) async {
    await _usersCollection
        .doc(userId)
        .collection('expenses')
        .add(expense.toMap());
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
    await _usersCollection
        .doc(userId)
        .collection('expenses')
        .doc(
          expense.id,
        ) 
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
