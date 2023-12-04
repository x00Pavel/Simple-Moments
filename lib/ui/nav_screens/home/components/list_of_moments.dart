import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/api_service/app_config/app_config.dart';
import 'package:simple_moments/database/moments_model/moments_model.dart';
import 'package:simple_moments/dependency/get_it.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/dependency/navigation/navigator_routes.dart';
import 'package:simple_moments/ui/nav_screens/home/home_cubit.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';
import 'package:simple_moments/utils/helpers.dart';
import 'package:simple_moments/utils/text_styles.dart';

class ListOfMoments extends StatelessWidget {
  const ListOfMoments({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Flexible(
          child: RefreshIndicator(
            onRefresh: () => context.read<HomeCubit>().getMoments(),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ListView.builder(
                  padding: EdgeInsets.only(top: spacingPadding8),
                  itemCount: state.moments.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      _MomentWidget(moment: state.moments[index])),
            ),
          ),
        );
      },
    );
  }
}

class _MomentWidget extends StatelessWidget {
  const _MomentWidget({required this.moment});

  final Moment moment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacingPadding5),
      child: GestureDetector(
        onTap: () =>
            globalNavigateTo(route: Routes.momentsPreview, arguments: moment),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('29 Aug - 05 Sept. 2023',
                style: regularText(
                    color: Colors.white.withAlpha(100), fontSize: 16)),
            globalGap(2),
            Stack(
              children: [
                SizedBox(
                  width: deviceWidth,
                  height: spacingPadding25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ListView.builder(
                        itemCount: moment.videos.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CachedNetworkImage(
                              imageUrl:
                                  '${getItInstance<AppConfig>().baseUrl}thumbnail/${moment.videos[index].video}',
                              fit: BoxFit.cover,
                            )),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryBlue.withAlpha(140),
                              borderRadius: BorderRadius.circular(50)),
                          child: SvgPicture.asset(playButton,
                              height: spacingPadding8, width: spacingPadding8),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
