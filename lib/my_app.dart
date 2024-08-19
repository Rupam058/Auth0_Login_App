import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:auth0_login_app/constants.dart';
import 'package:auth0_login_app/hero.dart';
import 'package:auth0_login_app/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyApp extends StatefulWidget {
  final Auth0? auth0;
  const MyApp({super.key, this.auth0});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserProfile? _user;

  // Credentials? _credentials;

  late Auth0 auth0;
  late Auth0Web auth0Web;

  @override
  void initState() {
    super.initState();
    auth0 = widget.auth0 ?? Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

    auth0Web = Auth0Web(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);

    if (kIsWeb) {
      auth0Web.onLoad().then((final credential) => setState(() {
            _user = credential?.user;
            // _credentials = credential;
          }));
    }
  }

  Future<void> login() async {
    try {
      if (kIsWeb) {
        return auth0Web.loginWithRedirect(redirectUrl: 'http://localhost:40275');
      }

      // var credentials = await auth0.webAuthentication(scheme: dotenv.env['AUTH0_CUSTOME_SCHEME']).login(useHTTPS: true);

      // setState(() {
      //   _user = credentials.user;
      //   // _credentials = credentials;
      // });
    } catch (e) {
      print('Login error: $e');
    }
  }

  Future<void> logout() async {
    try {
      if (kIsWeb) {
        await auth0Web.logout(returnToUrl: 'http://localhost:40275');
      } else {
        await auth0.webAuthentication(scheme: dotenv.env['AUTH0_CUSTOME_SCHEME']).logout(useHTTPS: true);
      }
    } catch (e) {
      print('Logout error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: padding,
            bottom: padding,
            left: padding / 2,
            right: padding / 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    _user != null
                        ? Expanded(
                            child: UserWidget(user: _user),
                          )
                        : const Expanded(
                            child: HeroWidget(),
                          ),
                  ],
                ),
              ),
              _user != null
                  ? ElevatedButton(onPressed: logout, child: const Text('Logout'))
                  : ElevatedButton(onPressed: login, child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
