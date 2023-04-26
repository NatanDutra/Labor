// flutter
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class AppShimmerLabel extends StatelessWidget {
  const AppShimmerLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: grayColor.withOpacity(0.2),
      highlightColor: grayColor.withOpacity(0.6),
      child: Container(
        width: SizeConfig.screenWidth,
        height: scaleHeight * 48,
        decoration: const BoxDecoration(
          color: backgroundColor,
        ),
      ),
    );
  }
}

class AppImageShimmer extends StatelessWidget {
  const AppImageShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: grayColor.withOpacity(0.2),
      highlightColor: grayColor.withOpacity(0.6),
      child: Container(
        width: scaleWidth * 90,
        height: scaleHeight * 90,
        decoration: const BoxDecoration(
          color: backgroundColor,
        ),
      ),
    );
  }
}
