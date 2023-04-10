import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ShimmerLoading extends StatelessWidget {
  final Widget? shimmerWidget;
  double verticalPading;
  double horizontalPading;

  ShimmerLoading({Key? key, this.shimmerWidget, this.verticalPading = 0.0, this.horizontalPading = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double lineHeight = 18.0;
    const double lineSpace = 3.5;
    double safeHOffset = MediaQuery.of(context).padding.top + MediaQuery.of(context).padding.bottom;
    double safeHeight = MediaQuery.of(context).size.height - safeHOffset;
    if (shimmerWidget == null) verticalPading = 5;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPading, vertical: verticalPading),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: true,
              child: shimmerWidget ??
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: lineHeight,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: lineSpace),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: lineHeight,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: lineSpace),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: lineHeight,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: lineSpace),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: lineHeight,
                                  color: Colors.white,
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: lineSpace),
                                ),
                                Container(
                                  width: 60.0,
                                  height: lineHeight,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //
                    itemCount: (safeHeight / 130).round(),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
