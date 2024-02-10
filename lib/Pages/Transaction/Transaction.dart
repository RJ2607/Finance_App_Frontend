// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:finance_manager/Pages/Transaction/Expenses_exten.dart';
import 'package:finance_manager/Pages/Transaction/Income_exten.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  const Transaction({super.key});

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool isSwitched = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.fromLTRB(14, 40, 14, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Transactions',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                  )),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  CupertinoIcons.gear,
                  size: 25,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          optionButtons(),
          SizedBox(
            height: 15,
          ),
          isSwitched ? IncomeExten() : ExpensesExten(),
        ],
      ),
    ));
  }

  Container optionButtons() {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage('assets/images/me.jpg'),
        //   fit: BoxFit.cover,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: -5,
            blurRadius: 25,
          ),
        ],
        shape: BoxShape.rectangle,
        color: const Color.fromARGB(255, 0, 0, 0),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white30, Colors.white10]),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: isSwitched
                                ? [
                                    Colors.blue,
                                    Colors.purple,
                                    Colors.pink,
                                    Colors.red
                                  ]
                                : [
                                    Colors.black.withOpacity(0.7),
                                    Colors.black.withOpacity(0.5)
                                  ],
                            transform: GradientRotation(0.5))),
                    child: TextButton(
                      onPressed: () {
                        // create a system when pressing button then only gradient background comes
                        setState(() {
                          isSwitched = true;
                        });
                      },
                      child: Text(
                        'Income',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    // padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: isSwitched
                                ? [
                                    Colors.black.withOpacity(0.7),
                                    Colors.black.withOpacity(0.5)
                                  ]
                                : [
                                    Colors.blue,
                                    Colors.purple,
                                    Colors.pink,
                                    Colors.red
                                  ],
                            transform: GradientRotation(0.5))),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isSwitched = false;
                        });
                      },
                      child: Text(
                        'Expenses',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
