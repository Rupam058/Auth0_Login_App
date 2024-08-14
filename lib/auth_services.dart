import 'dart:convert';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String domain = 'dev-iwfm2uf3wav2azdb.us.auth0.com';
  final String clientId = 'jDF7mlaw9nD0VP118KEIxyKsEGnv1XH4';

  Future<void> login() async {
    try {
      // Construct the URL for authorization
      final url =
          'https://$domain/authorize?response_type=code&client_id=$clientId&redirect_uri=http://localhost:8000/callback&scope=openid profile email';

      // Open the web authentication screen
      final result = await FlutterWebAuth.authenticate(
        url: url,
        callbackUrlScheme: "http",
      );

      // Extract code from the callback URL
      final code = Uri.parse(result).queryParameters['code'];

      if (code == null) {
        throw Exception('Failed to retrieve authorization code.');
      }

      // Request the access token
      final response = await http.post(
        Uri.parse('https://$domain/oauth/token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'client_id': clientId,
          'code': code,
          'redirect_uri': 'http://localhost:8000/callback',
        },
      );

      if (response.statusCode == 200) {
        final accessToken = jsonDecode(response.body)['access_token'];
        if (accessToken != null) {
          print('Access Token: $accessToken');
          // Use the access token as needed
        } else {
          throw Exception('Access token is null.');
        }
      } else {
        throw Exception('Failed to retrieve access token: ${response.statusCode}');
      }
    } catch (e) {
      print('Login Error: $e');
    }
  }

  Future<void> logout() async {
    try {
      // Construct the URL for logout
      final url = 'https://$domain/v2/logout?client_id=$clientId&returnTo=http://localhost:8000';

      // Open the logout web authentication screen
      await FlutterWebAuth.authenticate(
        url: url,
        callbackUrlScheme: "http",
      );

      print('User logged out successfully.');
    } catch (e) {
      print('Logout Error: $e');
    }
  }
}
