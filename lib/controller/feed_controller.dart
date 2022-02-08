import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tik_tok/data/demo_data.dart';
import 'package:tik_tok/data/video.dart';
import 'package:video_player/video_player.dart';

class FeedController extends GetxController {
  VideoPlayerController? controller;
  List<Video> listVideos = <Video>[];

  int prevVideo = 0;

  int actualScreen = 0;

  @override
  void onInit() {
    load();
    loadVideo(0);
    loadVideo(1);
    super.onInit();
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

  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    update();
  }
}
