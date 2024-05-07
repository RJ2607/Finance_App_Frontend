// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../../Controllers/transactionController.dart';
import '../../../widgets/showSnackBar.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  Icon category = Icon(Icons.food_bank);
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  TransactionController transactionController = TransactionController();

  bool isloading = false;

  void dispose() {
    amountController.dispose();
    dateController.dispose();
    categoryController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14, 40, 14, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Add Expenses',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onTap: () async {
                        var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        dateController.text = date.toString().substring(0, 10);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // create a dropdown menu for category with icons
                    DropdownMenu(
                        controller: categoryController,
                        enableFilter: true,
                        label: Text('Category',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        width: MediaQuery.of(context).size.width * 0.726,
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        dropdownMenuEntries: <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(
                            value: 'Food',
                            label: 'Food',
                          ),
                          DropdownMenuEntry(
                            value: 'Shopping',
                            label: 'Shopping',
                          ),
                          DropdownMenuEntry(
                            value: 'Transportation',
                            label: 'Transportation',
                          ),
                          DropdownMenuEntry(
                            value: 'Car',
                            label: 'Car',
                          ),
                          DropdownMenuEntry(
                            value: 'Medical',
                            label: 'Medical',
                          ),
                          DropdownMenuEntry(
                            value: 'Entertainment',
                            label: 'Entertainment',
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        handleExpense();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.purple,
                              Colors.pink,
                              Colors.red,
                            ],
                            transform: GradientRotation(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: isloading
                            ? SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeCap: StrokeCap.round,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> handleExpense() async {
    setState(() {
      isloading = true;
    });

    if (amountController.text.isEmpty ||
        dateController.text.isEmpty ||
        categoryController.text.isEmpty ||
        noteController.text.isEmpty) {
      showSnackBar(context, 'All fields are required', Colors.red);
    } else {
      await transactionController
          .addExpense(double.parse(amountController.text), dateController.text,
              categoryController.text, noteController.text, context)
          .then((value) => {
                amountController.clear(),
                dateController.clear(),
                categoryController.clear(),
                noteController.clear(),
              })
          .catchError((error) {
        showSnackBar(context, error.toString(), Colors.red);
      });
      showSnackBar(context, 'Expense added successfully', Colors.green);
    }

    setState(() {
      isloading = false;
    });
  }
}
