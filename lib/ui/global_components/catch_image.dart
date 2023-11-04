
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:simple_moments/utils/colors.dart';
import 'package:simple_moments/utils/dimensions.dart';
import 'package:simple_moments/utils/size_config.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String imageUrl;
  final double height, width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: width.heightAdjusted,
      height: height.heightAdjusted,
      errorWidget: (context, url, error) => Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kTextColor.withAlpha(100),
          borderRadius: BorderRadius.circular(spacingPadding3),
        ),
      ),
      placeholder: (context, url) => FadeShimmer(
        highlightColor: const Color(0xffF9F9FB),
        baseColor: const Color(0xffE6E8EB),
        height: height.heightAdjusted,
        width: width.heightAdjusted,
      ),
    );
  }
}
