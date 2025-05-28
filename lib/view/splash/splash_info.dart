import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paycarmap/core/constants/splashColors.dart';
import 'package:paycarmap/view/splash/splash_start.dart';

class SplashInfo extends StatelessWidget {
  const SplashInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Splashcolors.colorBackColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/splash/splashinfo.svg", width: 300),
            Container(
              decoration: BoxDecoration(
                color: Splashcolors.containerBackColor,
                borderRadius: BorderRadius.circular(24),
              ),
              margin: EdgeInsets.only(left: 24, right: 24, bottom: 25, top: 69),
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 27),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 23, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "About App",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Splashcolors.bigTextColor,
                          ),
                        ),
                        Icon(Icons.navigation_rounded, color: Colors.black),
                      ],
                    ),
                  ),
                  Text(
                    "Secure Parking operates and manages the parking facilities at various malls, shopping centers, and residential areas. Each facility contains many parking lots of different categories like VIP, Normal,Reserved Slots etc. The parking slots are having different tariffs for (per hour) usage.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Splashcolors.smallTextColor,
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
                          MaterialPageRoute(
                            builder: (context) => SplashStart(),
                          ),
                        );
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Splashcolors.containerBackColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
