import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class ThreeBounceLoading extends StatelessWidget {
  Color? color;
  double size;

  ThreeBounceLoading({
    Key? key,
    this.color,
    this.size = 26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    color ??= Theme.of(context).primaryColor;
    return SpinKitThreeBounce(color: color, size: size);
  }
}
