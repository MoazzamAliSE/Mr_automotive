import 'package:auto_motive/Data/shared%20pref/shared_pref.dart';

class UserModel {
  final String? name;
  final String? phoneNumber;
  final String? token;
  final String? email;
  final String? profilePicture;
  final double? longitude;
  final double? latitude;
  final List<dynamic> myServices;
  final List<dynamic> mySpareParts;

  UserModel({required this.name,
    required this.profilePicture,
    required this.latitude,
    required this.myServices,
    required this.mySpareParts,
    required this.longitude,
    required this.token,
    required this.email,
    required this.phoneNumber,
  });

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? token,
    String? email,
    String? profilePicture,
    double? longitude,
    double? latitude,
    List<dynamic>? myServices,
    List<dynamic>? mySpareParts
  }) {
    final UserModel userModel=UserModel(name: name ?? this.name,
        profilePicture: profilePicture?? this.profilePicture,
        latitude: latitude?? this.latitude,
        myServices: myServices??this.myServices,
        mySpareParts: mySpareParts?? this.mySpareParts,
        longitude: longitude?? this.longitude,
        token: token?? this.token,
        email: email?? this.email,
        phoneNumber: phoneNumber??this.phoneNumber);
    UserPref.setUser(user: userModel);
    return userModel;
  }
}
