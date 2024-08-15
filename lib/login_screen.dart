import 'package:auth0_login_app/web_auth.dart';
import 'package:flutter/material.dart';
import 'dashboard_screen.dart'; // Import the DashboardScreen

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await authService.authenticateUser(isSignup: true);
                bool isAuthenticated = await authService.isAuthenticated();
                if (isAuthenticated) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardScreen()),
                  );
                } else {
                  print("Authentication failed.");
                }
              },
              child: const Text('Signup'),
            ),
            ElevatedButton(
              onPressed: () async {
                await authService.authenticateUser(isSignup: false);
                bool isAuthenticated = await authService.isAuthenticated();
                if (isAuthenticated) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardScreen()),
                  );
                } else {
                  print("Authentication failed.");
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
