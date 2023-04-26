// flutter
// ignore_for_file: library_private_types_in_public_api, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

// widgets
import '../../widgets/app_button.dart';

class MultiSelectDialog extends StatefulWidget {
  const MultiSelectDialog({
    Key? key,
    required this.list,
    required this.title,
  }) : super(key: key);

  final List<MultiSelectItem> list;
  final String? title;

  @override
  State<StatefulWidget> createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, widget.list);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title!,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: scaleHeight * 13,
          color: blackColor,
        ),
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListBody(
          children: widget.list
              .map(
                (item) => CheckboxListTile(
                  value: item.isSelected,
                  activeColor: primaryColor,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.w400,
                      fontSize: scaleHeight * 13,
                    ),
                  ),
                  onChanged: (isChecked) => {
                    setState(() {
                      item.isSelected = isChecked ?? false;
                    }),
                  },
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButtonTransparent(
                label: 'Cancel',
                width: scaleWidth * 120,
                textColor: blackColor,
                onPressed: _cancel,
              ),
              sb(30),
              AppButton(
                label: 'OK',
                width: scaleWidth * 120,
                onPressed: _submit,
              ),
            ],
          ),
        ),
        sh(12),
      ],
    );
  }
}

class MultiSelectItem {
  final String title;
  bool isSelected;
  MultiSelectItem({
    required this.title,
    this.isSelected = false,
  });
}

class AppMultiSelect extends StatefulWidget {
  const AppMultiSelect({
    Key? key,
    required this.valueReturned,
    required this.list,
    required this.error,
    this.initList,
    this.label,
    this.hint,
    this.width,
    this.height,
    this.textColor,
    this.textFontSize,
    this.labelFontSize,
    this.errorFontSize,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  final Function(List<String>) valueReturned;
  final List<String> list;
  final List<String>? initList;
  final String? label;
  final String? hint;
  final bool? error;
  final double? width;
  final double? height;
  final Color? textColor;
  final double? textFontSize;
  final double? labelFontSize;
  final double? errorFontSize;
  final IconData? icon;
  final Color? iconColor;

  @override
  _AppMultiSelectState createState() => _AppMultiSelectState();
}

class _AppMultiSelectState extends State<AppMultiSelect> {
  List<String> _selectedItems = [];
  List<MultiSelectItem> _list = [];

  @override
  void initState() {
    _list = List<MultiSelectItem>.from(
      widget.list.map(
        (item) => MultiSelectItem(
          title: item,
        ),
      ),
    ).toList();

    if (widget.initList != null) {
      _selectedItems = widget.initList!;

      widget.initList!
          .map(
            (data) => {
              _list
                  .map(
                    (listData) => {
                      if (listData.isSelected != true)
                        {
                          if (data == listData.title)
                            {
                              listData.isSelected = true,
                            }
                          else
                            {
                              listData.isSelected = false,
                            }
                        },
                    },
                  )
                  .toList(),
            },
          )
          .toList();
    }

    super.initState();
  }

  void _showMultiSelect() async {
    final List<MultiSelectItem>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          list: _list,
          title: widget.label,
        );
      },
    );

    if (results != null) {
      _selectedItems.clear();

      results.map((item) {
        if (item.isSelected == true) {
          _selectedItems.add(item.title);
        }
      }).toList();

      setState(() {
        _selectedItems = _selectedItems;
        _list = results;
        widget.valueReturned(_selectedItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Text(
                widget.label!,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: scaleHeight * 13,
                  color: widget.textColor ?? blackColor,
                ),
              )
            : sh(0),
        sh(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                _showMultiSelect();
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: scaleHeight * 5,
                  bottom: scaleHeight * 5,
                  left: scaleWidth * 13,
                  right: scaleWidth * 5,
                ),
                width: SizeConfig.screenWidth,
                height: widget.height ?? scaleHeight * 52,
                decoration: BoxDecoration(
                  color: inputColorBackground,
                  border: Border.all(
                    color: widget.error! ? redColor : borderColor,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    widget.icon != null
                        ? Container(
                            margin: EdgeInsets.only(
                              right: scaleWidth * 13,
                            ),
                            child: Icon(
                              widget.icon,
                              color: widget.iconColor ??
                                  blackColor.withOpacity(0.6),
                              size: widget.height != null
                                  ? (widget.height! / 2)
                                  : scaleHeight * 26,
                            ),
                          )
                        : sb(0),
                    _selectedItems.isEmpty
                        ? Expanded(
                            child: Text(
                              widget.hint!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: widget.height != null
                                    ? (widget.height! / 4)
                                    : scaleHeight * 13,
                                color: widget.textColor?.withOpacity(0.5) ??
                                    blackColor.withOpacity(0.5),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Text(
                              _selectedItems.length.toString() +
                                  ' de ' +
                                  widget.list.length.toString() +
                                  " selecionados",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: widget.height != null
                                    ? (widget.height! / 4)
                                    : scaleHeight * 13,
                                color: widget.textColor ?? blackColor,
                              ),
                            ),
                          ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: widget.iconColor ?? blackColor.withOpacity(0.6),
                      size: widget.height != null
                          ? (widget.height! / 2)
                          : scaleHeight * 26,
                    ),
                  ],
                ),
              ),
            ),
            widget.error!
                ? Container(
                    margin: EdgeInsets.only(
                      top: scaleHeight * 2,
                    ),
                    child: Text(
                      '** Este campo não pode estar vazio',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: widget.height != null
                            ? (widget.height! / 5)
                            : scaleHeight * 10,
                        color: redColor,
                      ),
                    ),
                  )
                : sh(0),
            _selectedItems != [] ? sh(4) : sh(0),
            _selectedItems != []
                ? Wrap(
                    children: _selectedItems
                        .map(
                          (text) => Padding(
                            padding: EdgeInsets.only(
                              right: scaleWidth * 8,
                            ),
                            child: Chip(
                              backgroundColor: primaryColor,
                              label: Text(
                                text,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: scaleHeight * 13,
                                  color: widget.textColor ?? blackColor,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                : sh(0),
          ],
        ),
      ],
    );
  }
}
