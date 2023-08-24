import 'package:flutter/material.dart';

class ResponsiveLayer extends StatelessWidget {
  final Widget isMobileLayout;
  final Widget isWebLayout;

  const ResponsiveLayer(
      {super.key, required this.isMobileLayout, required this.isWebLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth > 900){
          return isWebLayout;
        }
        return isMobileLayout;
      },
    );
  }
}
