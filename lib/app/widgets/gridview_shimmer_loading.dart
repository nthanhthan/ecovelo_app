import 'package:flutter/material.dart';

import '../core.dart';

class GridViewShimmerLoading extends StatelessWidget {
  const GridViewShimmerLoading({
    Key? key,
    this.numOfRow = 3,
    this.itemCount,
    this.numOfCol = 6,
    this.space = 2,
    this.verticalPading = 2,
    this.horizontalPading = 2,
    this.borderRadius = 0,
    this.childItem,
    this.scrollPhysics = const BouncingScrollPhysics(),
  }) : super(key: key);
  final int numOfRow;
  final int? itemCount;
  final int numOfCol;
  final double space;
  final double borderRadius;
  final double verticalPading;
  final double horizontalPading;
  final Widget? childItem;
  final ScrollPhysics? scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      verticalPading: verticalPading,
      horizontalPading: horizontalPading,
      shimmerWidget: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numOfRow,
          mainAxisSpacing: space / 2,
          crossAxisSpacing: space / 2,
        ),
        physics: scrollPhysics,
        itemCount: itemCount ?? numOfRow * numOfCol,
        itemBuilder: (context, index) {
          return childItem ??
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: Colors.white,
                ),
              );
        },
      ),
    );
  }
}
