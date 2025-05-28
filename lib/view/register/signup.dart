import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paycarmap/core/constants/splashColors.dart';
import 'package:paycarmap/service/auth_service.dart';
import 'package:paycarmap/view/register/Signin.dart';
import 'package:paycarmap/widgets/bottom_navigation_bar_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool isPassword = false;

  final AuthService authService = AuthService();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Splashcolors.mainBackColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 20),
              Center(
                child: Image.asset("assets/splash/Group 49.png", width: 100),
              ),
              SizedBox(height: 23),
              Text(
                "First name",
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
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: "John Dominantio",
                    filled: true,
                    fillColor: Splashcolors.containerBackColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Username",
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
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: "Johny.Richi",
                    filled: true,
                    fillColor: Splashcolors.containerBackColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
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
              Text(
                "Confirm Password",
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
                  controller: confirmpasswordController,
                  keyboardType: TextInputType.number,
                  obscureText: isPassword,
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
                        isPassword = !isPassword;
                      },
                      icon: Icon(
                        isPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? NewItem) {
                      setState(() {
                        isChecked = NewItem!;
                      });
                    },
                  ),
                  Text(
                    "I agree with terms and conditions",
                    style: TextStyle(
                      color: Splashcolors.bigTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 45),
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
                    try {
                      User? user = await authService.signUp(
                        firstNameController.text,
                        userNameController.text,
                        emailController.text,
                        passwordController.text,
                      );
                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavigationBarWidget(),
                          ),
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Xatolik ${e.message}")),
                      );
                    }
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: Splashcolors.containerBackColor),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 38),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signin()),
                    );
                  },
                  child: Text(
                    "Already have an account? Sign in",
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
