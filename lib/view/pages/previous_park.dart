import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paycarmap/service/auth_service.dart';
import 'package:paycarmap/widgets/previous_park_card.dart';

import '../../core/constants/splashColors.dart';
import '../../modul/previous_park_card_modul.dart';

class PreviousPark extends StatefulWidget {
  const PreviousPark({super.key});

  @override
  State<PreviousPark> createState() => _PreviousParkState();
}

class _PreviousParkState extends State<PreviousPark> {
  void _showAddPark() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController titleController = TextEditingController();
        TextEditingController hourController = TextEditingController();
        TextEditingController nameController = TextEditingController();
        TextEditingController placeController = TextEditingController();
        TextEditingController klmController = TextEditingController();
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text("Park qo'shish"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Titleni kiriting"),
                ),
                TextField(
                  controller: hourController,
                  decoration: InputDecoration(labelText: "Soatini kiriting"),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Nomini kiriting"),
                ),
                TextField(
                  controller: placeController,
                  decoration: InputDecoration(labelText: "Joyini kiriting"),
                ),
                TextField(
                  controller: klmController,
                  decoration: InputDecoration(labelText: "Masofani kiriting"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final uid = FirebaseAuth.instance.currentUser?.uid;
                  if (uid == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Foydalanuvchi tizimga kirmagan"),
                      ),
                    );
                    return;
                  }
                  if (titleController.text.isEmpty ||
                      hourController.text.isEmpty ||
                      nameController.text.isEmpty ||
                      placeController.text.isEmpty ||
                      klmController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Barcha maydonlarni to'ldiring"),
                      ),
                    );
                    return;
                  }
                  await AuthService().addCarPark(
                    uid,
                    titleController.text,
                    hourController.text,
                    nameController.text,
                    placeController.text,
                    klmController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text("Qo'shish"),
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
          icon: const Icon(Icons.menu),
        ),
        title: Text(
          "Previous parking",
          style: TextStyle(color: Splashcolors.containerBackColor),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
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
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 33),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "My Previous parking",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: _showAddPark,
                        child: Text(
                          "Park qo'shish",
                          style: TextStyle(
                            color: Splashcolors.colorBackColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
          ],
        ),
      ),
    );
  }
}
