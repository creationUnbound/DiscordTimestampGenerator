import 'package:flutter/material.dart';

class MediaAwareSize {
  BuildContext context;
  double lowerBound;
  double sizeFactor;
  double defaultSize;

  MediaAwareSize(
      this.context, this.lowerBound, this.sizeFactor, this.defaultSize);

  double get size => MediaQuery.of(context).size.width > lowerBound
      ? MediaQuery.of(context).size.width * sizeFactor
      : defaultSize;
}
