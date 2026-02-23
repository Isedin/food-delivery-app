import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Core/Provider/cart_provider.dart';
import 'package:food_delivery_app/Core/Provider/favorite_provider.dart';
import 'package:food_delivery_app/Service/auth_service.dart';

AuthService authService = AuthService();

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                authService.logout(context);
                ref.invalidate(favoriteProvider);
                ref.invalidate(cartProvider);
              },
              child: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}
// we have successfully completed a favorite function part, now lets work on cart function,