
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';


import '../widgets/constants/colors.dart';
import '../widgets/apptext.dart';
import '../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});
  final mobielControllor = TextEditingController();

  String code = '';

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
        fontSize: 20, color: Colors.red, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: white,
      border: Border.all(color: customBalck),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              SizedBox(
                height: size.height * 0.08,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/otp.png',
                    width: 150,
                  )),
              const SizedBox(
                height: 30,
              ),
              const AppText(
                name: 'OTP verification',
                colors: customBalck,
                fontWeight: FontWeight.w500,
                size: 14,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              const AppText(
                name:
                    'Enter the verification code we just sent to your number +91 *******21.',
                colors: customBalck,
                size: 14,
                fontWeight: FontWeight.w400,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 5, right: 5),
                child: Align(
                    alignment: Alignment.center,
                    child: Pinput(
                        length: 6,
                        onChanged: (value) {
                          code = value;
                        },
                        defaultPinTheme:
                            defaultPinTheme)), // otp field.........
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Align(
                alignment: Alignment.center,
                child: AppText(
                  name: '59 Sec',
                  size: 11,
                  fontWeight: FontWeight.w600,
                  colors: Colors.red,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    name: 'Don\'t Get OTP?',
                    colors: customBalck,
                    fontWeight: FontWeight.w500,
                    size: 12,
                  ),
                  AppText(
                    name: ' Resend',
                    colors: blue,
                    fontWeight: FontWeight.w500,
                    size: 12,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomButton(size: size, titile: 'Verify')
            ],
          ),
        ),
      ),
    );
  }
}
