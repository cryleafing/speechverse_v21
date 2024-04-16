import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// fetch study session data from firebase helper method:

Future<Map<DateTime, int>> fetchDailyStudyTime() async {
  var userId = FirebaseAuth.instance.currentUser?.uid;
  print("Fetching study sessions for user ID: $userId"); // check user ID

  Map<DateTime, int> dailyDurations = {};

  if (userId != null) {
    var ref = FirebaseDatabase.instance
        .ref("study_sessions/${FirebaseAuth.instance.currentUser?.uid}");
    DatabaseEvent event = await ref.once();

    if (event.snapshot.exists) {
      Map<dynamic, dynamic> sessions = Map.from(event.snapshot.value as Map);

      sessions.forEach((key, value) {
        DateTime timestamp =
            DateTime.fromMillisecondsSinceEpoch(value['timestamp']);
        DateTime dateKey =
            DateTime(timestamp.year, timestamp.month, timestamp.day);
        int duration = value['duration'] as int;

        // make sure the dateKey is initialized in the map
        if (!dailyDurations.containsKey(dateKey)) {
          dailyDurations[dateKey] =
              0; // initialize to 0 if the key does not exist
        }

        dailyDurations[dateKey] = dailyDurations[dateKey]! + duration;
      });
    } else {
      // do nothing
    }
  } else {
    // do nothing, was originally space for debug prints here, but left it.
  }
  return dailyDurations;
}

class PointsService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;

  // helper method to convert minutes to points, this isnt used much
  int convertMinutesToPoints(int minutes) {
    // 1 minute = 1 point
    return minutes;
  }

  Future<int> fetchPoints() async {
    if (_userId == null) {
      return 0;
    }

    final userPointsRef = _dbRef.child('user_points/$_userId');
    try {
      DataSnapshot snapshot = await userPointsRef.get();
      if (snapshot.exists) {
        return snapshot.value as int;
      } else {
        return 0; // no points found, return 0
      }
    } catch (error) {
      return 0; // in case of error, return 0
    }
  }
}
