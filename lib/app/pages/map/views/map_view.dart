import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class MapView extends GetView<MapController> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LimitedScaleFactor(
      child: Center(child: Text("home 2")),
    );
  }
}
