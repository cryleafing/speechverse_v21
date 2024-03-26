import 'package:flutter/material.dart';
import 'package:speechverse_v2/screens/decks.dart';
import 'package:speechverse_v2/screens/to_do_list.dart';
import 'screens/createflashcard.dart';
import 'screens/dashboard.dart';
import 'screens/home_page.dart';
import 'app_theme.dart';
import 'screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());
}
// root widget

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});
  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SpeechVerse',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/getstarted', // Specify the initial route
        routes: {
          '/getstarted': (context) => MyHomePage(), // Home page
          '/dashboard': (context) => Dashboard(),
          '/todolist': (context) => TodoList(),
          '/profile': (context) => Profile(),
          '/createflashcard': (context) => CreateFlashcard(),
          '/decks': (context) => DecksPage(),
          // Start page
          // Add more routes later as the pages increase
        });
  }
}
