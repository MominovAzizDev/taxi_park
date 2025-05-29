import 'package:flutter/material.dart';
import 'package:paycarmap/modul/car_park_card_modul.dart';

import '../core/constants/splashColors.dart';

class CarParkCard extends StatelessWidget {
  final CarParkCardModul model;

  const CarParkCard({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        child: Container(
          width: 335,
          height: 73,
          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Image.asset(model.cartype, width: 24),
                    SizedBox(width: 10),
                    Text(model.name, style: TextStyle(fontSize: 16)),
                  ],
                ),
                subtitle: Text(
                  model.carid,
                  style: TextStyle(
                    fontSize: 14,
                    color: Splashcolors.smallTextColor,
                  ),
                ),
                trailing: Image.asset(model.carimage, width: 57),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
