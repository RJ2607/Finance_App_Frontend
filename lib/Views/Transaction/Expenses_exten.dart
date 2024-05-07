// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:finance_manager/components/barChart.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/transactionController.dart';

class ExpensesExten extends StatefulWidget {
  const ExpensesExten({super.key});

  @override
  State<ExpensesExten> createState() => _ExpensesExtenState();
}

class _ExpensesExtenState extends State<ExpensesExten> {
  final _transactionController = TransactionController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
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
                  FutureBuilder(
                      future: _transactionController.getTotalBalance(),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return Text('');
                        }
                        if (snap.data![0]['total expense'] == null) {
                          return Text(
                            '\$ 0',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                        return Text(
                          '\$ ${snap.data![0]['total expense']}',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      })
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //add 10 mock entries through a generator
              FutureBuilder(
                  future: _transactionController.getAllTransactions(),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Shimmer(
                          period: Duration(seconds: 1),
                          child: Container(
                            width: double.maxFinite,
                            height: MediaQuery.of(context).size.height * 0.08,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          gradient: LinearGradient(colors: [
                            const Color.fromARGB(255, 58, 58, 58),
                            const Color.fromARGB(255, 0, 0, 0),
                            const Color.fromARGB(255, 58, 58, 58),
                            const Color.fromARGB(255, 0, 0, 0)
                          ]),
                          loop: 6);
                    }

                    if (snap.connectionState == ConnectionState.done &&
                        snap.hasData == false) {
                      {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 25,
                            child: Icon(
                              Iconsax.empty_wallet,
                              color: Colors.white,
                            ),
                          ),
                          title: Text('No Expense Transactions'),
                        );
                      }
                    }

                    return Column(
                      children: [
                        //add 10 mock entries through a generator
                        ...List.generate(
                          snap.data!.length,
                          (index) => snap.data![index]['type'] == 'Expense'
                              ? ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 25,
                                    child: Icon(
                                      Icons.electrical_services,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(snap.data![index]['category']),
                                  subtitle: Text(snap.data![index]['note']),
                                  trailing: Text(
                                    '\$ ${snap.data![index]['amount']}',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        )
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
