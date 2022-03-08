import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  String testString =
      'we have something for test, we have something for test, we have something for test, we have something for test';
  bool isExpanded = false;
  void changingState() {
    isExpanded = !isExpanded;
    update();
  }
}
