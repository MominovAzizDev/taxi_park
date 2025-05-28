import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paycarmap/core/constants/splashColors.dart';
import 'package:paycarmap/view/register/signup.dart';

class SplashStart extends StatelessWidget {
  const SplashStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Splashcolors.colorBackColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 24, right: 24, top: 200, bottom: 200),
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Splashcolors.containerBackColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              SvgPicture.asset("assets/splash/startsplash.svg", width: 300),
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 18,
                  color: Splashcolors.bigTextColor,
                ),
              ),
              Text(
                "Welcome to Secure Parking. Now in order to use all the functionality of the app add your cars and addresses on the home page",
                style: TextStyle(
                  color: Splashcolors.smallTextColor,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 56,
                width: 280,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Splashcolors.buttonColor,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Splashcolors.containerBackColor),
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
