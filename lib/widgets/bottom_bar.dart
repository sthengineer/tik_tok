import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/controller/feed_controller.dart';
import 'package:tik_tok/utils/tik_tok_icons_icons.dart';

class BottomBar extends StatelessWidget {
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 38.0;

  BottomBar({Key? key}) : super(key: key);
  var controller = Get.put(FeedController());

  Widget get customCreateIcon => Container(
        width: 45.0,
        height: 27.0,
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10.0),
                width: CreateButtonWidth,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 45, 108),
                    borderRadius: BorderRadius.circular(7.0))),
            Container(
                margin: const EdgeInsets.only(right: 10.0),
                width: CreateButtonWidth,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 32, 211, 234),
                    borderRadius: BorderRadius.circular(7.0))),
            Center(
              child: GetBuilder<FeedController>(
                init: FeedController(),
                builder: (controller) => Container(
                  height: double.infinity,
                  width: CreateButtonWidth,
                  decoration: BoxDecoration(
                      color: controller.actualScreen == 0
                          ? Colors.white
                          : Colors.black,
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Icon(
                    Icons.add,
                    color: controller.actualScreen == 0
                        ? Colors.black
                        : Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black12))),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              menuButton('Home', TikTokIcons.home, 0),
              menuButton('Search', TikTokIcons.search, 1),
              const SizedBox(width: 15),
              customCreateIcon,
              const SizedBox(width: 15),
              menuButton('Messages', TikTokIcons.messages, 2),
              menuButton('Profile', TikTokIcons.profile, 3)
            ],
          ),
          SizedBox(height: Platform.isIOS ? 40 : 10)
        ],
      ),
    );
  }

  Widget menuButton(String text, IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        controller.setActualScreen(index);
      },
      child: SizedBox(
        height: 45,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GetBuilder<FeedController>(
              init: FeedController(),
              builder: (controller) => Icon(icon,
                  color: controller.actualScreen == 0
                      ? controller.actualScreen == index
                          ? Colors.white
                          : Colors.white70
                      : controller.actualScreen == index
                          ? Colors.black
                          : Colors.black54,
                  size: NavigationIconSize),
            ),
            const SizedBox(height: 7),
            GetBuilder<FeedController>(
              init: FeedController(),
              builder: (controller) => Text(
                text,
                style: TextStyle(
                  fontWeight: controller.actualScreen == index
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: controller.actualScreen == 0
                      ? controller.actualScreen == index
                          ? Colors.white
                          : Colors.white70
                      : controller.actualScreen == index
                          ? Colors.black
                          : Colors.black54,
                  fontSize: 11.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
