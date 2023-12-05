import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_moments/database/moments_model/moments_model.dart';
import 'package:simple_moments/utils/helpers.dart';
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
                        globalGap(10),
                        Text('Loading...',
                            style: regularText(color: Colors.white))
                      ],
                    ),
                  ],
                ),
              ),
        // Positioned(
        //     left: 4.heightAdjusted,
        //     bottom: 25.heightAdjusted,
        //     child: VideoDescription(widget.video.user, widget.video.videoTitle,
        //         widget.video.songName)),
        // Positioned(
        //     right: 4.heightAdjusted,
        //     top: 25.heightAdjusted,
        //     child: ActionsToolbar(
        //         widget.video.likes,
        //         widget.video.comments,
        //         "https://www.andersonsobelcosmetic.com"
        //         "/wp-content/uploads/2018/09/chin-implant-vs"
        //         "-fillers-best-for-improving-profile-bellevue"
        //         "-washington-chin-surgery.jpg")),
      ],
    );
  }
}
