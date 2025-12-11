import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/habit.dart';
import 'habits_repository.dart';

class HabitsRepositoryImpl implements HabitsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Stream<List<Habit>> getHabitsForUser(String userId) {
    return _db
        .collection("habits")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Habit.fromFirestore(d)).toList());
  }

  @override
  Future<void> addHabit(Habit habit) async {
    await _db.collection("habits").add(habit.toJson());
  }

  @override
  Future<void> toggleToday(String habitId, bool done) async {
    final today = DateTime.now();
    final key =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    await _db.collection("habits").doc(habitId).update({
      "progress.$key": done,
    });
  }

  @override
  Future<void> deleteHabit(String habitId) async {
    await _db.collection("habits").doc(habitId).delete();
  }
}
