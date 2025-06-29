

import 'package:expenses_tracker/models/expense_model.dart';
import 'package:expenses_tracker/screens/home/expense_form_dialog.dart';
import 'package:expenses_tracker/services/expense_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final expenseService = ExpenseService();
  final String userId = FirebaseAuth.instance.currentUser!.uid;


    void showAddDialog() {
    showExpenseDialog(
      context: Get.context!,
      isEditing: false,
      titleController: titleController,
      amountController: amountController,
      categoryController: categoryController,
      onSubmit: (expense) async {
        await expenseService.addExpense(userId, expense);
        Navigator.pop(Get.context!);
      },
    );
  }


  
  void showEditDialog(ExpenseModel expense) {
    titleController.text = expense.title;
    amountController.text = expense.amount.toString();
    categoryController.text = expense.category;

    showExpenseDialog(
      context: Get.context!,
      isEditing: true,
      titleController: titleController,
      amountController: amountController,
      categoryController: categoryController,
      onSubmit: (updatedExpense) async {
        await expenseService.updateExpense(userId, updatedExpense);
        // ignore: use_build_context_synchronously
        Navigator.pop(Get.context!);
      },
    );
  }
  
}