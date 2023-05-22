import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Scaffold(
      backgroundColor: AppColors.main.shade300,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(AssetsConst.line1Splash),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(AssetsConst.line2Splash),
          ),
          Positioned(
            bottom: 30,
            right: 0,
            child: SvgPicture.asset(AssetsConst.line3Splash),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SimpleShadow(
                  opacity: 0.6,
                  color: AppColors.main.shade300,
                  offset: const Offset(0, 0),
                  sigma: 12,
                  child: SvgPicture.asset(AssetsConst.logoSplash),
                ),
                const SizedBox(height: 10),
                SvgPicture.asset(AssetsConst.textSplash),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
