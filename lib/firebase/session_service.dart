import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// fetch study session data from firebase helper method:

Future<Map<DateTime, int>> fetchDailyStudyTime() async {
  var userId = FirebaseAuth.instance.currentUser?.uid;
  print("Fetching study sessions for user ID: $userId"); // Check user ID

  Map<DateTime, int> dailyDurations = {};

  if (userId != null) {
    var ref = FirebaseDatabase.instance
        .ref("study_sessions/${FirebaseAuth.instance.currentUser?.uid}");
    DatabaseEvent event = await ref.once();

    if (event.snapshot.exists) {
      print("Data found for user: $userId");
      Map<dynamic, dynamic> sessions = Map.from(event.snapshot.value as Map);

      sessions.forEach((key, value) {
        DateTime timestamp =
            DateTime.fromMillisecondsSinceEpoch(value['timestamp']);
        DateTime dateKey =
            DateTime(timestamp.year, timestamp.month, timestamp.day);
        int duration = value['duration'] as int;

        // Ensure the dateKey is initialized in the map
        if (!dailyDurations.containsKey(dateKey)) {
          dailyDurations[dateKey] =
              0; // Initialize to 0 if the key does not exist
        }

        dailyDurations[dateKey] = dailyDurations[dateKey]! + duration;
      });
    } else {
      print("No data available for user: $userId");
    }
  } else {
    print("User ID is null, cannot fetch data");
  }
  return dailyDurations;
}
