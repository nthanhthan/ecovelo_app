import 'package:flutter/material.dart';

class DisableAccessibility extends StatelessWidget {
  const DisableAccessibility({
    Key? key,
    required this.child,
    this.defaultTextScaleFactor = 1.0,
    this.isDisableBold = false,
  }) : super(key: key);
  final Widget child;
  final double defaultTextScaleFactor;
  final bool isDisableBold;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      child: child,
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: defaultTextScaleFactor,
        boldText: isDisableBold,
      ),
    );
  }
}

class LimitedScaleFactor extends StatelessWidget {
  const LimitedScaleFactor({
    Key? key,
    required this.child,
    this.defaulScaleFactorLimit = 1.26,
    this.isDisableBold = false,
  }) : super(key: key);
  final Widget child;
  final double defaulScaleFactorLimit;
  final bool isDisableBold;

  @override
  Widget build(BuildContext context) {
    double scaleFactor = MediaQuery.textScaleFactorOf(context);
    if (scaleFactor > defaulScaleFactorLimit) {
      scaleFactor = defaulScaleFactorLimit;
    }
    return MediaQuery(
      child: child,
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: scaleFactor,
        boldText: isDisableBold,
      ),
    );
  }
}
