// flutter
import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: [
          Transform.scale(
            scale: scaleHeight * 1,
            child: Checkbox(
              side: BorderSide(
                color: grayColor,
                width: scaleWidth * 1,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              activeColor: primaryColor,
              checkColor: whiteColor,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
          ),
          sb(5),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: scaleHeight * 13,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
