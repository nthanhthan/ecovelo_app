import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StationNearView extends GetView<HomeController> {
  const StationNearView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void stationNear(StationModel stationModel) {
    controller.stationNearMe(stationModel);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AssetsConst.leftArrow,
          ),
        ),
        elevation: 0.0,
        title: Text(
          S.of(context).stationNearMe,
          style: AppTextStyles.subLead().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.grey.shade700,
          ),
        ),
        backgroundColor: AppColors.defaultBackground,
      ),
      body: Obx(
        () => controller.listStation.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: controller.listStation
                      .asMap()
                      .entries
                      .map(
                        (e) =>
                            _staionItem(context, controller.listStation[e.key]),
                      )
                      .toList(),
                ),
              )
            : ThreeBounceLoading(),
      ),
    );
  }

  Widget _staionItem(BuildContext contex, StationModel stationModel) {
    return GestureDetector(
      onTap: () {
        stationNear(stationModel);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.grey.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              AssetsConst.bikeStation,
              height: 40,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "ECO_STATION ${stationModel.id} \n${stationModel.address}",
                style: AppTextStyles.body1().copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.main.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    AssetsConst.iconDistanceGreen,
                    height: 30,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "100 m",
                  style: AppTextStyles.body2().copyWith(color: AppColors.main),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
