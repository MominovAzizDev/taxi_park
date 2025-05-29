import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paycarmap/modul/car_park_card_modul.dart';
import 'package:paycarmap/modul/previous_park_card_modul.dart';
import 'package:paycarmap/service/auth_service.dart';
import 'package:paycarmap/view/pages/mycar.dart';
import 'package:paycarmap/view/pages/previous_park.dart';
import 'package:paycarmap/widgets/car_park_card.dart';
import 'package:paycarmap/widgets/reverse_parking_card.dart';

import '../../core/constants/splashColors.dart';
import '../../widgets/previous_park_card.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  final AuthService authService = AuthService();

  Map<String, dynamic>? userData;
  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Splashcolors.colorBackColor,
        leading: IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Splashcolors.containerBackColor,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: Text(
          "Home",
          style: TextStyle(color: Splashcolors.containerBackColor),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {},
              child: Image.asset("assets/splash/Group 49.png", width: 50),
            ),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.only(left: 5, bottom: 40, right: 250),
            child: Text(
              "Hello Aziz",
              style: TextStyle(
                fontSize: 22,
                color: Splashcolors.containerBackColor,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 27),
                  Text(
                    "Reserved parking spaces",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        top: 40,
                        child: ReverseParkingCard(
                          title: "Marina diamond, Dubai Marina",
                          location: "A03 (Base 2)",
                          klm: "3.3 km",
                          fromtime: "10:00 AM",
                          totime: "11:00 PM",
                          fromday: "11 Apr, 2021",
                          today: "12 Apr, 2021",
                          price: "600 AED",
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: ReverseParkingCard(
                          title: "Marina diamond, Dubai Marina",
                          location: "A03 (Base 2)",
                          klm: "3.3 km",
                          fromtime: "10:00 AM",
                          totime: "11:00 PM",
                          fromday: "11 Apr, 2021",
                          today: "12 Apr, 2021",
                          price: "600 AED",
                        ),
                      ),
                      Positioned(
                        child: ReverseParkingCard(
                          title: "Marina diamond, Dubai Marina",
                          location: "A03 (Base 2)",
                          klm: "3.3 km",
                          fromtime: "10:00 AM",
                          totime: "11:00 PM",
                          fromday: "11 Apr, 2021",
                          today: "12 Apr, 2021",
                          price: "600 AED",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 33),
                  Row(
                    children: [
                      Text(
                        "Previous parking",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 130),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreviousPark(),
                            ),
                          );
                        },
                        child: Text(
                          "View all",
                          style: TextStyle(
                            fontSize: 14,
                            color: Splashcolors.colorBackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  uid == null
                      ? const Center(
                          child: Text("Foydalanuvchi tizimga kirmagan"),
                        )
                      : StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .collection('parks')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Xatolik: ${snapshot.error}"),
                              );
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text("Hech qanday park topilmadi"),
                              );
                            }
                            return ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs.map<Widget>((doc) {
                                return PreviousParkCard(
                                  model: PreviousParkCardModul(
                                    title:
                                        doc['title']?.toString() ?? "Noma'lum",
                                    hour: doc['hour']?.toString() ?? "Noma'lum",
                                    name: doc['name']?.toString() ?? "Noma'lum",
                                    place:
                                        doc['place']?.toString() ?? "Noma'lum",
                                    klm: doc['klm']?.toString() ?? "Noma'lum",
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Text(
                  "Cars",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 240),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Mycar()),
                    );
                  },
                  child: Text(
                    "View all",
                    style: TextStyle(
                      fontSize: 14,
                      color: Splashcolors.colorBackColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            uid == null
                ? Center(child: Text("Foydalanuvchi tizimga kirmagan"))
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .collection('cars')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Xatolik: ${snapshot.error}"),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("Mashinalar topilmadi"));
                      }
                      return ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs.map((doc) {
                          return CarParkCard(
                            model: CarParkCardModul(
                              name: doc['name'] ?? 'Noma’lum',
                              carid: doc['carid'] ?? 'Noma’lum',
                              cartype:
                                  doc['cartype'] ?? 'assets/splash/taxi.png',
                              carimage:
                                  doc['carimage'] ?? 'assets/splash/mers.png',
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
