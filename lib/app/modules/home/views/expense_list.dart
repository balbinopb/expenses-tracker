

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/expense_model.dart';
import '../../../data/services/expense_service.dart';

class ExpenseList extends StatelessWidget {
  final String userId;
  final void Function(ExpenseModel) onEdit;

  ExpenseList({super.key, required this.userId, required this.onEdit});

  final expenseService = ExpenseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExpenseModel>>(
      stream: expenseService.getExpenses(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No expenses yet"));
        }

        final expenses = snapshot.data!;

        return ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 2,
              child: ListTile(
                title: Text(expense.title),
                subtitle: Text(
                  DateFormat('dd MMM yyyy – HH:mm').format(expense.time),
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => onEdit(expense),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await expenseService.deleteExpense(userId, expense.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}