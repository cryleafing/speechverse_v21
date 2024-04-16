import 'package:flutter/material.dart';
import 'package:speechverse_v2/screens/login.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // landing page for personality!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .background, // use custom background color
        title: Text(
          'Get Started',
          style: Theme.of(context).textTheme.bodyLarge!,
        ),
      ),
      backgroundColor: Theme.of(context)
          .colorScheme
          .background, // Use custom background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'speechverse',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.white, // White text
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Add some spacing
            Text(
              'Study smarter, not harder.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white, // White text
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Add some spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context)
                    .secondaryHeaderColor, // colour defined in theme
                padding:
                    const EdgeInsets.symmetric(vertical: 16), // Custom padding
              ),
              child: Text(
                'Start Now',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white, // White text
                      fontWeight: FontWeight.bold, // Bold text
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
