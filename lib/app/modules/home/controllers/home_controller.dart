import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/expense_model.dart';
import '../../../data/services/expense_service.dart';
import '../views/form_dialog.dart';

class HomeController extends GetxController {
  final _expenseService = ExpenseService();

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  final CollectionReference userDB = FirebaseFirestore.instance.collection(
    'users',
  );

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  void showAddDialog(BuildContext context) {
    showExpenseDialog(
      context: context,
      isEditing: false,
      titleController: titleController,
      amountController: amountController,
      categoryController: categoryController,
      onSubmit: (expense) async {
        await _expenseService.addExpense(userId, expense);
        Get.back();
      },
    );
  }

  void showEditDialog(BuildContext context, ExpenseModel expense) {
    titleController.text = expense.title;
    amountController.text = expense.amount.toString();
    categoryController.text = expense.category;

    showExpenseDialog(
      context: context,
      isEditing: true,
      titleController: titleController,
      amountController: amountController,
      categoryController: categoryController,
      onSubmit: (updatedExpense) async {
        final updatedWithId = ExpenseModel(
          id: expense.id,
          title: updatedExpense.title,
          amount: updatedExpense.amount,
          category: updatedExpense.category,
          time: DateTime.now(),
        );
        await _expenseService.updateExpense(userId, updatedWithId);
        Get.back();
      },
    );
  }

  Stream<double> totalExpenses() {
    final expensesRef = userDB.doc(userId).collection('expenses');

    return expensesRef.snapshots().map((snapshot) {
      double sum = 0;
      for (var doc in snapshot.docs) {
        sum += (doc['amount'] ?? 0).toDouble();
      }
      return sum;
    });
  }
}
