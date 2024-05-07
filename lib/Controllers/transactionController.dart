import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionController {
  CollectionReference transactions =
      FirebaseFirestore.instance.collection('transaction');

  Future<void> addIncome(double amount, String date, String category,
      String note, BuildContext context) async {
    await transactions.add({
      'amount': amount,
      'date': date,
      'category': category,
      'note': note,
      'type': 'Income',
      'user': FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
    });
  }

  Future<void> addExpense(double amount, String date, String category,
      String note, BuildContext context) async {
    await transactions.add({
      'amount': amount,
      'date': date,
      'category': category,
      'note': note,
      'type': 'Expense',
      'user': FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
    });
  }

  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      final userTransactions = await FirebaseFirestore.instance
          .collection('transaction')
          .where('user', isEqualTo: userRef)
          .get();

      return userTransactions.docs.map((e) => e.data()).toList();
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTotalBalance() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      final userTransactions = await FirebaseFirestore.instance
          .collection('transaction')
          .where('user', isEqualTo: userRef)
          .get();

      List<Map<String, dynamic>> transactionsData =
          userTransactions.docs.map((e) => e.data()).toList();

      List<Map<String, dynamic>> totalBalance = [
        {
          'total amount': transactionsData
              .map((e) => e['type'] == 'Income' ? e['amount'] : -e['amount'])
              .reduce((value, element) => value + element),
          'total income': transactionsData
              .where((element) => element['type'] == 'Income')
              .map((e) => e['amount'])
              .reduce((value, element) => value + element),
          'total expense': transactionsData
              .where((element) => element['type'] == 'Expense')
              .map((e) => e['amount'])
              .reduce((value, element) => value + element)
        }
      ];

      // print(totalBalance);
      return totalBalance;
    } else {
      return [];
    }
  }
}
