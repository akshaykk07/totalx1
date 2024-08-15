import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx1/controllors/basic_controllors.dart';
import '../controllors/auth_controllor.dart';
import '../widgets/constants/colors.dart';
import '../widgets/apptext.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final mobielControllor = TextEditingController();
  static String verify = '';
  static String mob = '';
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
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
                      onchange: (val) {
                        if (val.isEmpty) {
                          Provider.of<BasicControllors>(context, listen: false)
                              .checkPhonefield(false);
                        } else {
                          Provider.of<BasicControllors>(context, listen: false)
                              .checkPhonefield(true);
                        }
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter your mobile number';
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(val)) {
                          return 'Please enter a valid 10-digit mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width,
                      child: const Row(
                        children: [
                          AppText(
                            name: 'By Continuing, I agree to TotalX’s',
                            colors: customBalck,
                            fontWeight: FontWeight.w500,
                            size: 11,
                          ),
                          AppText(
                            name: 'Terms and condition',
                            colors: blue,
                            fontWeight: FontWeight.w500,
                            size: 11,
                          ),
                          AppText(
                            name: '  &',
                            colors: customBalck,
                            fontWeight: FontWeight.w500,
                            size: 11,
                          ),
                        ],
                      ),
                    ),
                    const AppText(
                      name: 'privacy policy',
                      colors: blue,
                      fontWeight: FontWeight.w500,
                      size: 11,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomButton(
                      size: size,
                      titile: 'Get Otp',
                      ontap: () {
                        if (formkey.currentState!.validate()) {
                          Provider.of<BasicControllors>(context, listen: false)
                              .loadingOn();
                          AuthControllor()
                              .phoneAuth(context, mobielControllor.text);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Consumer<BasicControllors>(builder: (context, data, child) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: Center(
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
              ),
            );
          })
        ],
      ),
    );
  }
}
