import 'package:simple_moments/database/moments_model/moments_model.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/global_strings.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/size_config.dart';
import 'package:simple_moments/utils/text_styles.dart';
import 'package:video_player/video_player.dart';

class MomentsPreview extends StatefulWidget {
  const MomentsPreview({super.key, required this.moment});

  final Moment moment;

  @override
  State<MomentsPreview> createState() => _MomentsPreviewState();
}

class _MomentsPreviewState extends State<MomentsPreview> {
  late VideoPlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    print(widget.moment.videos.length);

    print((widget.moment.videos[0].video));

    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'http://192.168.185.40/video/${widget.moment.videos[0].video}'))
      ..addListener(
          () => setState(() => isPlaying = _controller.value.isPlaying))
      ..initialize().then((_) => setState(() {}))
      ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlue,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => globalPop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.more_vert_rounded, color: Colors.white)),
            ],
          ),
          globalGap(7),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryDark,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5.heightAdjusted)),
              ),
              child: Stack(
                children: [
                  _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20)),
                              child: VideoPlayer(_controller)),
                        )
                      : Container(),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('29 Aug - 05 Sept. 2023',
                              style: regularText(
                                  color: Colors.white.withAlpha(100),
                                  fontSize: 16)),
                          globalGap(2),
                          Text('My first moments',
                              style: semiBoldText(
                                  color: Colors.white, fontSize: 22)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
