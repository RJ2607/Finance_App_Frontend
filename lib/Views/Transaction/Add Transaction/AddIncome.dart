import 'package:finance_manager/Controllers/transactionController.dart';
import 'package:flutter/material.dart';

import '../../../widgets/showSnackBar.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  TransactionController transactionController = TransactionController();

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 40, 14, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Add Income',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: const TextStyle(
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
                    const SizedBox(
                      height: 20,
                    ),
                    // create a dropdown menu for category with icons
                    DropdownMenu(
                        controller: categoryController,
                        enableFilter: true,
                        label: const Text('Category',
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        width: MediaQuery.of(context).size.width * 0.726,
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(
                            value: 'Salary',
                            label: 'Salary',
                          ),
                          DropdownMenuEntry(
                            value: 'Pocket Money',
                            label: 'Pocket Money',
                          ),
                          DropdownMenuEntry(
                            value: 'Transfer',
                            label: 'Transfer',
                          ),
                          DropdownMenuEntry(
                            value: 'Others',
                            label: 'Others',
                          ),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                        labelText: 'Note',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        handleIncome();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
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

  void handleIncome() async {
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
          .addIncome(double.parse(amountController.text), dateController.text,
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
