import 'package:intl/intl.dart';

class FinanceTransaction {
  final double amount;
  final String description;
  final String category;
  final DateTime date;
  final bool isIncome;

  FinanceTransaction({
    required this.amount,
    required this.description,
    required this.category,
    required this.date,
    required this.isIncome,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'category': category,
      'date': date.toIso8601String(),
      'isIncome': isIncome,
    };
  }

  factory FinanceTransaction.fromJson(Map<String, dynamic> json) {
    return FinanceTransaction(
      amount: json['amount'] as double,
      description: json['description'] as String,
      category: json['category'] as String,
      date: DateTime.parse(json['date']),
      isIncome: json['isIncome'] as bool,
    );
  }

  String get formattedDate => DateFormat('dd.MM.yyyy').format(date);
}
