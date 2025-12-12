import 'package:flutter/material.dart';

/// String extensions
extension StringExtension on String {
  /// Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
  
  /// Check if string is email
  bool isEmail() {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(this);
  }
}

/// Widget extensions
extension WidgetExtension on Widget {
  /// Wrap widget with padding
  Widget withPadding(EdgeInsets padding) {
    return Padding(padding: padding, child: this);
  }
  
  /// Wrap widget with center
  Widget withCenter() {
    return Center(child: this);
  }
}

/// Duration extensions
extension DurationExtension on int {
  /// Convert to duration
  Duration get ms => Duration(milliseconds: this);
  
  Duration get seconds => Duration(seconds: this);
}

/// Num extensions
extension NumExtension on num {
  /// Convert to SizedBox (width and height)
  SizedBox get box => SizedBox(width: toDouble(), height: toDouble());
  
  /// Horizontal SizedBox
  SizedBox get hBox => SizedBox(width: toDouble());
  
  /// Vertical SizedBox
  SizedBox get vBox => SizedBox(height: toDouble());
}
