import 'package:flutter/material.dart';

//TODO: Unused as of now
class FlowWrapDelegate extends FlowDelegate {
  final Animation<double> flowAnimation;

  FlowWrapDelegate({required this.flowAnimation})
      : super(repaint: flowAnimation);

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
