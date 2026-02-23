

import 'package:flutter/material.dart';

import '../../../data/model/expense_model.dart';

void showExpenseDialog({
  required BuildContext context,
  required bool isEditing,
  required TextEditingController titleController,
  required TextEditingController amountController,
  required TextEditingController categoryController,
  required Function(ExpenseModel) onSubmit,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(isEditing ? "Edit Expense" : "Add Expense"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: amountController,
            decoration: const InputDecoration(labelText: "Amount"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: categoryController,
            decoration: const InputDecoration(labelText: "Category"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            titleController.clear();
            amountController.clear();
            categoryController.clear();
          },
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: () {
            final title = titleController.text.trim();
            final amount = double.tryParse(amountController.text.trim()) ?? 0;
            final category = categoryController.text.trim();

            if (title.isNotEmpty && category.isNotEmpty) {
              final expense = ExpenseModel(
                id: '',
                title: title,
                amount: amount,
                category: category,
                time: DateTime.now(),
              );
              onSubmit(expense);
            }
          },
          child: Text(isEditing ? "Save" : "Add", style: const TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}