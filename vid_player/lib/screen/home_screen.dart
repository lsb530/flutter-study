import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;
  VideoPlayerController? videoPlayerController;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video != null && videoPlayerController != null
          ? _VideoPlayer(
              video: video!,
              videoPlayerController: videoPlayerController!,
              onAnotherVideoPicked: onAnotherVideoPicked,
              onInitController: initController,
            )
          : isLoading
          ? Center(child: CircularProgressIndicator())
          : _VideoSelector(onLogoTap: onLogoTap),
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }

  onAnotherVideoPicked() async {
    if (videoPlayerController != null &&
        videoPlayerController!.value.isPlaying) {
      await videoPlayerController!.pause();
    }

    videoPlayerController?.dispose();
    videoPlayerController = null;

    onLogoTap();
  }

  onLogoTap() async {
    final pickedVideo = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    initController(pickedVideo);
  }

  initController(XFile? pickedVideo) async {
    if (pickedVideo != null) {
      setState(() {
        isLoading = true;
      });

      videoPlayerController = VideoPlayerController.file(
        File(pickedVideo.path),
      );
      await videoPlayerController!.initialize();

      videoPlayerController!.addListener(() {
        setState(() {});
      });
    }

    setState(() {
      this.video = pickedVideo;
      isLoading = false;
    });
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTap;

  const _VideoSelector({required this.onLogoTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A3A7C),
            Color(0xFF000118),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(onTap: onLogoTap),
          SizedBox(height: 28.0),
          _Title(),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 32.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final XFile video;
  final VideoPlayerController videoPlayerController;
  final VoidCallback onAnotherVideoPicked;
  final Function(XFile?) onInitController;

  const _VideoPlayer({
    required this.video,
    required this.videoPlayerController,
    required this.onAnotherVideoPicked,
    required this.onInitController,
    super.key,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  bool showIcons = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.video.path != widget.video.path) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onInitController(widget.video);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showIcons = !showIcons;
        });
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: widget.videoPlayerController.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(
                widget.videoPlayerController,
              ),
              if (showIcons)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                ),
              if (showIcons)
                _PlayButton(
                  onReversePressed: onReversePressed,
                  onPlayPressed: onPlayPressed,
                  onForwardPressed: onForwardPressed,
                  isPlaying: widget.videoPlayerController.value.isPlaying,
                ),
              _Bottom(
                position: widget.videoPlayerController.value.position,
                maxPosition: widget.videoPlayerController.value.duration,
                onSliderChanged: onSliderChanged,
              ),
              if (showIcons)
                _PickAnotherVideo(
                  onPressed: widget.onAnotherVideoPicked,
                ),
            ],
          ),
        ),
      ),
    );
  }

  onReversePressed() {
    final currentPosition = widget.videoPlayerController.value.position;
    Duration position = Duration();

    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    widget.videoPlayerController.seekTo(position);
  }

  onPlayPressed() {
    setState(() {
      if (widget.videoPlayerController.value.isPlaying) {
        widget.videoPlayerController.pause();
      } else {
        widget.videoPlayerController.play();
      }
    });
  }

  onForwardPressed() {
    final maxPosition = widget.videoPlayerController.value.duration;
    final currentPosition = widget.videoPlayerController.value.position;
    Duration position = maxPosition;

    if ((maxPosition - Duration(seconds: 3)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    widget.videoPlayerController.seekTo(position);
  }

  onSliderChanged(double value) {
    final position = Duration(seconds: value.toInt());

    widget.videoPlayerController.seekTo(position);
  }
}

class _PlayButton extends StatelessWidget {
  final VoidCallback onReversePressed;
  final VoidCallback onPlayPressed;
  final VoidCallback onForwardPressed;
  final bool isPlaying;

  const _PlayButton({
    required this.onReversePressed,
    required this.onPlayPressed,
    required this.onForwardPressed,
    required this.isPlaying,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            color: Colors.white,
            onPressed: onReversePressed,
            icon: Icon(Icons.rotate_left),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onPlayPressed,
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
          IconButton(
            color: Colors.white,
            onPressed: onForwardPressed,
            icon: Icon(Icons.rotate_right),
          ),
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  final Duration position;
  final Duration maxPosition;
  final ValueChanged<double> onSliderChanged;

  const _Bottom({
    required this.position,
    required this.maxPosition,
    required this.onSliderChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Row(
          children: [
            Text(
              '${position.inMinutes.toString().padLeft(2, '0')}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Slider(
                value: position.inSeconds.toDouble(),
                max: maxPosition.inSeconds.toDouble(),
                onChanged: onSliderChanged,
              ),
            ),
            Text(
              '${maxPosition.inMinutes.toString().padLeft(2, '0')}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickAnotherVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _PickAnotherVideo({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        color: Colors.white,
        onPressed: onPressed,
        icon: Icon(
          Icons.photo_camera_back,
        ),
      ),
    );
  }
}
