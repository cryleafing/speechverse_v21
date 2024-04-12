// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person_2_rounded),
              onPressed: () {
                // route to profile page
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello, Study Enthusiast',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Flashcard Overview',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/createflashcard');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).splashColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      'Create Flashcards',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/todolist');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).splashColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      'To Do List',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Study Statistics',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Square shape
                ),
                minimumSize: Size(200, 50), // Button size
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/study_stats');
              },
              child: Text('View Study Statistics'),
            ),
          ]),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text('Dashboard'),
                onTap: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              ListTile(
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text('Review Flashcards'),
                onTap: () {
                  Navigator.pushNamed(context, '/flashcard_review');
                }, // take to review page!
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add_check_circle_sharp),
                title: const Text('To Do List'),
                onTap: () {
                  Navigator.pushNamed(context, '/todolist');
                },
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add),
                title: const Text('Decks'),
                onTap: () {
                  // go to decks
                  Navigator.pushNamed(context, '/decks');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // go to settings, this should use sqlite...
                  // settings should be able to clear the flashcard decks
                },
              ),
            ],
          ),
        ));
  }
}
