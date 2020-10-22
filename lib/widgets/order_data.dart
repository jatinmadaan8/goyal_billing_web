import 'package:cloud_firestore/cloud_firestore.dart';

class OrderData {
  final String name;
  final Timestamp timestamp;
  final String customerId;
  final String address;
  final String orderId;
  final String phoneNo;
  final dynamic totalItems;
  final dynamic totalPrice;
  final dynamic items;
  final String status;
  final String mode;

  OrderData(
      {this.name,
      this.timestamp,
      this.items,
      this.orderId,
      this.totalPrice,
      this.address,
      this.phoneNo,
      this.status,
      this.customerId,
      this.mode,
      this.totalItems});
}

class CatalogItem {
  final String itemName;
  final String itemId;
  final dynamic price;
  final dynamic discountPrice;
  final dynamic images;
  final String brand;
  final String description;
  final String manufacturer;
  final String manufacturerAddress;
  final String manufacturerContact;
  final String manufacturerEmail;
  final String countryOfOrigin;

  CatalogItem(
      {this.brand,
      this.description,
      this.discountPrice,
      this.images,
      this.itemId,
      this.itemName,
      this.manufacturer,
      this.manufacturerAddress,
      this.manufacturerContact,
      this.manufacturerEmail,
      this.price,
      this.countryOfOrigin});
}
