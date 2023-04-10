import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final Axis direction;
  final double value;
  const Space({Key? key, this.direction = Axis.vertical, this.value = 8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: direction == Axis.horizontal ? value : 0,
      height: direction == Axis.vertical ? value : 0,
    );
  }
}
