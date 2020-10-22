import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:gs_web/dashboard.dart';
import 'package:gs_web/widgets/order_data.dart';
import 'package:icon_badge/icon_badge.dart';

class SearchOrders extends StatefulWidget {
  @override
  _SearchOrdersState createState() => _SearchOrdersState();
}

class _SearchOrdersState extends State<SearchOrders> {
  final SearchBarController<CatalogItem> _searchBarController =
      SearchBarController();

  Future<List<CatalogItem>> _getAllPosts(String text) async {
    print(text.length);
    await Future.delayed(Duration(seconds: 1));
    // if (isReplay) return [OrderData("Replaying !", "Replaying body", "abcd")];
    //if (text.length == 5) throw Error();
    // if (text.length == 6) return [];
    List<CatalogItem> items = [];
    await FirebaseFirestore.instance
        .collection('catalog')
        .where('search', arrayContains: text.toLowerCase())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        items.add(CatalogItem(
            images: element.data()['images'],
            itemId: element.data()['itemId'],
            itemName: element.data()['itemName'],
            price: element.data()['price'],
            countryOfOrigin: element.data()['countryOfOrigin'],
            manufacturer: element.data()['manufacturer'],
            manufacturerAddress: element.data()['manufacturerAddress'],
            manufacturerContact: element.data()['manufacturerContact'],
            manufacturerEmail: element.data()['manufacturerEmail'],
            brand: element.data()['brand'],
            discountPrice: element.data()['discountPrice'],
            description: element.data()['description']));
      });
    });

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("billing")
                  .snapshots(),
              builder: (context, snapshot2) {
                if (snapshot2.hasData) {
                  return IconBadge(
                    icon: Icon(Icons.home),
                    itemCount: snapshot2.data.docs?.length ?? 0,
                    badgeColor: Colors.red,
                    itemColor: Colors.white,
                    maxCount: 10,
                    hideZero: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboard()));
                    },
                  );
                } else {
                  return IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard()));
                      });
                }
              }),
        ],
        title: Text("Find Products"),
      ),
      body: SafeArea(
        child: SearchBar<CatalogItem>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getAllPosts,
          searchBarController: _searchBarController,
          hintText: "Enter product name",
          cancellationWidget: Text("Cancel"),
          emptyWidget: Center(child: Text("No Order Found")),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, 0.5),
          onCancelled: () {
            print("Cancelled triggered");
          },
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
          onItemFound: (CatalogItem orders, int index) {
            return Container(
              child: Card(
                child: ListTile(
                  title: Text(orders.itemName),
                  //isThreeLine: true,
                  subtitle: Text(orders.price),
                  onTap: () async {
                    await FirebaseFirestore.instance
                        .collection("billing")
                        .doc(orders.itemId)
                        .set({
                      "itemName": orders.itemName,
                      "itemPrice": orders.discountPrice ?? orders.price,
                      "quantity": 1,
                      'cartItemId': orders.itemId,
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
