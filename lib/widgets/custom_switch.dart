import 'package:flutter/material.dart';
import 'package:rainroot/core/app_export.dart';

class CustomSwitch extends StatelessWidget {
  CustomSwitch({this.alignment, this.margin, this.value, this.onChanged});

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  bool? value;

  Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildSwitchWidget(),
          )
        : _buildSwitchWidget();
  }

  _buildSwitchWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Switch(
        value: value ?? false,
        inactiveTrackColor: ColorConstant.blueGray100,
        activeTrackColor: ColorConstant.blueGray100,
        inactiveThumbColor: ColorConstant.whiteA700,
        activeColor: ColorConstant.whiteA700,
        onChanged: (value) {
          onChanged!(value);
        },
      ),
    );
  }
}
