import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Picture
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
                'assets/images/profile_placeholder.jpg'), // add image
          ),
          const SizedBox(height: 16.0),
          // User Information
          const Text(
            'Jane Doe',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'jane.doe@example.com',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 32.0),
          // Settings Section
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              //handle a settings screen that should use sharedpreferences
            },
          ),
          // Logout Option
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              // Perform logout operation
              // For example, navigate to login screen
              Navigator.pushNamedAndRemoveUntil(
                  context, '/getstarted', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
