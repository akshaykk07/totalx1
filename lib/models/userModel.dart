import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UserModel {
  String? name;
  int? age;
  File? img;
  XFile? file;
  UserModel({this.img, this.name, this.age,this.file});
}
