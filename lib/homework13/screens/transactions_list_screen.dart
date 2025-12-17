import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';

class TransactionsListScreen extends StatelessWidget {
  const TransactionsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FinanceProvider>(context);
    final transactions = provider.transactions.reversed.toList();
    final currency = provider.currency;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('Поточний баланс', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              Text(
                '${provider.balance > 0 ? '+' : ''}${provider.balance.toStringAsFixed(2)} $currency',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIncomeExpense(
                    label: 'Прибуток',
                    amount: '+${provider.totalIncome.toStringAsFixed(0)}',
                    color: Colors.green,
                  ),
                  _buildIncomeExpense(
                    label: 'Витрати',
                    amount: '-${provider.totalExpenses.toStringAsFixed(0)}',
                    color: Colors.red.shade300,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: transactions.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Немає транзакцій',
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final t = transactions[index];
                    final isIncome = t.isIncome;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: isIncome
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isIncome
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        title: Text(
                          t.description,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        subtitle: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                t.category,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isIncome
                                      ? Colors.green.shade800
                                      : Colors.red.shade800,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatDateTime(t.date),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 13),
                            ),
                          ],
                        ),
                        trailing: Text(
                          '${isIncome ? '+' : '−'}${t.amount.toStringAsFixed(0)} $currency',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isIncome
                                ? Colors.green.shade700
                                : Colors.red.shade700,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildIncomeExpense({
    required String label,
    required String amount,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDay = DateTime(date.year, date.month, date.day);

    String dayLabel;
    if (transactionDay == today) {
      dayLabel = 'Сьогодні';
    } else if (transactionDay == yesterday) {
      dayLabel = 'Вчора';
    } else {
      dayLabel = '${date.day}.${date.month}.${date.year}';
    }
    return dayLabel;
  }
}
