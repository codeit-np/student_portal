import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  late YoutubePlayerController playerController;

  var currentVideoId = "".obs;

  void initPlayer(String videoId) {
    currentVideoId.value = videoId;

    playerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true
      ),
    );
  }

  void loadVideo(String videoId) {
    currentVideoId.value = videoId;
    playerController.load(videoId);
  }

  @override
  void onClose() {
    playerController.dispose();
    super.onClose();
  }
}