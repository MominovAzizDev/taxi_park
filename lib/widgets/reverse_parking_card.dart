import 'package:flutter/material.dart';

import '../core/constants/splashColors.dart';

class ReverseParkingCard extends StatelessWidget {
  final String title;
  final String location;
  final String klm;
  final String fromtime;
  final String totime;
  final String fromday;
  final String today;
  final String price;
  const ReverseParkingCard({
    super.key,
    required this.title,
    required this.location,
    required this.klm,
    required this.fromtime,
    required this.totime,
    required this.fromday,
    required this.today,
    required this.price,
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
          height: 250,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Splashcolors.bigTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      location,
                      style: TextStyle(
                        color: Splashcolors.smallTextColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 20),
                    Icon(
                      Icons.route_outlined,
                      color: Splashcolors.colorBackColor,
                    ),
                    Text(
                      klm,
                      style: TextStyle(
                        color: Splashcolors.smallTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                trailing: Image.asset("assets/splash/qrcodes.png", width: 40),
              ),
              SizedBox(height: 24),
              ListTile(
                title: Row(
                  children: [
                    Text(
                      fromtime,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Splashcolors.bigTextColor,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 27),
                    Icon(Icons.ac_unit, size: 10, color: Colors.indigo),
                    SizedBox(
                      width: 40,
                      child: Divider(color: Splashcolors.smallTextColor),
                    ),
                    Icon(Icons.ac_unit, size: 10, color: Colors.amber),
                    SizedBox(width: 27),
                    Text(
                      totime,
                      style: TextStyle(
                        color: Splashcolors.bigTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      fromday,
                      style: TextStyle(
                        color: Splashcolors.bigTextColor,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: 118),
                    Text(
                      today,
                      style: TextStyle(
                        color: Splashcolors.bigTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(child: Divider(color: Splashcolors.smallTextColor)),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 10),
                child: Row(
                  children: [
                    Image.asset("assets/splash/dezil.png", width: 32),
                    SizedBox(width: 6),
                    Image.asset("assets/splash/gaz.png", width: 32),
                    SizedBox(width: 167),
                    Text(
                      price,
                      style: TextStyle(
                        color: Splashcolors.colorBackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
