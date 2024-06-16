import 'dart:math';

import 'package:auto_motive/model/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String date;
  final ClientModel client;
  final ServiceModel service;
  final String id;
  final String time;

  AppointmentModel(
      {required this.id,
      required this.date,
      required this.time,
      required this.service,
      required this.client});

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'id': id,
      'client': client.toMap(),
      'date': date,
      'service': service.toMap()
    };
  }


  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
        id: map['id'] ?? Random().nextInt(10000000).toString(),
        service: ServiceModel.fromMap(map['service']),
        date: map['date'],
        time: map['time'],
        client: ClientModel.fromMap(map['client']));
  }

  factory AppointmentModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return AppointmentModel(
        id: data['id'],
        date: data['date'],
        time: data['time'],
        service: ServiceModel.fromMap(data['service']),
        client: ClientModel.fromMap(data['client']));
  }
}


class ClientModel {
  final String name;
  final String id;
  final String contact;
  final String email;
  final String? profilePicture;

  ClientModel({
    required this.name,
    required this.id,
    required this.contact,
    this.profilePicture,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'contact': contact,
      'email': email,
      'profilePicture': profilePicture,
    };
  }  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'],
      id: map['id'],
      contact: map['contact'],
      email: map['email'],
      profilePicture: map['profilePicture'],
    );
  }
}

