// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:finance_manager/Views/Transaction/Add%20Transaction/AddTransaction.dart';
import 'package:finance_manager/Views/Transaction/Transaction.dart';
import 'package:finance_manager/Views/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class BottomNav extends StatefulWidget {
  BottomNav({
    Key? key,
    this.tab = 0,
  }) : super(key: key);
  int tab;

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // int val = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Transaction()
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.tab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(widget.tab),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          // selectedItemColor: Colors.deepPurpleAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home_1_outline),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.transaction_minus_outline),
              label: 'Transaction',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 10),
              ),
            ],
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              transform: GradientRotation(0.5),
            ),
          ),
          child: Icon(CupertinoIcons.add),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTransaction()));
        },
        shape: CircleBorder(),
        tooltip: 'Add Transaction',
      ),
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
