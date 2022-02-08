import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tik_tok/controller/feed_controller.dart';
import 'package:tik_tok/screens/feed_screen/widgets/video_card_widget.dart';

class FeedVideoWidget extends StatelessWidget {
  const FeedVideoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var feedController = Get.put(FeedController());
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: feedController.listVideos.length,
          onPageChanged: (index) {
            index = index % (feedController.listVideos.length);
            feedController.changeVideo(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % (feedController.listVideos.length);
            return VideoCardWidget(video: feedController.listVideos[index]);
          },
        ),
        SafeArea(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('Following',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70)),
                const SizedBox(
                  width: 7,
                ),
                Container(
                  color: Colors.white70,
                  height: 10,
                  width: 1.0,
                ),
                const SizedBox(
                  width: 7,
                ),
                const Text(
                  'For You',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
