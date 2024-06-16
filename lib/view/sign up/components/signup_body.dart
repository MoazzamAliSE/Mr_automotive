import 'package:auto_motive/view/sign%20in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view model/controller/signup_controller.dart';
import 'button.dart';
import 'input_form.dart';
import 'signup_bar.dart';

class SignupBody extends StatelessWidget {
  SignupBody({super.key});

  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const SignUpBar(),
            const SizedBox(
              height: 10,
            ),
            InputForm(),
            Obx(
              () => AccountButton(
                text: "Create Account",
                loading: controller.loading.value,
                onTap: () {
                  controller.createAccount();
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    controller.name.value.clear();
                    controller.password.value.clear();
                    controller.email.value.clear();
                    Get.off(() => const SignIn());
                  },
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.white,
                        ))
                  ])),
                ))
          ],
        ),
      ),
    );
  }
}
