import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gs_web/dashboard.dart';
import 'package:gs_web/search_orders.dart';
import 'package:gs_web/widgets/itemHeader.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'mycard.dart';

int index = 0;

class FormWidget extends StatefulWidget {
  // name = TextEditingController();
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool enableRemove = true;
  dynamic total = 0;
  dynamic finalTotal = 0;
  dynamic netTotal = 0;
  dynamic tax = 0;
  dynamic count = [];
  dynamic discountedPrice = 0;
  dynamic discount = 0;
  DateTime timestamp = DateTime.now();
  String orderId = "ORD-" + Uuid().v1().substring(0,8);
  dynamic newFormat;

  @override
  Widget build(BuildContext context) {
    // List<Widget> _items =
    //     new List.generate(_count, (int i) => new AddNewItem());
    return MyCard(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: [
            const SizedBox(
              width: 8,
            ),
            Text(
              'Name',
              style: GoogleFonts.mitr(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextFormField(
                  // controller: name,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  textAlign: TextAlign.center,
                  // hintText: ".."
                  style: const TextStyle(
                    fontSize: 22,
                  )),
            )
          ]),
          const SizedBox(
            height: 22,
          ),
          ExpenseItemHeaderWidget(),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 3,
            color: Colors.grey[200],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('billing')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    total = 0;
                    count = [];
                    snapshot.data.docs.forEach((element) {
                      total = total +
                          (element.data()['quantity'] *
                              double.parse(element.data()['itemPrice']));

                      count.add(element.data()['quantity']);
                    });
                    return Container(
                        // height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                      constraints: BoxConstraints(minWidth: 32),
                                      child: Text(
                                        "•",
                                        style: GoogleFonts.mitr(fontSize: 20),
                                        textAlign: TextAlign.end,
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data.docs[index]
                                                  .data()['itemName'],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Row(children: [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Container(
                                          width: 200,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Center(
                                              child: Text(
                                            snapshot.data.docs[index]
                                                .data()['itemPrice']
                                                .toString(),
                                            style: TextStyle(
                                                backgroundColor: Colors.white),
                                          ))),
                                      SizedBox(
                                        width: 16,
                                      ),
                                    ]),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 16,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (count[index] == 0) {
                                              setState(() {
                                                count[index] = snapshot
                                                    .data.docs[index++]
                                                    .data()['itemPrice'];
                                              });
                                            }
                                            if (count[index] > 0) {
                                              setState(() {
                                                count[index]--;
                                              });
                                              (count[index] > 0)
                                                  ? await FirebaseFirestore
                                                      .instance
                                                      .collection('billing')
                                                      .doc(snapshot
                                                          .data.docs[index]
                                                          .data()['cartItemId'])
                                                      .update({
                                                      "quantity": count[index],
                                                    })
                                                  : await FirebaseFirestore
                                                      .instance
                                                      .collection('billing')
                                                      .doc(snapshot
                                                          .data.docs[index]
                                                          .data()['cartItemId'])
                                                      .delete();
                                              total = 0;

                                              // snapshot.data.docs
                                              //     .forEach((element) {
                                              //   setState(() {
                                              //     total = total +
                                              //         (element.data()[
                                              //                 'quantity'] *
                                              //             double.parse(element
                                              //                     .data()[
                                              //                 'itemPrice']));
                                              //   });
                                              // });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(6),
                                            child: const Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        Container(
                                            width: 80,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Center(
                                              child: (count[index] != 0)
                                                  ? Text(
                                                      count[index].toString(),
                                                      style: TextStyle(
                                                          backgroundColor:
                                                              Colors.white),
                                                    )
                                                  : Text(
                                                      snapshot.data.docs[index]
                                                          .data()['quantity']
                                                          .toString(),
                                                      style: TextStyle(
                                                          backgroundColor:
                                                              Colors.white),
                                                    ),
                                            )),
                                        SizedBox(
                                          width: 6,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              count[index]++;
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('billing')
                                                .doc(snapshot.data.docs[index]
                                                    .data()['cartItemId'])
                                                .update({
                                              "quantity": count[index],
                                            });

                                            print(count[index].toString());
                                            // snapshot.data.docs
                                            //     .forEach((element) {
                                            //   setState(() {
                                            //     total = total +
                                            //         (element.data()[
                                            //                 'quantity'] *
                                            //             double.parse(
                                            //                 element.data()[
                                            //                     'itemPrice']));
                                            //   });
                                            // });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(6),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.deepOrange,
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Container(
                                              width: 200,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Center(
                                                  child: Text(
                                                (snapshot.data.docs[index]
                                                                .data()[
                                                            'quantity'] *
                                                        double.parse(snapshot
                                                                .data
                                                                .docs[index]
                                                                .data()[
                                                            'itemPrice']))
                                                    .toString(),
                                                style: const TextStyle(
                                                    backgroundColor:
                                                        Colors.white),
                                              ))),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      )),
                                  if (enableRemove)
                                    GestureDetector(
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .collection('billing')
                                            .doc(snapshot.data.docs[index]
                                                .data()['cartItemId'])
                                            .delete();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                        decoration: BoxDecoration(
                                            color: Colors.red[300],
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ));
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    finalTotal = total;
                    discountedPrice = finalTotal - discount;
                    netTotal = (finalTotal - discount) +
                        ((finalTotal - discount) * (tax / 100));
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      "Update",
                      style:
                          GoogleFonts.mitr(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ]),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  // setState(() {
                  //   _addNewItemRow();
                  // });

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchOrders()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      "Add Item",
                      style:
                          GoogleFonts.mitr(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ]),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () async {
                  final List<dynamic> items = [];

                  final QuerySnapshot _query = await FirebaseFirestore.instance
                      .collection('billing')
                      .get();

                  _query.docs.forEach((QueryDocumentSnapshot val) {
                    print(val.data()['itemName']);

                    setState(() {
                      items.add({
                        "itemName": val.data()['itemName'],
                        "itemPrice": val.data()['itemPrice'],
                        "quantity": val.data()['quantity']
                      });
                    });
                  });
                  print(items.toString());
                  newFormat = DateFormat("yyyy-MM-dd");
                  dynamic updatedDt =
                  newFormat.format(timestamp);
                  await FirebaseFirestore.instance
                      .collection('offlineBills')
                      .doc(orderId)
                      .set({
                    "orderId": orderId,
                    "tax": tax ?? 0,
                    "billAmount": netTotal ?? finalTotal,
                    "items": items,
                    "timestamp": timestamp,
                    "name": name ?? "abcd",
                    "date": updatedDt
                  });

                  await FirebaseFirestore.instance
                      .collection('billing')
                      .get()
                      .then((QuerySnapshot value) {
                    for (DocumentSnapshot ds in value.docs) {
                      ds.reference.delete();
                    }
                  });

                  setState(() {
                    total = 0;
                    finalTotal = 0;
                    netTotal = 0;
                    tax = 0;
                    discountedPrice = 0;
                    discount = 0;
                    name = '';
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      'Save Order',
                      style:
                          GoogleFonts.mitr(fontSize: 20, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 8,
                    )
                  ]),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Spacer(),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          "Total",
                          style: GoogleFonts.mitr(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child:
                                  Center(child: Text(finalTotal.toString()))),
                          const SizedBox(
                            width: 8,
                          ),
                        ]),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Get Discount",
                                style: GoogleFonts.mitr(fontSize: 18),
                                textAlign: TextAlign.center,
                              )
                            ]),
                        const SizedBox(
                          height: 4,
                        ),
                        Visibility(
                          // visible: expensePerson.isGetDiscount,
                          child: Row(children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextField(
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    discount = double.parse(value);
                                  });
                                },
                                // controller: expensePerson.discountPersonController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.orange()
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                          ]),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Tax in %",
                                style: GoogleFonts.mitr(fontSize: 18),
                                textAlign: TextAlign.center,
                              )
                            ]),
                        const SizedBox(
                          height: 4,
                        ),
                        Visibility(
                          // visible: expensePerson.isGetDiscount,
                          child: Row(children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  suffix: Text("%"),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 2.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    tax = int.parse(value);
                                  });
                                },
                                // controller: expensePerson.discountPersonController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.orange()
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                          ]),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          'Net Total',
                          style: GoogleFonts.mitr(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(children: [
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Center(child: Text(netTotal.toString()))),
                          // Expanded(
                          //   child: TextField(
                          //     decoration: InputDecoration(
                          //       enabledBorder: OutlineInputBorder(
                          //         borderSide: BorderSide(
                          //             color: Colors.grey, width: 2.0),
                          //       ),
                          //     ),
                          //     // controller: expensePerson.totalPersonController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.green()
                          //   ),
                          // ),
                          const SizedBox(
                            width: 8,
                          ),
                        ]),
                      ],
                    )),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 3,
            color: Colors.grey[100],
          ),
          // ExpenseItemTotalWidget(expensePerson, onChanged: (g) {
          //   update();
          // }),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
