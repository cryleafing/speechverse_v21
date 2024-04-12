import 'package:firebase_core/firebase_core.dart';

class FirebaseInitializer {
  static Future<void> initializeFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCEa_kWod0dgDCHwP93os5s2TZ5OvlqavM",
          appId: "speechverse-0",
          messagingSenderId: "182891395897",
          projectId: "speechverse-0",
          databaseURL:
              "https://speechverse-0-default-rtdb.europe-west1.firebasedatabase.app", // Correct database URL
        ),
      );
      print("Firebase initialized");
    } else {
      print("Firebase already initialized");
    }
  }
}
