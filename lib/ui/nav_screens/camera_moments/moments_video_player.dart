import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';
import 'package:simple_moments/utils/size_config.dart';
import 'package:video_player/video_player.dart';

import 'moments_cubit.dart';

class MomentsVideoPlayer extends StatefulWidget {
  const MomentsVideoPlayer({
    Key? key,
  }) : super(key: key);

  @override
  State<MomentsVideoPlayer> createState() => _MomentsVideoPlayerState();
}

class _MomentsVideoPlayerState extends State<MomentsVideoPlayer> {
  late VideoPlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
        File(context.read<MomentCubit>().state.filePath))
      ..addListener(
          () => setState(() => isPlaying = _controller.value.isPlaying))
      ..initialize().then((_) => setState(() {}))
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
    setState(() => isPlaying = !isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160.heightAdjusted,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: VideoPlayer(_controller)),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => context.read<MomentCubit>().uploadMoment(),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacingPadding4,
                        vertical: spacingPadding3,
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          )),
                      child: SvgPicture.asset(save, height: spacingPadding7)),
                ),
                GestureDetector(
                  onTap: _onTap,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacingPadding4,
                        vertical: spacingPadding4,
                      ),
                      decoration: const BoxDecoration(color: kPrimaryBlue),
                      child: SvgPicture.asset(isPlaying ? pause : play,
                          color: Colors.white)),
                ),
                GestureDetector(
                  onTap: () => globalPop(),
                  child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spacingPadding4,
                        vertical: 4.2.heightAdjusted,
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: SvgPicture.asset(cancel)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
