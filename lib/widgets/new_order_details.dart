import 'package:flutter/material.dart';
import 'package:gs_web/widgets/order_data.dart';
import 'package:gs_web/widgets/order_itemdata.dart';

class NewOrderDetails extends StatefulWidget {
  final OrderData orders;

  NewOrderDetails({
    this.orders,
  });

  @override
  _NewOrderDetailsState createState() => _NewOrderDetailsState();
}

class _NewOrderDetailsState extends State<NewOrderDetails> {
  List<OrderItemData> _items = [];

  Widget bodyData() => Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      child: DataTable(
          onSelectAll: (b) {},
          sortColumnIndex: 0,
          sortAscending: false,
          //dataRowHeight: 60,
          //columnSpacing: 20,
          columns: <DataColumn>[
            DataColumn(
              label: Text("Items",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              //numeric: false,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  _items.sort((a, b) => a.itemName.compareTo(b.itemName));
                });
              },
              tooltip: "To display list of items",
            ),
            DataColumn(
              label: Text("Quantity",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              numeric: true,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  _items.sort((a, b) => a.quantity.compareTo(b.quantity));
                });
              },
              tooltip: "To display quantity of each items",
            ),
            DataColumn(
              label: Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              numeric: true,
              onSort: (i, b) {
                print("$i $b");
                setState(() {
                  _items.sort((a, b) =>
                      a.itemPrice *
                      a.quantity.compareTo(b.itemPrice * b.quantity));
                });
              },
              tooltip: "To display total price",
            ),
          ],
          rows: _items
              .map(
                (item) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        item.itemName ?? 'aaabbcc',
                        overflow: TextOverflow.ellipsis,
                      ),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text(item.quantity.toString() ?? 'vfodjv'),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text((item.quantity * double.parse(item.itemPrice))
                              .toString() ??
                          'vkje'),
                      showEditIcon: false,
                      placeholder: false,
                    )
                  ],
                ),
              )
              .toList()),
    ),
  );

  Widget _billCard() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Invoice",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color:  Colors.deepOrange,),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Divider(
              height: 0.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(10), child: Text("Total items: ")),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(_items.length.toString() ?? 'jbcd'))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(10), child: Text("Total amount: ")),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.orders.totalPrice.toString()))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(10), child: Text("Tax(in %): ")),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(widget.orders.mode.toString()))
            ],
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Divider(
              height: 0.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(10), child: Text("Final amount: ")),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text("${widget.orders.totalPrice.toString()}"))
            ],
          ),
        ],
      )),
    );
  }

  Widget customerDetails() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Customer Details",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.deepOrange,),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Divider(
              height: 0.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(
                      left: 5.0, right: 0.0, top: 5.0, bottom: 5.0),
                  child: Text(
                    "Customer Name: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Container(
                  padding: EdgeInsets.only(
                      left: 0.0, right: 5.0, top: 5.0, bottom: 5.0),
                  child: Text(
                    widget.orders.name.toString() ?? 'jbcd',
                  ))
            ],
          ),
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.orders.items.forEach((item) {
      _items.add(OrderItemData(
          itemPrice: item['itemPrice'],
          itemName: item['itemName'],
          quantity: item['quantity']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.orders.name ?? 'anc'),
          centerTitle: true,
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Items List",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepOrange,),
              ),
            ),
            bodyData(),
            _billCard(),
            customerDetails()
          ],
        ));
  }
}
