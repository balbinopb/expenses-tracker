import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/expense_model.dart';
import '../../../data/services/expense_service.dart';
import '../views/form_dialog.dart';

class HomeController extends GetxController {
  final expenseService = ExpenseService();
  final String userId = FirebaseAuth.instance.currentUser!.uid;

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
        await expenseService.addExpense(userId, expense);
        Get.back();
      },
    );
  }

  void showEditDialog(BuildContext context,ExpenseModel expense) {
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
        await expenseService.updateExpense(userId, updatedExpense);
        Get.back();
      },
    );
  }
}
