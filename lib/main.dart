import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Pages/Screen/app_main_screen.dart';
import 'package:food_delivery_app/Pages/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://mfnwuabgyjiqxmgxqvzp.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1mbnd1YWJneWppcXhtZ3hxdnpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE4MzQzNDMsImV4cCI6MjA4NzQxMDM0M30.0mo8XJZvNG9Rr4Z4TQxsHuodCW2Ad8_1g1xGjAWaDEI",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // let's initialize the riverpod_flutter
    return ProviderScope(
      child: MaterialApp(debugShowCheckedModeBanner: false, home: AuthCheck()),
    );
  }
}

class AuthCheck extends StatelessWidget {
  final supabase = Supabase.instance.client;
  AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        if (session != null) {
          return AppMainScreen(); // if logged in, go to home screen
        } else {
          return LoginScreen(); // otherwise, show login screen
        }
      },
    );
  }
}
