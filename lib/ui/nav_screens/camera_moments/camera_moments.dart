import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_moments/dependency/navigation/global_router_exports.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/global_assets.dart';

class CameraMoments extends StatefulWidget {
  const CameraMoments({super.key});

  @override
  State<CameraMoments> createState() => _CameraMomentsState();
}

class _CameraMomentsState extends State<CameraMoments>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? _controller;
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    cameras = await availableCameras();

    _controller = CameraController(cameras[1], ResolutionPreset.max);
    _controller!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null || !_controller!.value.isInitialized
        ? Container(
            color: kPrimaryDark,
            child: const Center(
              child: CupertinoActivityIndicator(color: kPrimaryDark),
            ),
          )
        : Scaffold(
            body: Stack(
              children: [
                Positioned.fill(child: CameraPreview(_controller!)),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                          child:
                              SvgPicture.asset(stop, height: spacingPadding7)),
                      Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spacingPadding4,
                            vertical: spacingPadding4,
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )),
                          child: SvgPicture.asset(cancel)),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
