import 'package:flutter/material.dart';
import 'package:auth0_login_app/auth_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final AuthService _authService = AuthService();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Flutter Web App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for the splash screen
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the login page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _authService.login();
            // Navigate to the dashboard page after successful login
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Dashboard!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _authService.logout();
                // Navigate back to the login page after logout
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
