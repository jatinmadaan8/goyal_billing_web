import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gs_web/widgets/itemHeader.dart';
import 'package:gs_web/widgets/total.dart';

// import 'expense_item_header_widget.dart';
// import 'expense_item_total_widget.dart';
// import 'expense_item_widget.dart';
// import 'expense_person.dart';
// import 'my_text_field.dart';
import 'mycard.dart';

int index = 0;

class FormWidget extends StatefulWidget {
  // name = TextEditingController();
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  
  int _count = 1;

  

  @override
  Widget build(BuildContext context) {
    List<Widget> _items =
        new List.generate(_count, (int i) => new AddNewItem());
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
            Expanded(child: TextField(
              // controller: name, 
              textAlign: TextAlign.center,
              // hintText: ".."
              style: TextStyle(
                fontSize: 22,  )
              ),
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
            child: ListView(
              children: _items,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _addNewItemRow();
              });
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
              decoration: BoxDecoration(color: Colors.green[300], borderRadius: BorderRadius.circular(12)),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ExpenseItemTotalWidget(),
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
  void _addNewItemRow() {
    setState(() {
      _count = _count + 1;
    });
  }
}

class AddNewItem extends StatefulWidget {
  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  bool enableRemove = true;
  @override
  Widget build(BuildContext context) {
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
                        child: TextField(
                          // controller: expenseItemController.nameController, fontSize: 22,  hintText: ".."
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            hintText: "Enter Item Name",
                          ),
                          )
                        ),
                      SizedBox(
                        width: 16,
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: TextField(
                          // controller: expenseItemController.priceController,
                          // fontSize: 22,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.numberWithOptions(
                            signed: false,
                            decimal: true,
                          ),
                          decoration: new InputDecoration(
                            hintText: "Enter Price",
                          ),
                          // hintText: "0",
                          // onChanged: (text) {
                          //   double price = double.tryParse(text) ?? 0;
                          //   if (onPriceChanged != null) {
                          //     onPriceChanged(expenseItemController, price);
                          //   }
                          // }
                          )),
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
                      // onTap: () {
                      //   expenseItemController.decreaseAmount();
                      //   if (onAmountChanged != null) {
                      //     onAmountChanged(expenseItemController, expenseItemController.expenseItem.amount);
                      //   }
                      // },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 32,
                        ),
                        decoration: BoxDecoration(color: Colors.orange[300], borderRadius: BorderRadius.circular(6)),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                        child: TextField(
                            // controller: expenseItemController.amountController,
                            textAlign: TextAlign.center,
                            decoration: new InputDecoration(
                            hintText: "0",
                          ),
                            //  
                            // onChanged: (text) {
                            //   int amount = double.tryParse(text) ?? 0;
                            //   if (onAmountChanged != null) {
                            //     onAmountChanged(expenseItemController, amount);
                            //   }
                            // }
                            )),
                    SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      // onTap: () {
                      //   expenseItemController.increaseAmount();
                      //   if (onAmountChanged != null) {
                      //     onAmountChanged(expenseItemController, expenseItemController.expenseItem.amount);
                      //   }
                      // },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 32,
                        ),
                        decoration: BoxDecoration(color: Colors.blue[300], borderRadius: BorderRadius.circular(6)),
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
                      Expanded(
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: new InputDecoration(
                            hintText: "0",
                          ),
                              // controller: expenseItemController.sumController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.primary()
                          ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  )),
              if (enableRemove)
                GestureDetector(
                  // onTap: onRemoveItem,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                    decoration: BoxDecoration(color: Colors.red[300], borderRadius: BorderRadius.circular(6)),
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
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(6)),
                )
            ],
          ),
        ],
      ),
    );
  }
}
