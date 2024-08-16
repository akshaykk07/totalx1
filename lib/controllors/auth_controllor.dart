import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx1/controllors/basic_controllors.dart';

import '../views/home_screen.dart';
import '../views/login_screen.dart';
import '../views/otp_screen.dart';
import '../views/widgets/constants/colors.dart';

class AuthControllor {
  // phone number verifiaction function using fire base auth...........
  phoneAuth(BuildContext context, mobielControllor) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        timeout: const Duration(seconds: 60),
        phoneNumber: '+91 $mobielControllor',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Invalid Otp",
                style: TextStyle(color: whiteone),
              ),
              backgroundColor: customBalck,
              behavior: SnackBarBehavior.floating,
            ));
            Provider.of<BasicControllors>(context, listen: false).loadingOff();
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          LoginScreen.verify = verificationId;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(phone: mobielControllor),
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
   
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Try Later',
          style: TextStyle(color: whiteone),
        ),
        backgroundColor: customBalck,
        behavior: SnackBarBehavior.floating,
      ));
      // ignore: use_build_context_synchronously
      Provider.of<BasicControllors>(context, listen: false).loadingOff();
    }
  }

//checking otp validation............
  otpValidation(code, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: LoginScreen.verify, smsCode: code);
      var data = await FirebaseAuth.instance.signInWithCredential(credential);
      OtpScreen.user = data;

      Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "Invalid Otp",
          style: TextStyle(color: whiteone),
        ),
        backgroundColor: customBalck,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
