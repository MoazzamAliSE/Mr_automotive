import 'package:flutter/material.dart';

import 'components/signin_body.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ])),
        child: SafeArea(
          child: SignInBody(),
        ),
      ),
    );
  }
}
