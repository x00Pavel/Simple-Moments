import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_moments/database/moments_model/moments_model.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/size_config.dart';
import 'package:simple_moments/utils/text_styles.dart';

class VideoItem extends StatefulWidget {
  const VideoItem({Key? key, required this.video}) : super(key: key);

  final Video video;

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.video.controller != null
            ? GestureDetector(
                onTap: () {
                  widget.video.controller!.value.isPlaying
                      ? widget.video.controller?.pause()
                      : widget.video.controller?.play();
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: widget.video.controller?.value.size.width ?? 0,
                    height: widget.video.controller?.value.size.height ?? 0,
                    child: CachedVideoPlayer(widget.video.controller!),
                  ),
                )),
              )
            : Container(
                color: Colors.black,
                width: widget.video.controller?.value.size.width ?? 0,
                height: widget.video.controller?.value.size.height ?? 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CupertinoActivityIndicator(color: Colors.white),
                        globalGap(3),
                        Text('Loading...',
                            style: regularText(color: Colors.white))
                      ],
                    ),
                  ],
                ),
              ),
        Positioned(
            left: 6.heightAdjusted,
            top: 15.heightAdjusted,
            child: GestureDetector(
              onTap: () => globalPop(),
              child: Container(
                  color: Colors.transparent,
                  height: 4.heightAdjusted,
                  width: 4.heightAdjusted,
                  child: const Icon(Icons.arrow_back_ios, color: kWhite)),
            )),
        Positioned(
            left: 4.heightAdjusted,
            bottom: 25.heightAdjusted,
            child: VideoDescription(
                'sss',
                'New Moment',
                'New Simple Moment')),
      ],
    );
  }
}

class VideoDescription extends StatelessWidget {
  final username;
  final videoTitle;
  final songInfo;

  const VideoDescription(this.username, this.videoTitle, this.songInfo,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '@ $username',
            style: regularText(fontSize: 16, color: Colors.white),
          ),
          globalGap(4),
          Text(
            videoTitle,
            style: regularText(fontSize: 16, color: Colors.white),
          ),
          globalGap(4),
          Row(children: [
            const Icon(Icons.music_note, size: 15.0, color: Colors.white),
            Text(
              songInfo,
              style: regularText(fontSize: 14, color: Colors.white),
            )
          ]),
        ]);
  }
}
