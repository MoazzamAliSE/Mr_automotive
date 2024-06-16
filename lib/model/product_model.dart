import 'package:auto_motive/model/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.title,
    required this.number,
    required this.description,
    required this.price,
    required this.location,
    required this.delivery,
    required this.warranty,
    required this.owner,
    required this.images,
    required this.timeStamp,
    required this.longitude,
    required this.latitude,
    required this.ratings,
    required this.reviews
  });

  final String id;
  final String name;
  final String number;
  final String title;
  final String location;
  final String warranty;
  final List<dynamic> ratings;
  final List<dynamic> reviews;
  final String delivery;
  final String price;
  final String timeStamp;
  final String description;
  final Owner owner;
  final double latitude;
  final double longitude;
  final List<dynamic> images;

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ProductModel(
      reviews: data['reviews'],
      id: data['id'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      timeStamp: data['timeStamp'],
      ratings: data['ratings'],
      name: data['name'],
      warranty: data['warranty'],
      delivery: data['delivery'],
      location: data['location'],
      number: data['number'],
      title: data['title'],
      price: data['price'],
      description: data['description'],
      owner: Owner(
        latitude: data['owner']['latitude'],
        longitude: data['owner']['longitude'],
        name: data['owner']['name'],
        contact: data['owner']['contact'],
        id: data['owner']['id'],
        date: data['owner']['date'],
        profilePicture: data['owner']['profilePicture'],
      ),
      images: List<String>.from(data['images']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ratings' : ratings,
      'title': title,
      'number': number,
      'description': description,
      'price': price,
      'reviews' : reviews,
      'location': location,
      'warranty': warranty,
      'delivery': delivery,
      'owner': owner.toMap(),
      'images': images,
      'timeStamp': timeStamp,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      reviews: map['reviews'],
      ratings: map['ratings'],
      title: map['title'],
      number: map['number'],
      description: map['description'],
      price: map['price'],
      location: map['location'],
      delivery: map['delivery'],
      warranty: map['warranty'],
      owner: Owner.fromMap(map['owner']),
      images: List<String>.from(map['images']),
      timeStamp: map['timeStamp'],
      longitude: map['longitude'],
      latitude: map['latitude'],
    );
  }
}



