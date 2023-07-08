import 'dart:async';

import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

class LoadingAnswer {
  BuildContext? dialogContext;
  final List<String> _logoHome = [
    AssetsConst.robot1,
    AssetsConst.robot2,
    AssetsConst.robot3,
    AssetsConst.robot4,
    AssetsConst.robot5,
    AssetsConst.robot6,
    AssetsConst.robot7,
    AssetsConst.robot8,
  ];
  final RxInt _indexLogo = 0.obs;
  set indexLogo(int value) => _indexLogo.value = value;
  int get indexLogo => _indexLogo.value;

  Timer? _autoNextRobot;

  List<String> get logoHome => _logoHome;
  int getLogoHome(int index) {
    if (index < 0 || index >= logoHome.length) {
      return 0;
    }
    return index;
  }

  void _autoNextLogo() {
    _autoNextRobot?.cancel();
    _autoNextRobot = Timer.periodic(const Duration(seconds: 1), (timer) {
      indexLogo = getLogoHome(indexLogo += 1);
    });
  }

  void showLoadingAnswer() {
    _autoNextLogo();
    showDialog<void>(
      context: Get.context!,
      builder: (context) {
        dialogContext = context;
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppProperties.circleRadius),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: Obx(
                () => SimpleShadow(
                  opacity: 0.8,
                  color: AppColors.main.shade300,
                  offset: const Offset(0.5, 0.5),
                  sigma: 12,
                  child: SvgPicture.asset(
                    logoHome[indexLogo],
                    height: 160,
                    width: 160,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    Navigator.of(dialogContext!).pop();
  }
}
