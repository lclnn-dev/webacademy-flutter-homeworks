import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/categories.dart';
import '../models/transaction.dart';
import '../providers/finance_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _selectedSegment = 0;
  String? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FinanceProvider>(context);
    final categories = _selectedSegment == 1
        ? Categories.incomeCategories
        : Categories.expenseCategories;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Center(
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Витрата'),
                    icon: Icon(Icons.remove_circle_outline),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Прибуток'),
                    icon: Icon(Icons.add_circle_outline),
                  ),
                ],
                selected: {_selectedSegment},
                onSelectionChanged: (Set<int> newSelection) {
                  setState(() {
                    _selectedSegment = newSelection.first;
                    _selectedCategory = null;
                  });
                },
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: _selectedSegment == 0
                      ? Colors.red.shade400
                      : Colors.green.shade400,
                  selectedForegroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Сума',
                prefixStyle: TextStyle(
                  color: _selectedSegment == 1 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Введіть суму';
                final num = double.tryParse(value);
                if (num == null || num <= 0) return 'Введіть від\'ємне число';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Опис'),
              validator: (v) => v!.trim().isEmpty ? 'Введіть опис' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text('Виберіть категорію'),
              items: categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => _selectedCategory = value,
              validator: (v) => v == null ? 'Виберіть категорію' : null,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Дата транзакції'),
              subtitle: Text(
                '${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2025),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final transaction = FinanceTransaction(
                    amount: double.parse(_amountController.text),
                    description: _descriptionController.text.trim(),
                    category: _selectedCategory!,
                    date: _selectedDate,
                    isIncome: _selectedSegment == 1,
                  );

                  provider.addTransaction(transaction);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _selectedSegment == 1
                            ? 'Прибуток додано'
                            : 'Витрату додано',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: _selectedSegment == 1
                          ? Colors.green.shade400
                          : Colors.red.shade400,
                    ),
                  );

                  _formKey.currentState!.reset();
                  _amountController.clear();
                  _descriptionController.clear();
                  setState(() {
                    _selectedCategory = null;
                    _selectedSegment = 0;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Додати ${_selectedSegment == 1 ? 'прибуток' : 'витрату'}',
              ),
            )
          ],
        ),
      ),
    );
  }
}
