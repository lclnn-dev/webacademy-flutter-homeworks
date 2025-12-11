import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../services/habits_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final nameCtrl = TextEditingController();
  String freq = "Щодня";
  DateTime startDate = DateTime.now();

  String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final habitsService = context.read<HabitsService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Нова звичка"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(
                labelText: "Назва звички",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownMenu<String>(
              expandedInsets: EdgeInsets.zero,
              label: const Text("Частота"),
              initialSelection: freq,
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: "Щодня", label: "Щодня"),
                DropdownMenuEntry(
                    value: "Раз на тиждень", label: "Раз на тиждень"),
                DropdownMenuEntry(
                    value: "Раз на місяць", label: "Раз на місяць"),
              ],
              onSelected: (value) {
                setState(() => freq = value!);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final d = await showDatePicker(
                  context: context,
                  initialDate: startDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (d != null) setState(() => startDate = d);
              },
              child: Text("Дата початку: ${_formatDate(startDate)}",
                  style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 30),
            FilledButton(
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                if (nameCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Назва не може бути порожньою")),
                  );
                  return;
                }

                final uid = FirebaseAuth.instance.currentUser!.uid;

                await habitsService.addHabit(
                  Habit(
                    id: "",
                    name: nameCtrl.text.trim(),
                    frequency: freq,
                    startDate: _formatDate(startDate),
                    progress: {},
                    userId: uid,
                  ),
                );

                if (context.mounted) Navigator.pop(context);
              },
              child: const Text(
                "Створити",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
