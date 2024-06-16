import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  ServiceModel({
    required this.id,
    required this.name,
    required this.title,
    required this.number,
    required this.description,
    required this.price,
    required this.location,
    required this.experience,
    required this.skill,
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
  final String skill;
  final List<dynamic> ratings;
  final List<dynamic> reviews;
  final String experience;
  final String price;
  final String timeStamp;
  final String description;
  final Owner owner;
  final double latitude;
  final double longitude;
  final List<dynamic> images;

  factory ServiceModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return ServiceModel(
      reviews: data['reviews'],
      id: data['id'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      timeStamp: data['timeStamp'],
      ratings: data['ratings'],
      name: data['name'],
      skill: data['skill'],
      experience: data['experience'],
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
      'experience': experience,
      'skill': skill,
      'owner': owner.toMap(),
      'images': images,
      'timeStamp': timeStamp,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'],
      name: map['name'],
      reviews: map['reviews'],
      ratings: map['ratings'],
      title: map['title'],
      number: map['number'],
      description: map['description'],
      price: map['price'],
      location: map['location'],
      experience: map['experience'],
      skill: map['skill'],
      owner: Owner.fromMap(map['owner']),
      images: List<String>.from(map['images']),
      timeStamp: map['timeStamp'],
      longitude: map['longitude'],
      latitude: map['latitude'],
    );
  }
}

class Owner {
  final String name;
  final double longitude;
  final double latitude;
  final String id;
  final String contact;
  final String date;
  final String? profilePicture;

  Owner({
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.id,
    required this.contact,
    required this.date,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'id': id,
      'contact': contact,
      'date': date,
      'profilePicture': profilePicture,
    };
  }

  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      name: map['name'],
      longitude: map['longitude'],
      latitude: map['latitude'],
      id: map['id'],
      contact: map['contact'],
      date: map['date'],
      profilePicture: map['profilePicture'],
    );
  }
}
