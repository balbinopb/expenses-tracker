import 'package:expenses_tracker/models/expense_model.dart';
import 'package:expenses_tracker/screens/home/expense_form_dialog.dart';
import 'package:expenses_tracker/screens/home/expense_list.dart';
import 'package:expenses_tracker/services/expense_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final expenseService = ExpenseService();
  final String userId = FirebaseAuth.instance.currentUser!.uid;


  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  void showAddDialog() {
    showExpenseDialog(
      context: context,
      isEditing: false,
      titleController: titleController,
      amountController: amountController,
      categoryController: categoryController,
      onSubmit: (expense) async {
        await expenseService.addExpense(userId, expense);
        Navigator.pop(context);
      },
    );
  }

  void showEditDialog(ExpenseModel expense) {
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
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ExpenseList(
        userId: userId,
        onEdit: showEditDialog,
      ),
    );
  }
}
