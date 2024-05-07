import 'package:finance_manager/components/circularChart.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/transactionController.dart';

class IncomeExten extends StatefulWidget {
  const IncomeExten({super.key});

  @override
  State<IncomeExten> createState() => _IncomeExtenState();
}

class _IncomeExtenState extends State<IncomeExten> {
  final _transactionController = TransactionController();
  @override
  Widget build(BuildContext context) {
    double perc = 60;
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 170,
                  width: 170,
                  child: CircularChart(
                    duration: 1,
                    perc: perc,
                    startOffset: -135,
                    endOffset: 135,
                    color: Colors.redAccent,
                  ),
                ),
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
                            '\$ ${snap.data![0]['total income']}',
                            style: TextStyle(
                              color: Colors.green,
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
                SizedBox(
                  height: 326,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: FutureBuilder(
                        future: _transactionController.getAllTransactions(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Shimmer(
                                period: Duration(seconds: 1),
                                child: Container(
                                  width: double.maxFinite,
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
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
                                  backgroundColor: Colors.green,
                                  radius: 25,
                                  child: Icon(
                                    Iconsax.empty_wallet,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text('No Income Transactions'),
                              );
                            }
                          }

                          return Column(
                            children: [
                              //add 10 mock entries through a generator
                              ...List.generate(
                                snap.data!.length,
                                (index) => snap.data![index]['type'] == 'Income'
                                    ? ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 25,
                                          child: Icon(
                                            Icons.electrical_services,
                                            color: Colors.white,
                                          ),
                                        ),
                                        title:
                                            Text(snap.data![index]['category']),
                                        subtitle:
                                            Text(snap.data![index]['note']),
                                        trailing: Text(
                                          '\$ ${snap.data![index]['amount']}',
                                          style: TextStyle(
                                            color: Colors.green,
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
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
