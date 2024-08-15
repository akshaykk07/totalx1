import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:totalx1/controllors/auth_controllor.dart';

import '../controllors/basic_controllors.dart';
import '../widgets/constants/colors.dart';
import '../widgets/apptext.dart';
import '../widgets/custom_button.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, this.phone});
  final String? phone;
  String code = '';
  static UserCredential user = '' as UserCredential;

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
    final number = int.parse(phone.toString()) % 100;
    Provider.of<BasicControllors>(context, listen: false).startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BasicControllors>(context, listen: false).loadingOff();
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                    height: 20,
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
                  AppText(
                    name:
                        'Enter the verification code we just sent to your number +91 *******$number.',
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
                  Align(
                    alignment: Alignment.center,
                    child: Consumer<BasicControllors>(
                        builder: (context, timerProvider, child) {
                      return AppText(
                        name: timerProvider.timeRemaining.toString(),
                        size: 11,
                        fontWeight: FontWeight.w600,
                        colors: Colors.red,
                      );
                    }),
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
                  CustomButton(
                    size: size,
                    titile: 'Verify',
                    ontap: () async {
                      Provider.of<BasicControllors>(context, listen: false)
                          .loadingOn();
                      AuthControllor().otpValidation(code, context);
                    },
                  )
                ],
              ),
            ),
          ),
          Consumer<BasicControllors>(builder: (context, data, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  data.isLoad
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: blue,
                        )
                      : const SizedBox()
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
