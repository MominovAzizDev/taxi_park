import 'package:flutter/material.dart';

import '../core/constants/splashColors.dart';

class CarParkCard extends StatelessWidget {
  final String name;
  final String carid;
  final String cartype;
  final String carimage;

  const CarParkCard({
    super.key,
    required this.name,
    required this.carid,
    required this.cartype,
    required this.carimage,
  });
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
                    Image.asset(cartype, width: 24),
                    SizedBox(width: 10),
                    Text(name, style: TextStyle(fontSize: 16)),
                  ],
                ),
                subtitle: Text(
                  carid,
                  style: TextStyle(
                    fontSize: 14,
                    color: Splashcolors.smallTextColor,
                  ),
                ),
                trailing: Image.asset(carimage, width: 57),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
