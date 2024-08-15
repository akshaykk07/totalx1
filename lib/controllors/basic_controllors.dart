import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BasicControllors extends ChangeNotifier {
  bool isLoad = false;
  File? pickedImage;
  XFile? file;
  String searchQuery = '';
  String selectedOption = "All";
  int filter = 150;
  int timeRemaining = 60; // Initial time in seconds
  Timer? timer;
  bool state = false;
  final searchControllor = TextEditingController(); //search controllor..
  final nameControllor = TextEditingController(); // name controllor
  final ageControllor = TextEditingController(); // age controllor

  loadingOn() {
    isLoad = true;
    notifyListeners();
  }

  loadingOff() {
    isLoad = false;
    notifyListeners();
  }

//pickImage function is used to pick the image ........
  Future<void> pickImage() async {
    file = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (file != null) {
      pickedImage = File(file!.path);
    }
    notifyListeners();
  }

//changeValue function is used to pick the search value........
  cahngeValue(value) {
    searchQuery = value;
    notifyListeners();
  }

  //selectedOption function is used to pick the radio button value........
  selectedOptions(value) {
    selectedOption = value;
    notifyListeners();
  }

//Start timer.........
  void startTimer() {
    timeRemaining = 60;
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        timeRemaining--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  checkPhonefield(value) {
    state = value;
    notifyListeners();
  }
}
