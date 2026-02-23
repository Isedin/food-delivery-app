import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/Pages/Home/home_screen.dart';
import 'package:food_delivery_app/Pages/auth/signup_screen.dart';
import 'package:food_delivery_app/Service/auth_service.dart';
import 'package:food_delivery_app/Widgets/my_button.dart';
import 'package:food_delivery_app/Widgets/snack_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoadin = false;
  bool isPasswordHidden = true;

  void _logIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (!mounted) return;
    setState(() {
      isLoadin = true;
    });
    final result = await _authService.login(email, password, ref);
    if (result == null) {
      // success case
      if (!mounted) return;
      setState(() {
        isLoadin = false;
      });
      Navigator.pushReplacement(
        context,
        // MaterialPageRoute(builder: (_) => OnbordingScreen()),
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } else {
      if (!mounted) return;
      setState(() {
        isLoadin = false;
      });
      showSnackBar(context, "Signup Failed:$result", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset(
                  "assets/login.jpg",
                  width: double.maxFinite,
                  height: 500,
                  fit: BoxFit.cover,
                ),
                // inpute field for email
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // password
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                      icon: Icon(
                        isPasswordHidden
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: isPasswordHidden,
                ),
                SizedBox(height: 20),
                isLoadin
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.maxFinite,
                        child: MyButton(onTap: _logIn, buttontext: "Login"),
                      ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => SignupScreen()),
                        );
                      },
                      child: Text(
                        "Signup here",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          letterSpacing: -1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
