import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gs_web/dashboard.dart';
import 'package:gs_web/widgets/order_itemdata.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class OrdersPdf extends StatefulWidget {
  final dynamic orders;

  // ignore: sort_constructors_first
  const OrdersPdf({
    this.orders,
  });

  @override
  _OrdersPdfState createState() => _OrdersPdfState();
}

class _OrdersPdfState extends State<OrdersPdf> {
  // ignore: always_specify_types
  final List<OrderItemData> _items = [];

  // ignore: always_specify_types
  List<List<String>> billTableItems = [];

  dynamic totalCost = 0;
  dynamic finalAmount = 0;
  final pw.Document pdf = pw.Document();

  pw.PageTheme _buildTheme(PdfPageFormat pageFormat) {
    return pw.PageTheme(
      pageFormat: pageFormat,
    );
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Header(
        level: 0,
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Text('Goyal Sales | Invoice', textScaleFactor: 2),
            ]));
  }

  dynamic writeOnPdf() {
    pdf.addPage(pw.MultiPage(
        pageTheme: _buildTheme(
          PdfPageFormat.a4,
        ),
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: (pw.Context context) {
          return _buildHeader(context);
        },
        build: (pw.Context context) => <pw.Widget>[
              pw.Text(
                  'This is an automatically generated invoice for your order',
                  textAlign: pw.TextAlign.center),
              pw.Padding(padding: const pw.EdgeInsets.all(10)),
              pw.Container(
                padding: const pw.EdgeInsets.only(left: 5.0, right: 5.0),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: <pw.Widget>[
                    // pw.Header(level: 2, text: 'Buyer Details :'),
                    pw.Paragraph(text: 'Name :$name'),
                    // pw.Paragraph(text: 'Phone :${widget.orders.phoneNo}'),
                    //pw.Paragraph(text: 'GSTIN: 1223456TYHG789'),
                    // pw.Paragraph(
                    //     text: 'Delivery Address:- ${widget.orders.address}'),
                    pw.Paragraph(text: 'Mode of payment:- Offline'),
                    // pw.Header(level: 2, text: 'Seller Details :'),
                    // pw.Paragraph(text: 'Shop Name:- '),
                    // pw.Paragraph(text: 'Shop Adress'),
                    // pw.Paragraph(text: 'GSTIN: 1223456TYHG789'),
                  ],
                ),
              ),
              pw.Header(level: 2, text: 'Items : '),
              pw.Padding(padding: const pw.EdgeInsets.only(top: 10.0)),
              pw.Table.fromTextArray(
                context: context,
                data: billTableItems,
              ),
              pw.Padding(padding: const pw.EdgeInsets.all(10)),
              pw.Text('Billable Amount : Rs.$finalAmount',
                  style: const pw.TextStyle(
                    fontSize: 15.0,
                  )),
            ]));
  }

  @override
  void initState() {
    super.initState();

    widget.orders.forEach((dynamic val) {
      _items.add(OrderItemData(
          itemName: val['itemName'].toString(),
          itemPrice: val['itemPrice'],
          quantity: val['quantity']));
    });
    //downloadFile();
  }

  @override
  Widget build(BuildContext context) {
    billTableItems
        .add(<String>['Item Name', 'Quantity', 'Item Price', 'Total Price']);
    // ignore: always_specify_types
    widget.orders.forEach((dynamic item) => {
          finalAmount = finalAmount +
              item['quantity'] * double.parse(item['itemPrice'].toString()),
          totalCost =
              item['quantity'] * double.parse(item['itemPrice'].toString()),
          billTableItems.add(<String>[
            item['itemName'].toString(),
            item['itemPrice'].toString(),
            item['quantity'].toString(),
            'Rs.$totalCost'
          ])
        });
    writeOnPdf();
    final Uint8List bytes = pdf.save();
    final html.Blob blob = html.Blob([bytes], 'application/pdf');

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
          child: Column(
            children: <Widget>[
              Text("Print"),
              SizedBox(height:20),
              RaisedButton(
                child: const Text("Open"),
                onPressed: () {
                  final url = html.Url.createObjectUrlFromBlob(blob);
                  html.window.open(url, "_blank");
                  html.Url.revokeObjectUrl(url);
                },
              ),
              RaisedButton(
                child: Text("Download"),
                onPressed: () {
                  final url = html.Url.createObjectUrlFromBlob(blob);
                  final anchor =
                      html.document.createElement('a') as html.AnchorElement
                        ..href = url
                        ..style.display = 'none'
                        ..download = 'some_name.pdf';
                  html.document.body.children.add(anchor);
                  anchor.click();
                  html.document.body.children.remove(anchor);
                  html.Url.revokeObjectUrl(url);
                },
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
      ),
    );
  }
}
