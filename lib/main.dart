import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tik_tok/screens/feed_screen.dart';
import 'package:tik_tok/screens/feed_viewmodel.dart';


Future<void> main() async {
  final locator = GetIt.instance;
  locator.registerSingleton<FeedViewModel>(FeedViewModel());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FeedScreen(),
  ));
}
