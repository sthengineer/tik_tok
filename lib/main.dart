import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tik_tok/screens/feed_screen.dart';

import 'controller/feed_controller.dart';


Future<void> main() async {
  final locator = GetIt.instance;
  locator.registerSingleton<FeedController>(FeedController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeedScreen(),
  ));
}
