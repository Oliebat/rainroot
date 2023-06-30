import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextFormFieldShape? shape;
  final TextFormFieldPadding? padding;
  final TextFormFieldVariant? variant;
  final TextFormFieldFontStyle? fontStyle;
  final Alignment? alignment;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final bool? isObscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final FormFieldValidator<String>? validator;

  CustomTextFormField({
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  Widget _buildTextFormFieldWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus!,
        style: _setFontStyle(),
        obscureText: isObscureText!,
        textInputAction: textInputAction!,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        decoration: _buildDecoration(),
        validator: validator,
      ),
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      suffixIcon: suffix,
      suffixIconConstraints: suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  TextStyle _setFontStyle() {
    switch (fontStyle) {
      case TextFormFieldFontStyle.WorkSansRomanRegular12:
        return TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.w400,
        );
      default:
        return TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Work Sans',
          fontWeight: FontWeight.w400,
        );
    }
  }

  BorderRadius _setOutlineBorderRadius() {
    switch (shape) {
      case TextFormFieldShape.CircleBorder17:
        return BorderRadius.circular(17.0);
      default:
        return BorderRadius.circular(17.0);
    }
  }

  InputBorder _setBorderStyle() {
    switch (variant) {
      case TextFormFieldVariant.None:
        return InputBorder.none;
      case TextFormFieldVariant.OutlineBluegray700:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: Colors.blueGrey[700]!,
            width: 1,
          ),
        );
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: Colors.blueGrey[700]!,
            width: 1,
          ),
        );
    }
  }

  Color _setFillColor() {
    switch (variant) {
      default:
        return Colors.white;
    }
  }

  bool _setFilled() {
    switch (variant) {
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  EdgeInsets _setPadding() {
    switch (padding) {
      case TextFormFieldPadding.PaddingT9:
        return EdgeInsets.only(left: 9, top: 9, bottom: 9);
      default:
        return EdgeInsets.only(left: 9, top: 9, bottom: 9);
    }
  }
}

enum TextFormFieldShape {
  CircleBorder17,
}

enum TextFormFieldPadding {
  PaddingT9,
}

enum TextFormFieldVariant {
  None,
  OutlineBluegray700,
}

enum TextFormFieldFontStyle {
  WorkSansRomanRegular12,
}
