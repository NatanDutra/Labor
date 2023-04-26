// flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

// utils
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.error,
    this.errorText,
    this.typeError,
    this.label,
    this.textInputAction,
    this.inputType,
    this.vertPad,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.hint,
    this.onChanged,
    this.onTap,
    this.counterText,
    this.enabled,
    this.width,
    this.height,
    this.textCapitalization,
  });

  final TextEditingController controller;
  final bool? error;
  final String? errorText;
  final bool? typeError;
  final String? label;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final double? vertPad;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final String? hint;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? counterText;
  final bool? enabled;
  final double? width;
  final double? height;
  final TextCapitalization? textCapitalization;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Text(
                widget.label!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: scaleHeight * 13,
                  color: blackColor,
                ),
              )
            : sh(0),
        widget.label != null ? sh(10) : sh(0),
        Stack(
          children: [
            TextFormField(
              scrollPadding: EdgeInsets.symmetric(
                vertical: scaleHeight * 250,
              ),
              controller: widget.controller,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              onChanged: widget.onChanged,
              enabled: widget.enabled,
              onTap: widget.onTap,
              style: TextStyle(
                fontSize: scaleWidth * 13,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              maxLines: widget.maxLines ?? 1,
              minLines: widget.minLines ?? 1,
              maxLength: widget.maxLength,
              textInputAction: widget.textInputAction,
              keyboardType: widget.inputType ?? TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                isDense: true,
                fillColor: inputColorBackground,
                counterText: widget.counterText,
                counterStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: scaleHeight * 13,
                  color: blackColor.withOpacity(0.4),
                ),
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: scaleHeight * 13,
                  color: blackColor.withOpacity(0.4),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: scaleWidth * 12,
                  vertical: widget.vertPad ?? scaleHeight * 12,
                ),
                focusedBorder: widget.error!
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: redColor,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                        ),
                      ),
                border: widget.error!
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: redColor,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                        ),
                      ),
                enabledBorder: widget.error!
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: redColor,
                        ),
                      )
                    : const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: borderColor,
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: scaleHeight * 8,
              child: widget.error!
                  ? widget.typeError == true
                      ? Text(
                          widget.errorText ??
                              '** Este campo não pode estar vazio',
                          style: TextStyle(
                            fontSize: scaleHeight * 10,
                            fontWeight: FontWeight.w400,
                            color: redColor,
                          ),
                        )
                      : Text(
                          '** Este campo não pode estar vazio',
                          style: TextStyle(
                            fontSize: scaleHeight * 10,
                            fontWeight: FontWeight.w400,
                            color: redColor,
                          ),
                        )
                  : sh(0),
            )
          ],
        )
      ],
    );
  }
}

class AppTextFieldIcon extends StatefulWidget {
  const AppTextFieldIcon({
    super.key,
    required this.controller,
    required this.input,
    this.icon,
    this.label,
    this.inputType,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onChanged,
    this.textCapitalization,
    this.width,
    this.hint,
    this.enabled,
    this.maxLength,
    this.error = false,
    this.errorText,
    this.typeError,
    this.errorColor,
    this.autofocus,
  });

  final TextEditingController controller;
  final String input;
  final IconData? icon;
  final String? label;
  final TextInputType? inputType;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextCapitalization? textCapitalization;
  final double? width;
  final String? hint;
  final bool? enabled;
  final int? maxLength;
  final bool? error;
  final String? errorText;
  final bool? typeError;
  final Color? errorColor;
  final bool? autofocus;

  @override
  State<AppTextFieldIcon> createState() {
    return _AppTextFieldIconState();
  }
}

class _AppTextFieldIconState extends State<AppTextFieldIcon> {
  bool isVisibilty = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    List<TextInputFormatter> formatter = _typeFormatter(widget.input) ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.label != null)
            ? Text(
                widget.label!,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: scaleHeight * 13,
                  color: blackColor,
                ),
              )
            : sh(0),
        (widget.label != null) ? sh(10) : sh(0),
        Container(
          width: widget.width ?? SizeConfig.screenWidth,
          height: scaleHeight * 48,
          decoration: BoxDecoration(
            color: inputColorBackground,
            border: Border.all(
              color:
                  widget.error! ? widget.errorColor ?? redColor : borderColor,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              widget.icon != null
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: scaleWidth * 15,
                      ),
                      child: Icon(
                        widget.icon,
                        size: scaleHeight * 25,
                        color: blackColor.withOpacity(0.6),
                      ))
                  : sb(0),
              Expanded(
                child: Padding(
                  padding: widget.input != 'search'
                      ? EdgeInsets.symmetric(
                          horizontal: scaleWidth * 15,
                        )
                      : EdgeInsets.only(
                          left: scaleWidth * 15,
                          right: scaleWidth * 50,
                        ),
                  child: Center(
                    child: TextFormField(
                      onChanged: widget.onChanged,
                      style: TextStyle(
                        fontSize: scaleWidth * 13,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                      ),
                      autofocus: widget.autofocus ?? false,
                      enabled: widget.enabled,
                      maxLength: widget.maxLength,
                      textCapitalization:
                          widget.textCapitalization ?? TextCapitalization.none,
                      textAlignVertical: TextAlignVertical.center,
                      controller: widget.controller,
                      inputFormatters: formatter,
                      obscureText:
                          widget.input == 'password' ? !isVisibilty : false,
                      obscuringCharacter: "*",
                      keyboardType: widget.inputType ?? TextInputType.text,
                      maxLines: 1,
                      minLines: 1,
                      textInputAction:
                          widget.textInputAction ?? TextInputAction.done,
                      focusNode: widget.focusNode,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: widget.hint,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: scaleHeight * 13,
                          color: blackColor.withOpacity(0.4),
                        ),
                        errorStyle: const TextStyle(
                          height: 0,
                          fontSize: 0,
                        ),
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              widget.input == 'password'
                  ? Padding(
                      padding: EdgeInsets.only(
                        right: scaleHeight * 15,
                      ),
                      child: InkWell(
                        highlightColor: transparent,
                        splashColor: transparent,
                        onTap: () {
                          setState(() {
                            isVisibilty = !isVisibilty;
                          });
                        },
                        child: Icon(
                          isVisibilty ? Icons.visibility : Icons.visibility_off,
                          size: scaleHeight * 25,
                          color: blackColor.withOpacity(0.6),
                        ),
                      ),
                    )
                  : sb(0),
            ],
          ),
        ),
        (widget.error == true) ? sh(5) : sh(0),
        widget.error!
            ? widget.typeError == true
                ? Text(
                    widget.errorText ?? '** Este campo não pode estar vazio',
                    style: TextStyle(
                      fontSize: scaleHeight * 10,
                      fontWeight: FontWeight.w400,
                      color: widget.errorColor ?? redColor,
                    ),
                  )
                : Text(
                    '** Este campo não pode estar vazio',
                    style: TextStyle(
                      fontSize: scaleHeight * 10,
                      fontWeight: FontWeight.w400,
                      color: widget.errorColor ?? redColor,
                    ),
                  )
            : sh(0),
      ],
    );
  }
}

_typeFormatter(type) {
  switch (type) {
    case "cpf":
      {
        return [
          FilteringTextInputFormatter.digitsOnly,
          CpfInputFormatter(),
        ];
      }
    case "date":
      {
        return [
          FilteringTextInputFormatter.digitsOnly,
          DataInputFormatter(),
        ];
      }
    case "phone":
      {
        return [
          FilteringTextInputFormatter.digitsOnly,
          TelefoneInputFormatter(),
        ];
      }
    case "money":
      {
        return [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(),
        ];
      }
  }
}
