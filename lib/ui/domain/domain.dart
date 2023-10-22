import 'package:flutter/material.dart';
import 'package:simple_moments/ui/global_components/bottom_nav_widget.dart';
import 'package:simple_moments/ui/nav_screens/home/home.dart';
import 'package:simple_moments/ui/nav_screens/profile/profile.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/multi_value_listenable.dart';


final isBottomNavVisible = ValueNotifier(true);

class Domain extends StatefulWidget {
  const Domain({Key? key}) : super(key: key);

  @override
  State<Domain> createState() => _DomainState();
}

class _DomainState extends State<Domain> {
  @override
  void initState() {
    super.initState();
    // context.read<PersonalInfoCubit>().getProfile();
  }

  Widget bottomPages({required int index}) {
    final bottomPages = [
      const Home(),
      const Profile(),
    ];
    return bottomPages[index];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MultiValueListenableBuilder(
          valueListenables: [pagePosition, isBottomNavVisible],
          builder: (context, List value, child) {
            return Scaffold(
              backgroundColor: kPrimaryDark,
              body: Stack(
                children: [
                  bottomPages(index: value[0]),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: BottomNavWidget(),
                  )
                ],
              ),
            );
          }),
    );
  }
}
