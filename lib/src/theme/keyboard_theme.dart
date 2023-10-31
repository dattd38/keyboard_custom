import 'package:flutter/material.dart';

class KeyboardTheme {
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final Color? numColor;
  final TextStyle? displayStyle;
  final TextStyle? expressionStyle;
  final TextStyle? numStyle;
  final Color? operatorColor;
  final Color? commandColor;
  final TextStyle? operatorStyle;
  final TextStyle? commandStyle;

  KeyboardTheme({
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = 16,
    this.numColor,
    this.displayStyle,
    this.expressionStyle,
    this.numStyle,
    this.operatorColor,
    this.commandColor,
    this.operatorStyle,
    this.commandStyle,
  });
}
