import 'package:flutter/material.dart';

import '../core/constants/splashColors.dart';
import '../modul/previous_park_card_modul.dart';

class PreviousParkCard extends StatelessWidget {
  final PreviousParkCardModul model;

  const PreviousParkCard({super.key, required this.model});
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
                    model.title,
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
                        model.hour,
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
                model.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Image.asset("assets/splash/spot.png", width: 18),
                  Text(
                    model.place,
                    style: TextStyle(
                      fontSize: 12,
                      color: Splashcolors.smallTextColor,
                    ),
                  ),
                  SizedBox(width: 140),
                  Image.asset("assets/splash/location.png", width: 18),
                  Text(
                    model.klm,
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
