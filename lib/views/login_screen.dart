
import 'package:flutter/material.dart';

import '../widgets/constants/colors.dart';
import '../widgets/apptext.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final mobielControllor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/log.png',
                    width: 150,
                  )),
              const SizedBox(
                height: 30,
              ),
              const AppText(
                name: 'Enter Phone Number',
                colors: customBalck,
                fontWeight: FontWeight.w500,
                size: 14,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextfield(
                keyboardType: TextInputType.phone,
                size: size,
                hint: 'Enter Phone No',
                controller: mobielControllor,
                validator: (val) {},
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  AppText(
                    name: 'By Continuing, I agree to TotalX’s',
                    colors: customBalck,
                    fontWeight: FontWeight.w500,
                    size: 11,
                  ),
                  AppText(
                    name: 'Terms and condition & privacy policy',
                    colors: blue,
                    fontWeight: FontWeight.w500,
                    size: 11,
                  ),
                  AppText(
                    name: ' &',
                    colors: customBalck,
                    fontWeight: FontWeight.w500,
                    size: 11,
                  ),
                ],
              ),
              const AppText(
                name: 'privacy policy',
                colors: blue,
                fontWeight: FontWeight.w500,
                size: 11,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(size: size, titile: 'Get Otp')
            ],
          ),
        ),
      ),
    );
  }
}
