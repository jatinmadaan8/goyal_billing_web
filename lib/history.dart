import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gs_web/widgets/new_order_details.dart';
import 'package:gs_web/widgets/order_data.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('offlineBills').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.docs?.length ?? 0,
                  itemBuilder: (BuildContext context,int index){
                    return Card(
                      child: ListTile(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewOrderDetails(
                                    orders: OrderData(
                                      name: snapshot.data.docs[index].data()['name'].toString(),
                                      items: snapshot.data.docs[index].data()['items'],
                                      totalPrice: snapshot.data.docs[index].data()['billAmount'],
                                      timestamp: snapshot.data.docs[index].data()['timestamp'],
                                      mode: snapshot.data.docs[index].data()['tax'].toString(),
                                    ),
                                  )));
                        },
                        title: Text('Order ID: ${snapshot.data.docs[index].data()['orderId']}'),
                        subtitle: Text(timeago.format(snapshot.data.docs[index].data()['timestamp'].toDate()),
                      ),
                      )
                    );
                  },
                ),

              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
