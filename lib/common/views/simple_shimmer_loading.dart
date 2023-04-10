import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SimpleShimmerLoading extends StatelessWidget {
  const SimpleShimmerLoading({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: child,
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!);
  }
}
