import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';

class PreferencesService {
  static const String _keyTransactions = 'transactions';
  static const String _keyCurrency = 'currency';
  static const String _keyMonthlyLimit = 'monthly_limit';

  Future<void> saveTransactions(List<FinanceTransaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(transactions.map((t) => t.toJson()).toList());
    await prefs.setString(_keyTransactions, jsonString);
  }

  Future<List<FinanceTransaction>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyTransactions);
    if (jsonString == null) return [];

    final List<dynamic> list = jsonDecode(jsonString);
    return list.map((e) => FinanceTransaction.fromJson(e)).toList();
  }

  Future<void> saveCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCurrency, currency);
  }

  Future<void> saveMonthlyLimit(double limit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyMonthlyLimit, limit);
  }

  Future<String> loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyCurrency) ?? 'UAH';
  }

  Future<double> loadMonthlyLimit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keyMonthlyLimit) ?? 0.0;
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
