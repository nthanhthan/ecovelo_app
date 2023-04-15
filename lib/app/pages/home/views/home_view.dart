import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _scanClick() {
    Get.toNamed(Routes.scanQR);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.main.shade400,
        onPressed: _scanClick,
        child: Lottie.asset(AssetsConst.qrScan),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        shape: null,
        notchMargin: 10,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
              color: AppColors.main.shade200,
              borderRadius: BorderRadius.circular(24)),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _itemNavigatorBar(
                context,
                0,
                AssetsConst.homeEn,
                AssetsConst.homeDis,
              ),
              _itemNavigatorBar(
                context,
                1,
                AssetsConst.mapEn,
                AssetsConst.mapDis,
              ),
              _itemNavigatorBar(
                context,
                2,
                AssetsConst.notifiEn,
                AssetsConst.notifiDis,
              ),
              _itemNavigatorBar(
                context,
                3,
                AssetsConst.settingEn,
                AssetsConst.settingDis,
              )
            ],
          ),
        ),
      ),
      body: Obx(
        () => PageStorage(
          child: controller.getWidget(),
          bucket: controller.bucket,
        ),
      ),
    );
  }

  Widget _itemNavigatorBar(
      BuildContext context, int index, String iconEn, String iconDis) {
    return Obx(
      () => MaterialButton(
        shape: const CircleBorder(),
        color: controller.currentTab == index ? AppColors.main.shade400 : null,
        padding: const EdgeInsets.all(10),
        onPressed: () {
          controller.currentTab = index;
        },
        child:
            SvgPicture.asset(controller.currentTab == index ? iconEn : iconDis),
      ),
    );
  }
}
