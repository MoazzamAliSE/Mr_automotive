import 'dart:async';

import 'package:auto_motive/res/app_color.dart';
import 'package:auto_motive/res/app_text_styles.dart';
import 'package:auto_motive/view/common%20widgets/custom_app_bar.dart';
import 'package:auto_motive/view/home_page/home_page.dart';
import 'package:auto_motive/view/sign%20up/components/button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User _user;

  late StreamSubscription<User?> _listener;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _user.sendEmailVerification();

    // Start the timer
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _checkEmailVerification();
    });

    _listener = _auth.authStateChanges().listen((User? user) {
      print("_user.emailVerified ${_user.emailVerified}");
      setState(() {
        _user = user!;
      });
      if (_user.emailVerified) {
        print("_user.emailVerified1 ${_user.emailVerified}");

        _listener.cancel();
        _timer.cancel(); // Stop the timer once email is verified
        Get.off(() => const HomePage());
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _listener.cancel();
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _resendVerificationEmail() async {
    await _user.sendEmailVerification();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Verification email resent to ${_user.email}'),
    ));
  }

  void _checkEmailVerification() async {
    await _user.reload();
    if (_user.emailVerified) {
      print("_user.emailVerifiedr  ${_user.emailVerified}");

      _listener.cancel();
      _timer.cancel();
      Get.off(() => const HomePage());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      appBar: const CustomAppBar(
        title: 'Email Verification',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('A verification email has been sent to\n ${_user.email}.',
                textAlign: TextAlign.center,
                style: AppTextStyles.white16BoldTextStyle),
            const SizedBox(height: 20.0),
            AccountButton(
                loading: false,
                onTap: _resendVerificationEmail,
                text: 'Resend Verification Email'),
          ],
        ),
      ),
    );
  }
}
