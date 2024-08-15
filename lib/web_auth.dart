import 'package:auth0_web_flutter/auth0_flutter_web.dart';

class AuthService {
  // Constructor to initialize Auth0 settings
  AuthService() {
    // Set Auth0 domain, client ID, and redirect URI
    Auth0FlutterWeb.auth0Domain = "dev-iwfm2uf3wav2azdb.us.auth0.com";
    Auth0FlutterWeb.auth0ClientId = "tkIpQNuletXTgJDeEkjHu7fCC5E2pPmR";
    Auth0FlutterWeb.redirectUri = "http://localhost:8000/callback";
    Auth0FlutterWeb.setPathUrlStrategy();
  }

  // Method to authenticate user (login/signup)
  Future<void> authenticateUser({bool isSignup = false}) async {
    try {
      final screenHint = isSignup ? 'signup' : 'login';
      await Auth0FlutterWeb.instance.userAuthentication(screenHint: screenHint);
    } catch (e) {
      print("Authentication Error: $e");
    }
  }

  // Method to log out user
  Future<void> logoutUser() async {
    try {
      await Auth0FlutterWeb.instance.logoutUser();
      print("User logged out successfully");
    } catch (e) {
      print("Logout Error: $e");
    }
  }

  // Method to handle login callback and check if the user is authenticated
  Future<bool> isAuthenticated() async {
    try {
      // Log the current URL being processed
      String? currentUrl = Uri.base.toString(); // Get the current URL
      print("Handling callback for URL: $currentUrl");

      // Handle the callback and return authentication status
      return await Auth0FlutterWeb.instance.handleWebLoginCallback(currentUrl);
    } catch (e) {
      print("Error during login callback: $e");
      return false;
    }
  }
}
