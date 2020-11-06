import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gs_web/history.dart';
import 'package:gs_web/widgets/form_widget.dart';
import 'package:gs_web/widgets/mycard.dart';
import 'package:gs_web/widgets/order_pdf.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

String name;

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepOrange,
        label: const Text('History'),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HistoryPage()));
        },
      ),
      body: ListView(
        children: [
          buildNavBar(),
          FormWidget(),
        ],
      ),
    );
  }

  Widget buildNavBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.grey[100], width: 2))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Goyal Sales",
                  style: GoogleFonts.mitr(fontSize: 25, color: Colors.deepOrange,),
                  textAlign: TextAlign.end,
                ),
                const Spacer(),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('billing')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      return IconButton(
                        icon: const Icon(Icons.print),
                        color: Colors.deepOrange,
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => OrdersPdf(
                          //               orders: snapshot.data.docs,
                          //             )));
                          setState(() {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                content: OrdersPdf(
                                  orders: snapshot.data.docs,
                                ),
                              ),
                            );
                          });
                        },
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
