import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';


import '../widgets/constants/colors.dart';
import '../widgets/apptext.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/user_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final searchControllor = TextEditingController();

  final nameControllor = TextEditingController();

  final ageControllor = TextEditingController();
  bool add = false;
  String selectedOption = "All";

  @override
  Widget build(BuildContext context) {
    log('message');
    final size = MediaQuery.of(context).size;
   // final basicprovider = Provider.of<BasicControllors>(context);
    return Scaffold(
      backgroundColor: whiteone,
      appBar: AppBar(
        backgroundColor: customBalck,
        title: const Row(
          children: [
            Icon(
              Icons.location_on,
              color: white,
              size: 15,
            ),
            AppText(
              name: 'Nilambur',
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield1(
                          size: size,
                          hint: 'Search By Name',
                          controller: searchControllor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          addFilter(context, size, selectedOption);
                        },
                        child: Image.asset('assets/filter.png'))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                  name: 'users Lists',
                  size: 14,
                  fontWeight: FontWeight.w600,
                  colors: customBalck,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return const UserTile(
                        name: 'Devika',
                        age: '22',
                        imgurl:
                            'https://images.pexels.com/photos/1036623/pexels-photo-1036623.jpeg?cs=srgb&dl=pexels-moose-photos-170195-1036623.jpg&fm=jpg',
                      );
                    },
                    itemCount: 5,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser(context, size); /////////////////
        },
        backgroundColor: customBalck,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }

  addUser(BuildContext context, size) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
      //  final basicprovider = Provider.of<BasicControllors>(context);
        return Dialog(
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    name: 'Add A New User',
                    size: 13,
                    fontWeight: FontWeight.w600,
                    colors: customBalck,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // InkWell(
                  //   onTap: () {
                  //  //   basicprovider.pickImage();
                  //   },
                  //   child: basicprovider.pickedImage != null
                  //       ? Align(
                  //           alignment: Alignment.center,
                  //           child: CircleAvatar(
                  //               radius: 40,
                  //               backgroundImage: FileImage(
                  //                   File(basicprovider.pickedImage!.path))),
                  //         )
                  //       : Align(
                  //           alignment: Alignment.center,
                  //           child: Image.asset('assets/img.png')),
                  // ),
                  const AppText(
                    name: 'Name',
                    size: 12,
                    fontWeight: FontWeight.w400,
                    colors: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    size: size,
                    hint: '',
                    controller: nameControllor,
                    type: false,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AppText(
                    name: 'Age',
                    size: 12,
                    fontWeight: FontWeight.w400,
                    colors: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    size: size,
                    hint: '',
                    controller: ageControllor,

                    // Use the correct controller for Age
                    type: false,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton1(
                        size: size,
                        title: 'Cancel',
                        onTap: () {
                          Navigator.of(context).pop(); // Dismiss the dialog
                        },
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      CustomButton1(
                        size: size,
                        title: 'Save',
                        onTap: () {
                          // Implement save functionality here
                        },
                        type: true,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  addFilter(BuildContext context, size, selectedOption) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    name: '   Sort',
                    size: 13,
                    fontWeight: FontWeight.w600,
                    colors: customBalck,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        fillColor: const WidgetStatePropertyAll(blue),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: "All",
                        groupValue: selectedOption,
                        onChanged: (String? value) {
                          selectedOption =
                              value!; //////////////////////////////////
                        },
                      ),
                      const AppText(
                        name: ' All',
                        size: 12,
                        fontWeight: FontWeight.w500,
                        colors: customBalck,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        fillColor: const WidgetStatePropertyAll(blue),
                        value: "Elder",
                        groupValue: selectedOption,
                        onChanged: (String? value) {
                          selectedOption =
                              value!; /////////////////////////////////
                        },
                      ),
                      const AppText(
                        name: 'Age: Elder',
                        size: 12,
                        fontWeight: FontWeight.w500,
                        colors: customBalck,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        fillColor: const WidgetStatePropertyAll(blue),
                        value: "Younger",
                        groupValue: selectedOption,
                        onChanged: (String? value) {
                          selectedOption =
                              value!; ////////////////////////////////
                        },
                      ),
                      const AppText(
                        name: 'Age: Younger',
                        size: 12,
                        fontWeight: FontWeight.w500,
                        colors: customBalck,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
