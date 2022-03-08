import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tik_tok/screens/feed_screen/feed_screen.dart';
import 'package:tik_tok/screens/test.dart';

import 'controller/feed_controller.dart';

Future<void> main() async {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Test(),
    ),
  );
}
