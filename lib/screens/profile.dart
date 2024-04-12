import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  Profile({super.key}); // Get the current user

  @override
  Widget build(BuildContext context) {
    final email = user?.email ?? 'No email'; // Safely access the email

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage:
                AssetImage('assets/images/profile_placeholder.jpg'),
          ),
          const SizedBox(height: 16.0),
          Text(
            user?.displayName ??
                'Username', // If you want to display the user's name and have it set up
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            email, // Use the user's email here
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 32.0),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // settings screen that can be implemented later
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              FirebaseAuth.instance.signOut(); // Log out the user
              Navigator.pushNamedAndRemoveUntil(
                  context, '/getstarted', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
