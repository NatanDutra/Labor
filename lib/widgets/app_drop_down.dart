// flutter
// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:async_loader/async_loader.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

// widgets
import '../../widgets/app_error_screen.dart';
import '../../widgets/app_shimmer_label.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({
    Key? key,
    @required this.valueReturned,
    @required this.list,
    @required this.label,
    @required this.error,
    @required this.hint,
    this.initValue,
    this.upperCase = false,
    this.width,
    this.height,
  }) : super(key: key);

  final Function(String)? valueReturned;
  final List<String>? list;
  final String? label;
  final String? initValue;
  final String? hint;
  final double? width;
  final double? height;
  final bool? error;
  final bool upperCase;

  @override
  State<AppDropdown> createState() {
    return _AppDropdownState();
  }
}

class _AppDropdownState extends State<AppDropdown> {
  GlobalKey<AsyncLoaderState> _asyncLoaderState = GlobalKey<AsyncLoaderState>();
  String? value;

  _loadData() async {
    if (widget.initValue != null) {
      value = widget.initValue;
    } else {
      value = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    var asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await _loadData(),
      renderLoad: () => const AppShimmerLabel(),
      renderError: ([error]) => const ErrorStatic(nav: false),
      renderSuccess: ({data}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label!,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: scaleHeight * 13,
              color: blackColor,
            ),
          ),
          sh(8),
          Container(
            padding: EdgeInsets.only(
              top: scaleHeight * 5,
              bottom: scaleHeight * 5,
              left: scaleWidth * 15,
              right: scaleWidth * 5,
            ),
            width: widget.width ?? SizeConfig.screenWidth,
            height: widget.height ?? scaleHeight * 48,
            decoration: BoxDecoration(
              color: inputColorBackground,
              border: Border.all(
                color: widget.error! ? redColor : borderColor,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: value,
                isDense: true,
                isExpanded: true,
                onChanged: (String? newValue) {
                  setState(() {
                    value = newValue;
                    widget.valueReturned!(newValue!);
                  });
                },
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: scaleHeight * 13,
                  color: blackColor,
                ),
                hint: Text(
                  widget.hint!,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: scaleHeight * 13.5,
                    color: blackColor.withOpacity(0.4),
                  ),
                ),
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: scaleHeight * 25,
                ),
                items: widget.list?.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      widget.upperCase ? item.toUpperCase() : item,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: scaleHeight * 13,
                        color: blackColor,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          (widget.error == true) ? sh(5) : sh(0),
          widget.error!
              ? Text(
                  '** Este campo não pode estar vazio',
                  style: TextStyle(
                    fontSize: scaleHeight * 10,
                    fontWeight: FontWeight.w400,
                    color: redColor,
                  ),
                )
              : sh(2),
        ],
      ),
    );

    return asyncLoader;
  }
}

// ignore: must_be_immutable
class AppDropdownSub extends StatefulWidget {
  AppDropdownSub({
    Key? key,
    @required this.valueReturned,
    @required this.list,
    @required this.label,
    @required this.error,
    @required this.hint,
    this.width,
    this.height,
    this.value,
  }) : super(key: key);

  final Function(String?)? valueReturned;
  final List<String>? list;
  final String? label;
  final String? hint;
  final double? width;
  final double? height;
  final bool? error;
  String? value;

  @override
  State<AppDropdownSub> createState() {
    return _AppDropdownSubState();
  }
}

class _AppDropdownSubState extends State<AppDropdownSub> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label!,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: scaleHeight * 13,
            color: blackColor,
          ),
        ),
        sh(8),
        Container(
          padding: EdgeInsets.only(
            top: scaleHeight * 5,
            bottom: scaleHeight * 5,
            left: scaleWidth * 15,
            right: scaleWidth * 5,
          ),
          width: widget.width ?? SizeConfig.screenWidth,
          height: widget.height ?? scaleHeight * 48,
          decoration: BoxDecoration(
            color: inputColorBackground,
            border: Border.all(
              color: widget.error! ? redColor : borderColor,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: widget.value,
              onChanged: widget.valueReturned,
              hint: Text(
                widget.hint!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: scaleHeight * 13.5,
                  color: blackColor.withOpacity(0.4),
                ),
              ),
              items: widget.list?.map((String item) {
                return DropdownMenuItem(
                  value: item.trim(),
                  child: Text(
                    item.trim(),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: scaleHeight * 13,
                      color: blackColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        widget.error!
            ? Text(
                '** Este campo não pode estar vazio',
                style: TextStyle(
                  fontSize: scaleHeight * 10,
                  fontWeight: FontWeight.w400,
                  color: redColor,
                ),
              )
            : sh(2),
      ],
    );
  }
}
