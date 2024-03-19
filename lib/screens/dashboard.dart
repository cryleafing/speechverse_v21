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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      // Handle button press
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
              Image.asset(
                'assets/images/chart_image.png', // Path to chart image, dummy for now
                fit: BoxFit.contain, //fit
                width: double.infinity, // take full width
              ),
              // beef
              const SizedBox(height: 20),
            ],
          ),
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
                  // snackbar? lol
                },
              ),
              ListTile(
                leading: const Icon(Icons.list_alt_outlined),
                title: const Text('Modules'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.playlist_add_check_circle_sharp),
                title: const Text('To Do List'),
                onTap: () {
                  Navigator.pushNamed(context, '/todolist');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // go to settings, this should use sharedprefs
                  // settings should be able to clear the flashcard decks
                },
              ),
            ],
          ),
        ));
  }
}

class HorizontalCategoryList extends StatelessWidget {
  const HorizontalCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            children: [
              ListTile(
                title: const Text('Category 1'),
                onTap: () {
                  // Add your onTap logic here
                },
              ),
              ListTile(
                title: const Text('Category 2'),
                onTap: () {
                  // Add your onTap logic here
                },
              ),
              ListTile(
                title: const Text('Category 3'),
                onTap: () {
                  // Add your onTap logic here
                },
              ),
              ListTile(
                title: const Text('Category 4'),
                onTap: () {
                  // Add your onTap logic here
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}