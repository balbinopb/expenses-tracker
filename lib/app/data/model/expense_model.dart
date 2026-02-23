

import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  final String id;
  final String title;
  final String category;
  final double amount;
  final DateTime time;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.time,
  });

  // Convert model to Firestore document (Map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'amount': amount,
      'time': time,
    };
  }

  // Create model from Firestore document
  factory ExpenseModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ExpenseModel(
      id: doc.id,
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      time: (data['time'] as Timestamp).toDate(),
    );
  }
}