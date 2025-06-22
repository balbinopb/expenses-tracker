import 'package:flutter/material.dart';
import 'package:expenses_tracker/models/user_model.dart';
import 'package:expenses_tracker/services/user_service.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _userService = UserService();

  void _showAddUserDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add New User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              final email = _emailController.text.trim();

              if (name.isNotEmpty && email.isNotEmpty) {
                final id = DateTime.now().millisecondsSinceEpoch.toString();
                final user = UserModel(uId: id, name: name, email: email);
                await _userService.addUser(user);

                _nameController.clear();
                _emailController.clear();
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Tap the '+' below to add a user"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddUserDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
