import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  MediaQueryData get device => MediaQuery.of(this);

  Size get deviceSize => MediaQuery.of(this).size;
}

extension MediaDimensionExtension on BuildContext {
  double mediaWidth(double size) {
    double value = 1 / MediaQuery.of(this).size.width;
    double result = value * size;
    return MediaQuery.of(this).size.width * result;
  }

  double mediaHeight(double size) {
    double value = 1 / MediaQuery.of(this).size.height;
    double result = value * size;
    return MediaQuery.of(this).size.height * result;
  }
}
