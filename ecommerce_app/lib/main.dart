import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:ecommerce_app/screens/auth_wrapper.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // STEP 1: Preserve the native splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // STEP 2: Initialize Firebase - connects to your Firebase project
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // STEP 3: Run the app - AuthWrapper handles login vs home screen
  runApp(const MyApp());

  // STEP 4: Remove splash screen once app is ready
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Root widget of your Flutter application
    return MaterialApp(
      // Remove the "Debug" banner in top-right corner
      debugShowCheckedModeBanner: false,
      title: 'eCommerce App',
      theme: ThemeData(primarySwatch: Colors.grey),

      // AuthWrapper automatically shows:
      // - LoginScreen if user is NOT logged in
      // - HomeScreen if user IS logged in (Firebase remembers sessions!)
      home: const AuthWrapper(),
    );
  }
}

// NOTE: You can safely DELETE everything below this line
// as it's just the default Flutter counter app template
// and you're now using AuthWrapper → LoginScreen/HomeScreen

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
