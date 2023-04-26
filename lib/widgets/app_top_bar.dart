// flutter
import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class TopBarNotLogged extends StatelessWidget {
  const TopBarNotLogged({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: transparent,
      splashColor: transparent,
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.only(
          left: scaleWidth * 8,
        ),
        width: scaleWidth * 35,
        height: scaleWidth * 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: blackColor.withOpacity(0.15),
        ),
        child: Icon(
          Icons.arrow_back_ios,
          size: scaleHeight * 24,
        ),
      ),
    );
  }
}

class AppTopBarCenter extends StatelessWidget {
  const AppTopBarCenter({
    Key? key,
    required this.txt,
    this.fontSize,
    this.color,
  }) : super(key: key);

  final String txt;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: scaleHeight * 60,
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: color ?? primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            txt,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: fontSize ?? (scaleWidth * 18),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class AppTopChatBar extends StatelessWidget {
  const AppTopChatBar({
    Key? key,
    required this.name,
    required this.avatar,
  }) : super(key: key);

  final String name;
  final String avatar;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: scaleHeight * 60,
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
        color: primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: scaleHeight * 22,
                horizontal: scaleWidth * 20,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: scaleHeight * 20,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: grayColor,
                  backgroundImage: NetworkImage(
                    avatar,
                  ),
                ),
                sb(12),
                SizedBox(
                    width: scaleWidth * 200,
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: scaleHeight * 12,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
