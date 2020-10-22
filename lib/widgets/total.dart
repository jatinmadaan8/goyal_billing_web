import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class ExpenseItemTotalWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 2.0),
                            ),
                        ),
                          // controller: expensePerson.sumExpenseController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.primary()),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ]),
                ],
              )),
          // Expanded(
          //     flex: 1,
          //     child: Column(
          //       children: [
          //         // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //         //   MyCheckBox(
          //         //     // value: expensePerson.isPayDeliver,
          //         //     color: Colors.pink[400],
          //         //     onChanged: (v){
          //         //       // expensePerson.isPayDeliver = v;
          //         //       // if(onChanged != null){
          //         //       //   onChanged(expensePerson);
          //         //       // }
          //         //     },
          //         //   ),
          //         //   SizedBox(
          //         //     width: 6,
          //         //   ),
          //         //   Text(
          //         //     MyLanguage.dictionary["pay_shipping"],
          //         //     style: GoogleFonts.mitr(fontSize: 18),
          //         //     textAlign: TextAlign.center,
          //         //   )
          //         // ]),
          //         // SizedBox(
          //         //   height: 4,
          //         // ),
          //         // Visibility(
          //         //   // visible: expensePerson.isPayDeliver ,
          //         //   child: Row(children: [
          //         //     SizedBox(
          //         //       width: 8,
          //         //     ),
          //         //     Expanded(
          //         //       child: TextField(
          //         //           // controller: expensePerson.deliverPersonController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.pink()),
          //         //       ),
          //         //     ),
          //         //     SizedBox(
          //         //       width: 8,
          //         //     ),
          //         //   ]),
          //         // ),
          //       ],
          //     )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    // MyCheckBox(
                    //   // value: expensePerson.isGetDiscount,
                    //   color: Colors.orange[400],
                    //   onChanged: (v){
                    //     // expensePerson.isGetDiscount = v;
                    //     // if(onChanged != null){
                    //     //   onChanged(expensePerson);
                    //     // }
                    //   },
                    // ),
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
                            borderSide: BorderSide(color: Colors.grey, width: 2.0),
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
                            borderSide: BorderSide(color: Colors.grey, width: 2.0),
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
    );
  }
}
