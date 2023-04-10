
import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';


class Processing extends StatelessWidget {
  final double width;
  final double height;
  const Processing({Key? key, required this.width, required this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.black54,
      child: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: SizedBox(
            width: 200,
            height: 180,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ThreeBounceLoading(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(S.of(context).processing),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
