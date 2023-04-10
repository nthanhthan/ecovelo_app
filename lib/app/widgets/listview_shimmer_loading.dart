import 'package:flutter/material.dart';

import '../core.dart';

class ListViewShimmerLoading extends StatelessWidget {
  const ListViewShimmerLoading({
    Key? key,
    this.itemCount = 10,
    this.space = 2,
    this.verticalPading = 2,
    this.horizontalPading = 2,
    this.borderRadius = 0,
    this.childItem,
    this.scrollPhysics = const BouncingScrollPhysics(),
  }) : super(key: key);
  final int itemCount;
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
      shimmerWidget: ListView.separated(
        itemCount: itemCount,
        physics: scrollPhysics,
        itemBuilder: (ct, idx) {
          return childItem ??
              ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 180,
                      color: Colors.grey,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    Container(
                      height: 20,
                      width: 140,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    Container(height: 20, color: Colors.grey),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    Container(height: 40, color: Colors.grey),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    Row(
                      children: [
                        Container(height: 30, width: 120, color: Colors.grey),
                        const Expanded(child: SizedBox()),
                        Container(height: 30, width: 120, color: Colors.grey),
                      ],
                    )
                  ],
                ),
              );
        },
        separatorBuilder: (ct, idx) => Padding(
          padding: EdgeInsets.symmetric(vertical: space),
        ),
      ),
    );
  }
}
