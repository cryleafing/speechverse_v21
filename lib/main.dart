import 'package:flutter/material.dart';
import 'package:speechverse_v2/screens/decks.dart';
import 'package:speechverse_v2/screens/flashcard_detail.dart';
import 'package:speechverse_v2/screens/login.dart';
import 'package:speechverse_v2/screens/to_do_list.dart';
import 'screens/createflashcard.dart';
import 'screens/dashboard.dart';
import 'screens/home_page.dart';
import 'app_theme.dart';
import 'screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'firebase/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
// root widget

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SpeechVerse',
        theme: AppTheme.darkTheme,
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/getstarted', // Specify the initial route
        routes: {
          '/getstarted': (context) => MyHomePage(), // Home page
          '/login': (context) => LoginScreen(),
          '/dashboard': (context) => const Dashboard(),
          '/todolist': (context) => const TodoList(),
          '/profile': (context) => Profile(),
          '/createflashcard': (context) => const CreateFlashcard(),
          '/decks': (context) => DecksPage(),
          'flashcard_overview': (context) => FlashcardsPage(
                deck: Deck(id: 0, deckName: 'My Deck'),
              ),
          // Start page
          // Add more routes later as the pages increase
        });
  }
}
