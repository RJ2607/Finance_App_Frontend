// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finance_manager/components/barChart.dart';
import 'package:flutter/material.dart';

class ExpensesExten extends StatefulWidget {
  const ExpensesExten({super.key});

  @override
  State<ExpensesExten> createState() => _ExpensesExtenState();
}

class _ExpensesExtenState extends State<ExpensesExten> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 553,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              WeekBarChart(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sat, 10 February 2024',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
                  Text(
                    '\$ 5000',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //add 10 mock entries through a generator
              ...List.generate(
                10,
                (index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 25,
                    child: Icon(
                      Icons.electrical_services,
                      color: Colors.white,
                    ),
                  ),
                  title: Text('Electricity Bill'),
                  subtitle: Text('Electricity'),
                  trailing: Text(
                    '-\$ 500',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
