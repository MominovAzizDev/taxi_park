import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paycarmap/service/auth_service.dart';

import '../../core/constants/splashColors.dart';
import '../../modul/car_park_card_modul.dart';
import '../../widgets/car_park_card.dart';

class Mycar extends StatefulWidget {
  const Mycar({super.key});

  @override
  State<Mycar> createState() => _MycarState();
}

class _MycarState extends State<Mycar> {
  void _showAddCarDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController carIdController = TextEditingController();
        TextEditingController imageController = TextEditingController();
        TextEditingController iconController = TextEditingController();
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text("Mashina qo'shish"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Mashina nomi"),
                ),
                TextField(
                  controller: carIdController,
                  decoration: InputDecoration(labelText: "Mashina ID"),
                ),
                TextField(
                  controller: imageController,
                  decoration: InputDecoration(
                    labelText: "Rasm nomini kiriting(tesla, mers, ford)",
                  ),
                ),
                TextField(
                  controller: iconController,
                  decoration: InputDecoration(
                    labelText:
                        "Icon nomini kiriting(electrtaxi, delivery, taxi)",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await AuthService().addCarToFirestore(
                    FirebaseAuth.instance.currentUser!.uid,
                    nameController.text,
                    carIdController.text,
                    "assets/splash/${iconController.text}.png",
                    "assets/splash/${imageController.text}.png",
                  );
                  Navigator.pop(context);
                },
                child: Text("Qo‘shish"),
              ),
            ],
          ),
        );
      },
    );
  }

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
          "Cars",
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
                  SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        "My Cars",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 170),
                      InkWell(
                        onTap: _showAddCarDialog,
                        child: Text(
                          "+ Add new car",
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
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Xatolik: ${snapshot.error}"),
                              );
                            }
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: Text("Mashinalar topilmadi"),
                              );
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
                                        doc['cartype'] ??
                                        'assets/splash/taxi.png',
                                    carimage:
                                        doc['carimage'] ??
                                        'assets/splash/mers.png',
                                  ),
                                );
                              }).toList(),
                            );
                          },
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
