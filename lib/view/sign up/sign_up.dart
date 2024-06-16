import 'package:flutter/material.dart';
import 'components/signup_body.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor: darkBackgroundColor,
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black54,
                ])
        ),
        child: SafeArea(
          child: SignupBody(),
        ),
      ),
    );
  }
}
