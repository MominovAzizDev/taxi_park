import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paycarmap/service/auth_service.dart';
import 'package:paycarmap/view/register/signup.dart';
import 'package:paycarmap/widgets/bottom_navigation_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/splashColors.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = false;
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Splashcolors.mainBackColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image.asset("assets/splash/Group 49.png", width: 100),
              ),
              SizedBox(height: 24),
              Text(
                "Email",
                style: TextStyle(
                  color: Splashcolors.smallTextColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: 311,
                height: 40,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Splashcolors.containerBackColor,
                    hintText: "John.Dominantio@gmail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Password",
                style: TextStyle(
                  color: Splashcolors.smallTextColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: 311,
                height: 40,
                child: TextField(
                  controller: passwordController,
                  obscureText: isPassword,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "***********",
                    filled: true,
                    fillColor: Splashcolors.containerBackColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: Icon(
                        isPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                height: 56,
                width: 280,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Splashcolors.colorBackColor,
                  ),
                  onPressed: () async {
                    User? user = await authService.signIn(
                      emailController.text,
                      passwordController.text,
                    );
                    if (user != null) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool("isLoggedIn", true);
                      await prefs.setString("email", emailController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomNavigationBarWidget(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Login xatosi",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Splashcolors.containerBackColor),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 38, right: 30),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text(
                    "I don't have an account? Sign Up",
                    style: TextStyle(
                      color: Splashcolors.smallTextColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
