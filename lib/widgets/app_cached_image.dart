// flutter
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    Key? key,
    required this.height,
    required this.width,
    this.imgUrl,
    this.number,
    this.fun,
    this.borderImg = true,
  }) : super(key: key);

  final String? imgUrl;
  final double height;
  final double width;
  final Function()? fun;
  final Widget? number;
  final bool? borderImg;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: fun,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: imgUrl!,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: grayColor.withOpacity(0.2),
                highlightColor: grayColor.withOpacity(0.6),
                child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    color: backgroundColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: backgroundColor,
                ),
                child: Icon(
                  Icons.error,
                  color: redColor,
                  size: scaleHeight * 25,
                ),
              ),
              imageBuilder: (context, imageProvider) => Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            number != null
                ? Positioned(
                    top: scaleHeight * 15,
                    right: scaleWidth * 15,
                    child: Container(
                      padding: EdgeInsets.all(
                        scaleHeight * 6,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: blackColor.withOpacity(0.4),
                            offset: const Offset(0.0, 1.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: number,
                    ),
                  )
                : sh(0),
          ],
        ),
      ),
    );
  }
}
