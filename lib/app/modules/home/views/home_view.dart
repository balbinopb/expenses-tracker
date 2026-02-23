import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'expense_list.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const primaryColor = Color(0xFF16A34A);
  static const backgroundColor = Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "Expense Tracker",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.showAddDialog(context),
        backgroundColor: primaryColor,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF16A34A), Color(0xFF22C55E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Expenses",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 6),
                StreamBuilder<double>(
                  stream: controller.totalExpenses(),
                  builder: (context, totalData) {
                    if (!totalData.hasData) {
                      return const Text(
                        "\$0.00",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    return Text(
                      "\$${totalData.data!.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          /// 🔹 Expense List
          Expanded(
            child: ExpenseList(
              userId: controller.userId,
              onEdit: controller.showEditDialog,
            ),
          ),
        ],
      ),
    );
  }
}
