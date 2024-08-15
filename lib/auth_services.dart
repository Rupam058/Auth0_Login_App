import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final Auth0 auth0;

  AuthService()
      : auth0 = Auth0(
          dotenv.env['AUTH0_DOMAIN']!,
          dotenv.env['AUTH0_CLIENT_ID']!,
        );

  Future<void> login() async {
    try {
      final credentials = await auth0.webAuthentication().login(
            redirectUrl: dotenv.env['AUTH0_REDIRECT_URI']!,
          );

      final accessToken = credentials.accessToken;
      if (accessToken != null) {
        print('Access Token: $accessToken');
        // Use the access token as needed
      } else {
        throw Exception('Access token is null.');
      }
    } catch (e) {
      print('Login Error: $e');
    }
  }

  Future<void> logout() async {
    try {
      await auth0.webAuthentication().logout(
            returnTo: dotenv.env['AUTH0_LOGOUT_REDIRECT_URI']!,
          );
      print('User logged out successfully.');
    } catch (e) {
      print('Logout Error: $e');
    }
  }
}
