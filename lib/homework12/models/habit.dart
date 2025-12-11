import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String id;
  final String name;
  final String frequency;
  final String startDate;
  final Map<String, bool> progress;
  final String userId;

  Habit({
    required this.id,
    required this.name,
    required this.frequency,
    required this.startDate,
    required this.progress,
    required this.userId,
  });

  factory Habit.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Habit(
      id: doc.id,
      name: data["name"],
      frequency: data["frequency"],
      startDate: data["startDate"],
      progress: Map<String, bool>.from(data["progress"] ?? {}),
      userId: data["userId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "frequency": frequency,
      "startDate": startDate,
      "progress": progress,
      "userId": userId,
    };
  }
}
