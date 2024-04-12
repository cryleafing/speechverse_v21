import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:speechverse_v2/screens/dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = ''; // Add an error message field

  // A method to update the error message
  void _updateErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  // Enhanced sign-in method with error handling
  Future<void> _signIn() async {
    try {
      final User? user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ))
              .user;
      if (user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const Dashboard())); // homescreen to get to!
      }
    } on FirebaseAuthException catch (e) {
      // Catch FirebaseAuth specific errors
      if (e.code == 'user-not-found') {
        _updateErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _updateErrorMessage('Wrong password provided for that user.');
      } else {
        _updateErrorMessage('An error occurred. Please try again later.');
      }
    } catch (e) {
      // Catch any other errors
      _updateErrorMessage('An error occurred. Please try again later.');
    }
  }

  // Enhanced sign-up method with error handling
  Future<void> _signUp() async {
    try {
      final User? user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ))
              .user;
      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth specific errors
      if (e.code == 'weak-password') {
        _updateErrorMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _updateErrorMessage('The account already exists for that email.');
      } else {
        _updateErrorMessage('An error occurred. Please try again later.');
      }
    } catch (e) {
      // Handle any other errors
      _updateErrorMessage('An error occurred. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (_errorMessage
                .isNotEmpty) // Display the error message if it exists
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
