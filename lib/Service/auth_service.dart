import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Core/Provider/cart_provider.dart';
import 'package:food_delivery_app/Pages/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  // sign up funcation
  Future<String?> signup(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        password: password,
        email: email,
      );
      if (response.user != null) {
        return null; // indicates sucess
      }
      return "An unknow error occurred";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Error:$e";
    }
  }

  // login function
  Future<String?> login(String email, String password, WidgetRef ref) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user != null) {
        // Load the cart for the logged-in user
        await ref.read(cartProvider).loadCart();

        return null; // indicates success
      }

      return "Invalid email or password";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return "Error:$e";
    }
  }

  // funcation to logout
  Future<void> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if (!context.mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    } catch (e) {
      print("Logout error $e");
    }
  }
}
