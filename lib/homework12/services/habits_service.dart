import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/habits_repository.dart';
import '../models/habit.dart';

class HabitsService {
  final HabitsRepository repository;

  HabitsService({required this.repository});

  Stream<List<Habit>> getHabits() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return repository.getHabitsForUser(uid);
  }

  Future<void> addHabit(Habit habit) {
    return repository.addHabit(habit);
  }

  Future<void> toggleToday(String id, bool done) {
    return repository.toggleToday(id, done);
  }

  Future<void> deleteHabit(String id) {
    return repository.deleteHabit(id);
  }
}