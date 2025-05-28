import 'package:flutter/material.dart';

import '../core/constants/splashColors.dart';

class PreviousParkCard extends StatelessWidget {
  final String title;
  final String hour;

  final String name;
  final String place;
  final String klm;

  const PreviousParkCard({
    super.key,
    required this.title,
    required this.hour,
    required this.name,
    required this.place,
    required this.klm,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: null,
        child: Container(
          width: 335,
          height: 120,
          padding: EdgeInsets.only(top: 15, left: 11),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Splashcolors.smallTextColor,
                    ),
                  ),
                  SizedBox(width: 170),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        hour,
                        style: TextStyle(
                          fontSize: 16,
                          color: Splashcolors.colorBackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "for hr",
                        style: TextStyle(
                          fontSize: 7,
                          color: Splashcolors.smallTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Image.asset("assets/splash/spot.png", width: 18),
                  Text(
                    place,
                    style: TextStyle(
                      fontSize: 12,
                      color: Splashcolors.smallTextColor,
                    ),
                  ),
                  SizedBox(width: 140),
                  Image.asset("assets/splash/location.png", width: 18),
                  Text(
                    klm,
                    style: TextStyle(
                      fontSize: 12,
                      color: Splashcolors.smallTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
