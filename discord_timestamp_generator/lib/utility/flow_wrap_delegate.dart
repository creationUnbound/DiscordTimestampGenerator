import 'package:flutter/material.dart';

class FlowWrapDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; ++i) {
      context.paintChild(i);
    }
  }

  @override
  bool shouldRepaint(FlowWrapDelegate oldDelegate) {
    // false just for now
    return false;
  }
}
