import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/controller/test_controller.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(TestController());
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<TestController>(
          init: TestController(),
          builder: (controller) => Column(
            children: [
              Text(
                controller.isExpanded
                    ? controller.testString
                    : controller.testString.substring(0, 12) + '...',
              ),
              TextButton(
                onPressed: () {
                  controller.changingState();
                },
                child: const Text('show more...'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
