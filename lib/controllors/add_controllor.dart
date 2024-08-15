import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/userModel.dart';
import 'basic_controllors.dart';


class AddUserControllor extends ChangeNotifier {
  BasicControllors basicControllors = BasicControllors();
  addnewUser(UserModel user) async {
    basicControllors.isLoad = true;
    try {
      Reference reference =
          FirebaseStorage.instance.ref().child('images/${user.file!.name}');
      await reference.putFile(File(user.img!.path));
      final imageurl = await reference.getDownloadURL();
      FirebaseFirestore.instance
          .collection('User')
          .add({'name': user.name, 'age': user.age, 'img': imageurl});
    } catch (e) {
      log('$e');
    }
    basicControllors.isLoad = false;
  }
}
