import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gs_web/search_orders.dart';
import 'package:gs_web/widgets/itemHeader.dart';
import 'package:gs_web/widgets/total.dart';
import 'mycard.dart';

int index = 0;

class FormWidget extends StatefulWidget {
  // name = TextEditingController();
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  int _count = 1;
  bool enableRemove = true;
  dynamic total = 0;
  dynamic count = [];

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
            SizedBox(
              width: 8,
            ),
            Text(
              "Name",
              style: GoogleFonts.mitr(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextField(
                  // controller: name,
                  textAlign: TextAlign.center,
                  // hintText: ".."
                  style: TextStyle(
                    fontSize: 22,
                  )),
            )
          ]),
          SizedBox(
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
          SizedBox(
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
                    print(count.toString());
                    print(total.toString());
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
                                          SizedBox(
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
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.orange[300],
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
                                            padding: EdgeInsets.all(6),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.blue[300],
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        children: [
                                          SizedBox(
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
                                                style: TextStyle(
                                                    backgroundColor:
                                                        Colors.white),
                                              ))),
                                          SizedBox(
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
                                        padding: EdgeInsets.all(6),
                                        child: Icon(
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
                                      padding: EdgeInsets.all(6),
                                      child: Icon(
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
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                }),
          ),
          InkWell(
            onTap: () {
              // setState(() {
              //   _addNewItemRow();
              // });

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchOrders()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  "Add Item",
                  style: GoogleFonts.mitr(fontSize: 20, color: Colors.white),
                ),
                SizedBox(
                  width: 8,
                )
              ]),
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Spacer(),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          "Total Food Expenses",
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
                              child: Center(child: Text(total.toString()))),
                          SizedBox(
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
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Get Discount",
                                style: GoogleFonts.mitr(fontSize: 18),
                                textAlign: TextAlign.center,
                              )
                            ]),
                        SizedBox(
                          height: 4,
                        ),
                        Visibility(
                          // visible: expensePerson.isGetDiscount,
                          child: Row(children: [
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextField(
                                  decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              )
                                  // controller: expensePerson.discountPersonController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.orange()
                                  ),
                            ),
                            SizedBox(
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
                          "Net Total",
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
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey, width: 2.0),
                                ),
                              ),
                              // controller: expensePerson.totalPersonController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.green()
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ]),
                      ],
                    )),
                Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 3,
            color: Colors.grey[100],
          ),
          // ExpenseItemTotalWidget(expensePerson, onChanged: (g) {
          //   update();
          // }),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

//   void _addNewItemRow() {
//     setState(() {
//       _count = _count + 1;
//     });
//   }
// }
//
// class AddNewItem extends StatefulWidget {
//   @override
//   _AddNewItemState createState() => _AddNewItemState();
// }
//
// class _AddNewItemState extends State<AddNewItem> {
//   bool enableRemove = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 4),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Container(
//                   constraints: BoxConstraints(minWidth: 32),
//                   child: Text(
//                     "•",
//                     style: GoogleFonts.mitr(fontSize: 20),
//                     textAlign: TextAlign.end,
//                   )),
//               Expanded(
//                   flex: 1,
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Expanded(
//                           child: TextField(
//                         // controller: expenseItemController.nameController, fontSize: 22,  hintText: ".."
//                         textAlign: TextAlign.center,
//                         decoration: new InputDecoration(
//                           hintText: "Enter Item Name",
//                         ),
//                       )),
//                       SizedBox(
//                         width: 16,
//                       ),
//                     ],
//                   )),
//               Expanded(
//                 flex: 1,
//                 child: Row(children: [
//                   SizedBox(
//                     width: 16,
//                   ),
//                   Expanded(
//                       child: TextField(
//                     // controller: expenseItemController.priceController,
//                     // fontSize: 22,
//                     textAlign: TextAlign.center,
//                     keyboardType: TextInputType.numberWithOptions(
//                       signed: false,
//                       decimal: true,
//                     ),
//                     decoration: new InputDecoration(
//                       hintText: "Enter Price",
//                     ),
//                     // hintText: "0",
//                     // onChanged: (text) {
//                     //   double price = double.tryParse(text) ?? 0;
//                     //   if (onPriceChanged != null) {
//                     //     onPriceChanged(expenseItemController, price);
//                     //   }
//                     // }
//                   )),
//                   SizedBox(
//                     width: 16,
//                   ),
//                 ]),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: 16,
//                     ),
//                     GestureDetector(
//                       // onTap: () {
//                       //   expenseItemController.decreaseAmount();
//                       //   if (onAmountChanged != null) {
//                       //     onAmountChanged(expenseItemController, expenseItemController.expenseItem.amount);
//                       //   }
//                       // },
//                       child: Container(
//                         padding: EdgeInsets.all(6),
//                         child: Icon(
//                           Icons.remove,
//                           color: Colors.white,
//                           size: 32,
//                         ),
//                         decoration: BoxDecoration(
//                             color: Colors.orange[300],
//                             borderRadius: BorderRadius.circular(6)),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     Expanded(
//                         child: TextField(
//                       // controller: expenseItemController.amountController,
//                       textAlign: TextAlign.center,
//                       decoration: new InputDecoration(
//                         hintText: "0",
//                       ),
//                       //
//                       // onChanged: (text) {
//                       //   int amount = double.tryParse(text) ?? 0;
//                       //   if (onAmountChanged != null) {
//                       //     onAmountChanged(expenseItemController, amount);
//                       //   }
//                       // }
//                     )),
//                     SizedBox(
//                       width: 6,
//                     ),
//                     GestureDetector(
//                       // onTap: () {
//                       //   expenseItemController.increaseAmount();
//                       //   if (onAmountChanged != null) {
//                       //     onAmountChanged(expenseItemController, expenseItemController.expenseItem.amount);
//                       //   }
//                       // },
//                       child: Container(
//                         padding: EdgeInsets.all(6),
//                         child: Icon(
//                           Icons.add,
//                           color: Colors.white,
//                           size: 32,
//                         ),
//                         decoration: BoxDecoration(
//                             color: Colors.blue[300],
//                             borderRadius: BorderRadius.circular(6)),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 16,
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                   flex: 1,
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Expanded(
//                         child: TextField(
//                           textAlign: TextAlign.center,
//                           decoration: new InputDecoration(
//                             hintText: "0",
//                           ),
//                           // controller: expenseItemController.sumController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.primary()
//                         ),
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                     ],
//                   )),
//               if (enableRemove)
//                 GestureDetector(
//                   // onTap: onRemoveItem,
//                   child: Container(
//                     padding: EdgeInsets.all(6),
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.white,
//                       size: 32,
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.red[300],
//                         borderRadius: BorderRadius.circular(6)),
//                   ),
//                 )
//               else
//                 Container(
//                   padding: EdgeInsets.all(6),
//                   child: Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 32,
//                   ),
//                   decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       borderRadius: BorderRadius.circular(6)),
//                 )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
}
