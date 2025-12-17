import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/finance_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _limitController;
  String? _selectedCurrency;

  final currencies = ['UAH', 'USD', 'EUR'];

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<FinanceProvider>(context, listen: false);
    _limitController = TextEditingController(
        text: provider.monthlyLimit > 0
            ? provider.monthlyLimit.toStringAsFixed(0)
            : '');
    _selectedCurrency = provider.currency;
  }

  @override
  void dispose() {
    _limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FinanceProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCurrency,
              decoration: const InputDecoration(labelText: 'Валюта'),
              items: currencies
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedCurrency = value),
              validator: (v) => v == null ? 'Виберіть валюту' : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _limitController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Місячний ліміт витрат'),
              validator: (value) {
                if (value == null || value.isEmpty) return null;
                if (double.tryParse(value) == null) return 'Введіть число';
                return null;
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final limit = _limitController.text.isEmpty
                      ? 0.0
                      : double.parse(_limitController.text);
                  provider.updateSettings(
                    currency: _selectedCurrency,
                    monthlyLimit: limit,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Налаштування збережено')));
                }
              },
              child: const Text('Зберегти налаштування'),
            ),
          ],
        ),
      ),
    );
  }
}
