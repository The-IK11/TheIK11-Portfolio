import 'package:flutter/material.dart';

/// Responsive utility class for handling different screen sizes
class Responsive {
  // Breakpoints
  static const double mobileBreakpoint = 480;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1200;
  
  /// Check if screen is mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletBreakpoint;
  }
  
  /// Check if screen is tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }
  
  /// Check if screen is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }
  
  /// Get device width
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  /// Get device height
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  
  /// Get responsive width (percentage of screen)
  static double responsiveWidth(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }
  
  /// Get responsive height (percentage of screen)
  static double responsiveHeight(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }
  
  /// Get responsive font size
  static double responsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < tabletBreakpoint) {
      return baseSize * 0.85;
    } else if (width < desktopBreakpoint) {
      return baseSize * 0.95;
    }
    return baseSize;
  }
  
  /// Get responsive padding
  static double responsivePadding(BuildContext context, double basePadding) {
    final width = MediaQuery.of(context).size.width;
    if (width < tabletBreakpoint) {
      return basePadding * 0.6;
    } else if (width < desktopBreakpoint) {
      return basePadding * 0.8;
    }
    return basePadding;
  }
  
  /// Get max width for content
  static double getMaxContentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1600) {
      return 1400;
    } else if (width > 1200) {
      return 1100;
    } else if (width > 768) {
      return width * 0.9;
    }
    return width - 32;
  }
}
