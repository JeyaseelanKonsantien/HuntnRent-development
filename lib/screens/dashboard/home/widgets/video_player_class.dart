import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../resources/resources.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key, required this.video_url}) : super(key: key);
  final String video_url;
  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.video_url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    // Create a ChewieController
    _chewieController = ChewieController(
      aspectRatio: 16 / 9,
      allowFullScreen: true,
      showOptions: false,

      // controlsSafeAreaMinimum: EdgeInsets.all(16),
      progressIndicatorDelay: Duration(seconds: 1),
      materialProgressColors: ChewieProgressColors(
        playedColor: R.colors.g1,
        handleColor: R.colors.theme,
        backgroundColor: R.colors.transparent,
        bufferedColor: Colors.red.withOpacity(0.3),
      ),
      cupertinoProgressColors: ChewieProgressColors(
        playedColor: R.colors.g1,
        handleColor: R.colors.theme,
        backgroundColor: R.colors.transparent,
        bufferedColor: Colors.red.withOpacity(0.3),
      ),
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _controller.value.isInitialized
              ? Chewie(controller: _chewieController) // Use Chewie widget
              // : Container(),
              : Chewie(controller: _chewieController)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Center(
        child: FloatingActionButton(
          backgroundColor: R.colors.transparent,
          elevation: 0.00,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose(); // Dispose of the ChewieController
  }
}

// class VideoPlayerView extends StatefulWidget {
//   const VideoPlayerView({super.key});
//
//   @override
//   State<VideoPlayerView> createState() => _VideoPlayerViewState();
// }
//
// class _VideoPlayerViewState extends State<VideoPlayerView> {
//   late VideoPlayerController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _controller.value.isInitialized
//             ? AspectRatio(
//           aspectRatio: _controller.value.aspectRatio,
//           child: VideoPlayer(_controller),
//         )
//             : Container(),
//       ),
//     );
//   }
// }
