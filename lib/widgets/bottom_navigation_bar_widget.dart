import 'package:flutter/material.dart';
import 'package:paycarmap/view/pages/car_map.dart';
import 'package:paycarmap/view/pages/homepages.dart';
import 'package:paycarmap/view/pages/mycar.dart';
import 'package:paycarmap/view/pages/previous_park.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _seleted = 0;

  final List<Widget> pages = [Homepages(), CarMap(), PreviousPark(), Mycar()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_seleted],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black26,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
        currentIndex: _seleted,
        onTap: (int index) {
          setState(() {
            _seleted = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: "Map"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: "Money",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label: "Notification",
          ),
        ],
      ),
    );
  }
}
