import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1D0B3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE1D0B3),
        title: const Text('Home'),
        actions: [
          // LOGOUT BUTTON: Click to sign out
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Signs out and AuthWrapper auto-navigates to LoginScreen
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: const Center(child: Text('You are logged in!')),
    );
  }
}
