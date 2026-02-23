import 'package:expenses_tracker/app/constants/app_color.dart';
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
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(
                      isEditing ? Icons.edit : Icons.add_circle_outline,
                      color: AppColor.primary,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      isEditing ? "Edit Expense" : "Add Expense",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Title Field
              _buildInputField(
                controller: titleController,
                label: "Title",
                icon: Icons.title,
                fillColor: Colors.grey.shade100,
                primaryColor: AppColor.primary,
              ),

              const SizedBox(height: 16),

              /// Amount Field
              _buildInputField(
                controller: amountController,
                label: "Amount",
                icon: Icons.attach_money,
                fillColor: Colors.grey.shade100,
                primaryColor: AppColor.primary,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              /// Category Field
              _buildInputField(
                controller: categoryController,
                label: "Category",
                icon: Icons.category,
                fillColor: Colors.grey.shade100,
                primaryColor: AppColor.primary,
              ),

              const SizedBox(height: 30),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: AppColor.primary.withValues(alpha: 0.4),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        titleController.clear();
                        amountController.clear();
                        categoryController.clear();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        final title = titleController.text.trim();
                        final amount =
                            double.tryParse(amountController.text.trim()) ?? 0;
                        final category = categoryController.text.trim();

                        if (title.isNotEmpty &&
                            category.isNotEmpty &&
                            amount > 0) {
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
                      child: Text(
                        isEditing ? "Save Changes" : "Add Expense",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// Reusable Input Field
Widget _buildInputField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required Color fillColor,
  required Color primaryColor,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    cursorColor: primaryColor,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: primaryColor),
      filled: true,
      fillColor: fillColor,
      labelStyle: TextStyle(color: Colors.grey.shade700),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
