import 'package:auto_motive/view/common%20widgets/custom_app_bar.dart';
import 'package:auto_motive/view/account/components/account_card.dart';
import 'package:auto_motive/view/account/components/options_list.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // backgroundColor: darkBackgroundColor.withOpacity(.1),
      appBar: const CustomAppBar(
        title: "My Account",
      ),
      body: Container(
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              AccountCard(),
              const SizedBox(
                height: 50,
              ),
              const Expanded(child: OptionsList()),
            ]),
          ),
        ),
      ),
    );
  }
}
