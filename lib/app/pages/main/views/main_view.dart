import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}
