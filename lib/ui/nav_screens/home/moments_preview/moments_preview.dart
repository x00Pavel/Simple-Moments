import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/ui/nav_screens/home/home_cubit.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/text_styles.dart';
import 'video_item.dart';

class MomentsPreview extends StatelessWidget {
  const MomentsPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              state.isLoading
                  ? Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CupertinoActivityIndicator(color: Colors.white),
                    globalGap(2),
                    Text('Loading ...',
                        style: mediumText(color: Colors.white)),
                  ],
                ),
              )
                  : PageView.builder(
                      controller:
                          PageController(initialPage: 0, viewportFraction: 1),
                      itemCount: state.videoList.length,
                      onPageChanged: (index) {
                        index = index % (state.videoList.length);
                        context.read<HomeCubit>().changeVideo(index);
                      },
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        index = index % (state.videoList.length);
                        return VideoItem(video: state.videoList[index]);
                      },
                    ),
              // ForYouWidget(),
            ],
          ),
        );
      },
    );
  }
}
