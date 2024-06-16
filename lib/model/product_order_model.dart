
import 'package:auto_motive/model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductOrderModel {
  final String price;
  final String quantity;
  final ProductModel product;
  final String productId;
  final String clientId;
  ProductOrderModel(
      {
    required this.price,
        required this.clientId,
        required this.product,
        required this.quantity,
        required this.productId
      });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'price': price.toString(),
      'clientId' : clientId,
      'quantity': quantity.toString(),
      'productId' : productId
    };
  }


  factory ProductOrderModel.fromMap(Map<String, dynamic> map) {
    return ProductOrderModel(
      clientId: map['clientId'],
        product: ProductModel.fromMap(map['product']),
      price: map['price'].toString(),
      productId: map['productId'],
      quantity: map['quantity'].toString()
    );
  }

  factory ProductOrderModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ProductOrderModel(
      clientId: data['clientId'],
        price: data['price'].toString(),
      product: ProductModel.fromMap(data['product']),
      productId: data['productId'].toString(),
      quantity: data['quantity'].toString()
    );
  }
}