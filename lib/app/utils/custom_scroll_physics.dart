import 'package:flutter/material.dart';
class CustomScrollStatus {
  bool leftEnd = false;
  bool rightEnd = false;
  bool isGoingLeft = false;
  bool isGoingRight = false;
}

class CustomScrollPhysics extends ScrollPhysics {
  final CustomScrollStatus status;

  const CustomScrollPhysics(
    this.status, {
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(status, parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    status.isGoingLeft = offset.sign < 0;
    return offset;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      //LogUtil.d('underscroll');
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
      //LogUtil.d('overscroll');
      return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
      //LogUtil.d('hit top edge');
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      //LogUtil.d('hit bottom edge');
      return value - position.maxScrollExtent;
    }

    if (status.leftEnd && !status.isGoingLeft) {
      return value - position.pixels;
    } else if (status.rightEnd && status.isGoingLeft) {
      return value - position.pixels;
    }
    return 0.0;
  }
}
