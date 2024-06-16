import 'package:auto_motive/configs/firebase_options.dart';
import 'package:auto_motive/res/routes/app_routes.dart';
import 'package:auto_motive/view/splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'model/user_model.dart';

UserModel? localUser;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug,
  // );
  await FirebaseFirestore.instance.clearPersistence();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.routes(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
