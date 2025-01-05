import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLayout;
  final Widget tabletLayout;

  const ResponsiveLayout({
    super.key,
    required this.mobileLayout,
    required this.tabletLayout,
  });

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    double screenWidth = MediaQuery.of(context).size.width;

    // For smaller screens, use mobileLayout
    if (screenWidth <= 600 || orientation == Orientation.portrait) {
      return mobileLayout;
    }

    // For larger screens (like tablets or landscape mode), use tabletLayout
    return tabletLayout;
  }
}
