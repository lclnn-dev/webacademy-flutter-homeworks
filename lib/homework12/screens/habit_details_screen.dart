import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../services/habits_service.dart';

class HabitDetailsScreen extends StatelessWidget {
  final Habit habit;
  const HabitDetailsScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final entries = habit.progress.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final habitsService = context.read<HabitsService>();
    final colorInversePrimary = Theme.of(context).colorScheme.inversePrimary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Деталі"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirm = await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Видалити звичку?"),
                  content: const Text("Цю дію не можна скасувати."),
                  actions: [
                    TextButton(
                      child: const Text("Скасувати"),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    TextButton(
                      child: const Text(
                        "Видалити",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await habitsService.deleteHabit(habit.id);
                if (context.mounted) Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habit.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.repeat, color: colorInversePrimary),
                        const SizedBox(width: 10),
                        Text(
                          "Частота: ${habit.frequency}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: colorInversePrimary),
                        const SizedBox(width: 10),
                        Text(
                          "Дата початку: ${habit.startDate}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Прогрес",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...entries.map((e) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: ListTile(
                  title: Text(e.key),
                  trailing: Icon(
                    e.value ? Icons.check_circle : Icons.cancel,
                    color: e.value ? colorInversePrimary : Colors.red.shade200,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
