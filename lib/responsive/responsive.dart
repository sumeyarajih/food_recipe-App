import 'package:flutter/material.dart';

/// Responsive Utility Class
/// Provides helper methods for responsive design based on screen size
class Responsive {
  final BuildContext context;

  Responsive(this.context);

  /// Get screen width
  double get width => MediaQuery.of(context).size.width;

  /// Get screen height
  double get height => MediaQuery.of(context).size.height;

  /// Check if device is mobile (width < 600)
  bool get isMobile => width < 600;

  /// Check if device is tablet (600 <= width < 900)
  bool get isTablet => width >= 600 && width < 900;

  /// Check if device is desktop (width >= 900)
  bool get isDesktop => width >= 900;

  /// Get responsive value based on screen size
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  /// Get responsive font size
  double fontSize(double size) {
    if (isMobile) return size;
    if (isTablet) return size * 1.1;
    return size * 1.2;
  }

  /// Get responsive padding
  double padding(double size) {
    if (isMobile) return size;
    if (isTablet) return size * 1.2;
    return size * 1.5;
  }

  /// Get responsive margin
  double margin(double size) {
    if (isMobile) return size;
    if (isTablet) return size * 1.2;
    return size * 1.5;
  }

  /// Get responsive icon size
  double iconSize(double size) {
    if (isMobile) return size;
    if (isTablet) return size * 1.15;
    return size * 1.3;
  }

  /// Get responsive spacing
  double spacing(double size) {
    if (isMobile) return size;
    if (isTablet) return size * 1.1;
    return size * 1.2;
  }

  /// Static method to get responsive value without context
  static T valueByScreen<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900 && desktop != null) return desktop;
    if (width >= 600 && tablet != null) return tablet;
    return mobile;
  }

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => MediaQuery.of(context).padding;

  /// Get bottom safe area (for notch/home indicator)
  double get bottomSafeArea => MediaQuery.of(context).padding.bottom;

  /// Get top safe area (for status bar)
  double get topSafeArea => MediaQuery.of(context).padding.top;
}

/// Extension on BuildContext for easy access to Responsive
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
  
  bool get isMobile => Responsive(this).isMobile;
  bool get isTablet => Responsive(this).isTablet;
  bool get isDesktop => Responsive(this).isDesktop;
}
