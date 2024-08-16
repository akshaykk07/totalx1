import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:totalx1/controllors/add_controllor.dart';
import 'package:totalx1/models/userModel.dart';

import '../controllors/basic_controllors.dart';
import 'widgets/constants/colors.dart';
import 'widgets/apptext.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_textfield.dart';
import 'widgets/user_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final basicControllors =
        Provider.of<BasicControllors>(context, listen: false);
    log('message');
    return Scaffold(
      backgroundColor: whiteone,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextfield1(
                        size: size,
                        hint: 'Search By Name',
                        controller: basicControllors.searchControllor,
                        onchange: (val) {
                          Provider.of<BasicControllors>(context, listen: false)
                              .cahngeValue(val.toLowerCase());
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          addFilter(context, size);
                        },
                        child: Image.asset('assets/filter.png'))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                  name: 'Users List',
                  size: 14,
                  fontWeight: FontWeight.w600,
                  colors: customBalck,
                ),
                Expanded(
                  child: Consumer<BasicControllors>(
                      builder: (context, data, child) {
                    Query userQuery =
                        FirebaseFirestore.instance.collection('User');

                    if (basicControllors.selectedOption == 'Younger') {
                      userQuery =
                          userQuery.where('age', isLessThanOrEqualTo: 18);
                    } else if (basicControllors.selectedOption == 'Elder') {
                      userQuery = userQuery.where('age', isGreaterThan: 18);
                    }
                    return StreamBuilder(
                        stream: userQuery.snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: blue,
                            ));
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          final data = snapshot.data!.docs;

                          final filteredDocs = data.where((doc) {
                            final name = doc['name'].toString().toLowerCase();
                            return name.contains(basicControllors.searchQuery);
                          }).toList();
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final user = filteredDocs[index];
                              return UserTile(
                                name: user['name'],
                                age: user['age'].toString(),
                                imgurl: user['img'],
                              );
                            },
                            itemCount: filteredDocs.length,
                          );
                        });
                  }),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser(context, size, formkey);
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

  addUser(BuildContext context, Size size, formkey) {
    // add new user dialog.....
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final basicControllors =
            Provider.of<BasicControllors>(context, listen: false);
        return Dialog(
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
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
                    // Using Consumer to only rebuild this part when pickedImage changes
                    InkWell(
                      onTap: () {
                        Provider.of<BasicControllors>(context, listen: false)
                            .pickImage();
                      },
                      child: Consumer<BasicControllors>(
                        builder: (context, basicprovider, child) {
                          return basicprovider.pickedImage != null
                              ? Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: FileImage(
                                        File(basicprovider.pickedImage!.path)),
                                  ),
                                )
                              : Align(
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/img.png'),
                                );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                      controller: basicControllors.nameControllor,
                      type: false,
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter name';
                        }
                        return null;
                      },
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
                      controller: basicControllors.ageControllor,
                      type: false,
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Enter age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton1(
                          size: size,
                          title: 'Cancel',
                          onTap: () {
                            basicControllors.nameControllor.clear();
                            basicControllors.ageControllor.clear();
                            basicControllors.pickedImage = null;
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
                            if (formkey.currentState!.validate()) {
                              if (basicControllors.pickedImage == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Pick Image",
                                    style: TextStyle(color: whiteone),
                                  ),
                                  backgroundColor: customBalck,
                                  behavior: SnackBarBehavior.floating,
                                ));
                              } else {
                                Provider.of<AddUserControllor>(context,
                                        listen: false)
                                    .addnewUser(UserModel(
                                        name: basicControllors
                                            .nameControllor.text,
                                        age: int.parse(basicControllors
                                            .ageControllor.text),
                                        file: basicControllors.file,
                                        img: basicControllors.pickedImage));
                                basicControllors.nameControllor.clear();
                                basicControllors.ageControllor.clear();
                                basicControllors.pickedImage = null;
                                Navigator.pop(context);
                              }
                            }
                          },
                          type: true,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  addFilter(BuildContext context, Size size) {
    // Filter  dailog...
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Provider.of<BasicControllors>(context, listen: false);
        return Dialog(
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Consumer<BasicControllors>(builder: (context, child, value) {
              return Column(
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
                      Consumer<BasicControllors>(
                          builder: (context, data, child) {
                        return Radio(
                          fillColor: const WidgetStatePropertyAll(blue),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: "All",
                          groupValue: data.selectedOption,
                          onChanged: (String? value) {
                            data.selectedOptions(value);
                            Navigator.pop(context);
                          },
                        );
                      }),
                      const AppText(
                        name: 'All',
                        size: 12,
                        fontWeight: FontWeight.w500,
                        colors: customBalck,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Consumer<BasicControllors>(
                          builder: (context, data, child) {
                        return Radio(
                          fillColor: const WidgetStatePropertyAll(blue),
                          value: "Elder",
                          groupValue: data.selectedOption,
                          onChanged: (String? value) {
                            data.selectedOptions(value);
                            Navigator.pop(context);
                          },
                        );
                      }),
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
                      Consumer<BasicControllors>(
                          builder: (context, data, child) {
                        return Radio(
                          fillColor: const WidgetStatePropertyAll(blue),
                          value: "Younger",
                          groupValue: data.selectedOption,
                          onChanged: (String? value) {
                            data.selectedOptions(value);
                            Navigator.pop(context);
                          },
                        );
                      }),
                      const AppText(
                        name: 'Age: Younger',
                        size: 12,
                        fontWeight: FontWeight.w500,
                        colors: customBalck,
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
