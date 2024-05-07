import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyTest extends StatefulWidget {
  const MyTest({super.key});

  @override
  State<MyTest> createState() => _MyTestState();
}

class _MyTestState extends State<MyTest> {
  List<Map<String, dynamic>> transactionsData = [];
  TextEditingController typeController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference transactions =
      FirebaseFirestore.instance.collection('transaction');
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('transaction').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getTotalBalance();
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text('${data['type']},${data['note']}'),
                subtitle: Text(data['amount'].toString()),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Test'),
  //     ),
  //     body: Center(
  //       child: Column(
  //         children: [
  //           TextField(
  //             controller: typeController,
  //             decoration: const InputDecoration(labelText: 'Type'),
  //           ),
  //           TextField(
  //             controller: amountController,
  //             decoration: const InputDecoration(labelText: 'Amount'),
  //           ),
  //           TextField(
  //             controller: commentController,
  //             decoration: const InputDecoration(labelText: 'Comment'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               addUser();
  //             },
  //             child: const Text('Submit'),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return transactions
        .add({
          'amount': int.parse(amountController.text), // John Doe
          'type': typeController.text, // Stokes and Sons
          'comment': commentController.text, // 42
          'user': users.doc(FirebaseAuth.instance.currentUser!.uid)
        })
        .then((value) => print(value))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> getAllTransactions() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      final userTransactions = await FirebaseFirestore.instance
          .collection('transaction')
          .where('user', isEqualTo: userRef)
          .get();

      print(userTransactions.docs.map((e) => e.data()).toList());
      // return userTransactions.docs[-1].data();
    } else {
      // return {'error': 'User document does not exist'};
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

      transactionsData = userTransactions.docs.map((e) => e.data()).toList();

      List<Map<String, dynamic>> totalBalance = [
        {
          'total balance': transactionsData
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

      print(totalBalance);
      return totalBalance;
    } else {
      return [];
    }
  }
}
