import 'package:finance_manager/components/circularChart.dart';
import 'package:flutter/material.dart';

class IncomeExten extends StatefulWidget {
  const IncomeExten({super.key});

  @override
  State<IncomeExten> createState() => _IncomeExtenState();
}

class _IncomeExtenState extends State<IncomeExten> {
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
                    Text(
                      '\$ 5000',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 326,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //add 10 mock entries through a generator
                        ...List.generate(
                          10,
                          (index) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 25,
                              child: Icon(
                                Icons.electrical_services,
                                color: Colors.white,
                              ),
                            ),
                            title: Text('Electricity Bill'),
                            subtitle: Text('Electricity'),
                            trailing: Text(
                              '\$ 500',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
