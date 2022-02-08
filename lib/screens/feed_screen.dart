import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tik_tok/data/video.dart';
import 'package:tik_tok/screens/messages_screen.dart';
import 'package:tik_tok/screens/profile_screen.dart';
import 'package:tik_tok/screens/search_screen.dart';
import 'package:tik_tok/widgets/actions_toolbar.dart';
import 'package:tik_tok/widgets/bottom_bar.dart';
import 'package:tik_tok/widgets/video_description.dart';
import 'package:video_player/video_player.dart';

import '../controller/feed_controller.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final locator = GetIt.instance;
  final feedController = Get.put(FeedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GetIt.instance<FeedController>().actualScreen == 0
          ? Colors.black
          : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: currentScreen()),
          const BottomBar(),
        ],
      ),
    );
  }

  Widget feedVideos() {
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
            return videoCard(feedController.listVideos[index]);
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

  Widget currentScreen() {
    switch (feedController.actualScreen) {
      case 0:
        return feedVideos();
      case 1:
        return SearchScreen();
      case 2:
        return MessagesScreen();
      case 3:
        return ProfileScreen();
      default:
        return feedVideos();
    }
  }

  Widget videoCard(Video video) {
    return Stack(
      children: [
        video.controller != null
            ? GestureDetector(
                onTap: () {
                  if (video.controller!.value.isPlaying) {
                    video.controller?.pause();
                  } else {
                    video.controller?.play();
                  }
                },
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: video.controller?.value.size.width ?? 0,
                      height: video.controller?.value.size.height ?? 0,
                      child: VideoPlayer(video.controller!),
                    ),
                  ),
                ),
              )
            : Container(
                color: Colors.black,
                child: const Center(
                  child: Text("Loading"),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                VideoDescription(video.user, video.videoTitle, video.songName),
                ActionsToolbar(video.likes, video.comments,
                    "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    feedController.controller?.dispose();
    super.dispose();
  }
}
