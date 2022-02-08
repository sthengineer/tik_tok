import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/widgets/bottom_bar.dart';
import '../../controller/feed_controller.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final feedController = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      init: FeedController(),
      builder: (feedController) =>Scaffold(
      backgroundColor:
          feedController.actualScreen == 0 ? Colors.black : Colors.white,
      body:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: feedController.currentScreen),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}
