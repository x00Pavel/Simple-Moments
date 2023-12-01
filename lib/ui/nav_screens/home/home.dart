import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/ui/global_components/global_shimmer_loader.dart';
import 'package:simple_moments/ui/nav_screens/home/home_cubit.dart';
import 'package:simple_moments/utils/global_padding.dart';
import 'package:simple_moments/utils/global_strings.dart';
import 'package:simple_moments/utils/text_styles.dart';

import 'components/empty_moment_widget.dart';
import 'components/list_of_moments.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GlobalPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(simpleMoments,
                  style: semiBoldText(color: Colors.white, fontSize: 22)),
              state.isLoading && state.moments.isEmpty
                  ? const MomentsShimmerLoader()
                  : state.moments.isEmpty
                      ? const EmptyMomentWidget()
                      : const ListOfMoments(),
            ],
          ),
        );
      },
    );
  }
}
