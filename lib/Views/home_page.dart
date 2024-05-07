// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_manager/Controllers/transactionController.dart';
import 'package:finance_manager/Views/settings/Profile.dart';
import 'package:finance_manager/Views/settings/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  final _transactionController = TransactionController();
  CollectionReference transaction =
      FirebaseFirestore.instance.collection('transaction');
  final user = FirebaseAuth.instance.currentUser;
  double _scrollPosition = 0;
  double appBarHeight = 200;
  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _scrollPosition = _controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(double.maxFinite),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
            child: topBar(context),
          )),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: _buildScrollable(),
      ),
    );
  }

  Widget _buildScrollable() {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          pinned: true,
          flexibleSpace: FutureBuilder(
              future: _transactionController.getTotalBalance(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Shimmer(
                    child: Container(
                      width: double.maxFinite,
                      height: _scrollPosition < 100
                          ? appBarHeight - _scrollPosition
                          : 100,
                      constraints: BoxConstraints(
                        minHeight: 80,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.purple, Colors.orange],
                            transform: GradientRotation(0.6)),
                      ),
                    ),
                    gradient: LinearGradient(colors: [
                      const Color.fromARGB(255, 58, 58, 58),
                      const Color.fromARGB(255, 0, 0, 0),
                      const Color.fromARGB(255, 58, 58, 58),
                      const Color.fromARGB(255, 0, 0, 0)
                    ]),
                    loop: 6,
                  );
                }
                if (snapshot.data.length == 0) {
                  return Container(
                    width: double.maxFinite,
                    height: _scrollPosition < 100
                        ? appBarHeight - _scrollPosition
                        : 100,
                    constraints: BoxConstraints(
                      minHeight: 80,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                          colors: [Colors.blue, Colors.purple, Colors.orange],
                          transform: GradientRotation(0.6)),
                    ),
                    child: Center(child: Text('No Data')),
                  );
                }
                return totalBalance(snapshot.data[0]);
              }),
          collapsedHeight: MediaQuery.of(context).size.height * 0.1,
          expandedHeight: MediaQuery.of(context).size.height * 0.25,
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Transactions',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey,
                    )),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return FutureBuilder(
                future: _transactionController.getAllTransactions(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text('No Transactions Yet'),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(75, 57, 56, 56),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(72, 61, 60, 60),
                                  ),
                                  child: Icon(
                                    snapshot.data[index]['type'] == 'Income'
                                        ? CupertinoIcons.arrow_down
                                        : CupertinoIcons.arrow_up,
                                    color:
                                        snapshot.data[index]['type'] == 'Income'
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data[index]['type'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "\$ ${snapshot.data[index]['amount']}",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data[index]['date'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  snapshot.data[index]['category'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  Container totalBalance(
    totalBalance,
  ) {
    return Container(
      width: double.maxFinite,
      height: _scrollPosition < 100 ? appBarHeight - _scrollPosition : 100,
      constraints: BoxConstraints(
        minHeight: 80,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple, Colors.orange],
            transform: GradientRotation(0.6)),
      ),
      child: _scrollPosition < 23
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\$ ${totalBalance['total amount']}",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(72, 61, 60, 60),
                              ),
                              child: Icon(
                                CupertinoIcons.arrow_down,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Income',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "\$ ${totalBalance['total income']}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(72, 61, 60, 60),
                              ),
                              child: Icon(
                                CupertinoIcons.arrow_up,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expense',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "\$ ${totalBalance['total expense']}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(72, 61, 60, 60),
                        ),
                        child: Icon(
                          CupertinoIcons.arrow_down,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "\$ 1,000,000",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(72, 61, 60, 60),
                        ),
                        child: Icon(
                          CupertinoIcons.arrow_up,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Expense',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "\$ 8,000",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Row topBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.08,
            // width: MediaQuery.of(context).size.width * 0.38,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(
                width: 1,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(75, 57, 56, 56),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: user!.photoURL == null
                      ? Image.asset(
                          'assets/images/user.png',
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.05,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          user!.photoURL.toString(),
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.05,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Text(
                      user!.displayName.toString(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.018,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MySettings(),
                ));
          },
          icon: Icon(
            Iconsax.setting_2_outline,
            size: 25,
          ),
        ),
      ],
    );
  }
}
