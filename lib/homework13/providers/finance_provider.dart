import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/preferences_service.dart';

class FinanceProvider extends ChangeNotifier {
  final PreferencesService _prefs = PreferencesService();

  List<FinanceTransaction> _transactions = [];
  String _currency = 'UAH';
  double _monthlyLimit = 0.0;

  List<FinanceTransaction> get transactions => _transactions;
  String get currency => _currency;
  double get monthlyLimit => _monthlyLimit;

  FinanceProvider() {
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    _transactions = await _prefs.loadTransactions();
    _currency = await _prefs.loadCurrency();
    _monthlyLimit = await _prefs.loadMonthlyLimit();
    notifyListeners();
  }

  Future<void> addTransaction(FinanceTransaction transaction) async {
    _transactions.add(transaction);
    await _prefs.saveTransactions(_transactions);
    notifyListeners();
  }

  Future<void> updateSettings({String? currency, double? monthlyLimit}) async {
    if (currency != null) {
      _currency = currency;
      await _prefs.saveCurrency(currency);
    }
    if (monthlyLimit != null) {
      _monthlyLimit = monthlyLimit;
      await _prefs.saveMonthlyLimit(monthlyLimit);
    }
    notifyListeners();
  }

  double get totalIncome =>
      _transactions.where((t) => t.isIncome).fold(0, (a, b) => a + b.amount);

  double get totalExpenses =>
      _transactions.where((t) => !t.isIncome).fold(0, (a, b) => a + b.amount);

  double get balance => totalIncome - totalExpenses;
}
