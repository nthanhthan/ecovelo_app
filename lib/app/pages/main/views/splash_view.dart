import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(maxWidth * .2),
              child: SimpleShadow(
                  opacity: 0.6,
                  color: AppColors.main.shade300,
                  offset: const Offset(0, 0),
                  sigma: 12,
                  child: Image.asset(AssetsConst.ecoveloSplash)),
            ),
          ),
        ],
      ),
    );
  }
}
