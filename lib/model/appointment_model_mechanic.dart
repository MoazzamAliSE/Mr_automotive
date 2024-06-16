import 'dart:math';

import 'package:auto_motive/model/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModelMechanic {
  final String date;
  final Owner mechanic;
  final ServiceModel service;
  final String id;
  final String time;

  AppointmentModelMechanic(
      {required this.id,
        required this.date,
        required this.time,
        required this.service,
        required this.mechanic});

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'id': id,
      'mechanic': mechanic.toMap(),
      'date': date,
      'service': service.toMap()
    };
  }


  factory AppointmentModelMechanic.fromMap(Map<String, dynamic> map) {
    return AppointmentModelMechanic(
        id: map['id'] ?? Random().nextInt(10000000).toString(),
        service: ServiceModel.fromMap(map['service']),
        date: map['date'],
        time: map['time'],
        mechanic: Owner.fromMap(map['mechanic']));
  }

  factory AppointmentModelMechanic.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return AppointmentModelMechanic(
        id: data['id'],
        date: data['date'],
        time: data['time'],
        service: ServiceModel.fromMap(data['service']),
        mechanic: Owner.fromMap(data['mechanic']));
  }
}