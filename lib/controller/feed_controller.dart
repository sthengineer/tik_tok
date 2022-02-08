import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tik_tok/data/demo_data.dart';
import 'package:tik_tok/data/video.dart';
import 'package:tik_tok/screens/feed_screen/widgets/feed_videos_widget.dart';
import 'package:tik_tok/screens/messages_screen.dart';
import 'package:tik_tok/screens/profile_screen.dart';
import 'package:tik_tok/screens/search_screen.dart';
import 'package:video_player/video_player.dart';

class FeedController extends GetxController {
  VideoPlayerController? controller;
  List<Video> listVideos = <Video>[];

  int prevVideo = 0;

  int actualScreen = 0;
  Widget currentScreen = FeedVideoWidget();

  @override
  void onInit() {
    load();
    loadVideo(0);
    loadVideo(1);
    super.onInit();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void load() async {
    listVideos = await getVideoList();
  }

  Future<List<Video>> getVideoList() async {
    List<Video> videoList = [];
    var videos;
    videos = data;
    for (var x in videos) {
      Video video = Video.fromJson(x);
      videoList.add(video);
    }
    return videoList;
  }

  changeVideo(index) async {
    print(listVideos.length);
    if (listVideos[index].controller == null) {
      await listVideos[index].loadController();
    }
    listVideos[index].controller!.play();
    //videoSource.listVideos[prevVideo].controller.removeListener(() {});

    if (listVideos[prevVideo].controller != null) {
      listVideos[prevVideo].controller!.pause();
    }

    prevVideo = index;
    update();

    print(index);
  }

  void loadVideo(int index) async {
    if (listVideos.length > index) {
      await listVideos[index].loadController();
      listVideos[index].controller?.play();
      update();
    }
  }

  void changeCurrentScreen() {
    switch (actualScreen) {
      case 0:
        currentScreen = FeedVideoWidget();
        break;
      case 1:
        currentScreen = SearchScreen();
        break;

      case 2:
        currentScreen = MessagesScreen();
        break;

      case 3:
        currentScreen = ProfileScreen();
        break;
    }
    update();
  }

  void setActualScreen(index) {
    actualScreen = index;
    update();
    changeCurrentScreen();
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    update();
  }
}
