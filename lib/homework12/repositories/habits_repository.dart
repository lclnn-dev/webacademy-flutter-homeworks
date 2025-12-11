import '../models/habit.dart';

abstract class HabitsRepository {
  Stream<List<Habit>> getHabitsForUser(String userId);
  Future<void> addHabit(Habit habit);
  Future<void> toggleToday(String habitId, bool done);
  Future<void> deleteHabit(String habitId);
}
