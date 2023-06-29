import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewStationView extends GetView<NewStationController> {
  const NewStationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _builBody(context);
  }

  void _stationRecommendClick(NewStationModel stationModel) {
    controller.createMarkers(stationModel);
  }

  void _updateAIClick() {
    controller.newJourney = 0;
    controller.addNewStation();
  }

  Widget _builBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).analysisStation,
          style: AppTextStyles.heading1().copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.grey.shade100,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Obx(
            () => controller.isLoading
                ? Column(
                    children: [
                      _newJourney(context),
                      const SizedBox(height: 20),
                      _analysisItem(context),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget _analysisItem(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommended Eco Station",
                style: AppTextStyles.subHeading1(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    AssetsConst.bikeStation,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Last Update:",
                style:
                    AppTextStyles.small().copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(width: 10),
              Obx(
                () => Text(
                  controller.lastUpdateAI,
                  style: AppTextStyles.small()
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Column(
            children: controller.newListStation
                .asMap()
                .entries
                .map(
                  (e) => _newStationItem(
                      context, controller.newListStation[e.key], e.key + 1),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _newStationItem(
      BuildContext context, NewStationModel statioModel, int key) {
    return GestureDetector(
      onTap: () {
        _stationRecommendClick(statioModel);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey.shade600,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Eco Station $key",
                  style: AppTextStyles.body1(),
                ),
                Row(
                  children: [
                    Text(
                      "View Map",
                      style: AppTextStyles.body2().copyWith(
                          color: AppColors.grey, fontWeight: FontWeight.w500),
                    ),
                    const Icon(
                      Icons.navigate_next_sharp,
                      color: AppColors.main,
                      size: 25,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppColors.main,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    statioModel.stationModel?.address ?? "",
                    style: AppTextStyles.body2().copyWith(
                      color: AppColors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _serviceItem(
                      context, statioModel.serviceStationModel?.restaurant),
                ),
                Expanded(
                  child: _serviceItem(
                      context, statioModel.serviceStationModel?.hotel),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _serviceItem(
                      context, statioModel.serviceStationModel?.busStation),
                ),
                Expanded(
                  child: _serviceItem(
                      context, statioModel.serviceStationModel?.school),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _serviceItem(BuildContext context, ServiceItem? serviceItem) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            serviceItem?.url ?? "",
            height: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Text(
                  serviceItem?.name ?? "",
                  style: AppTextStyles.body1(),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  serviceItem?.num.toString() ?? "",
                  style: AppTextStyles.body1(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _newJourney(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AssetsConst.journey),
                  const SizedBox(width: 10),
                  Text(
                    "New Journey: ${controller.newJourney}",
                    style:
                        AppTextStyles.body1().copyWith(color: AppColors.main),
                  ),
                ],
              ),
              ElevatedButton(
                style: controller.newJourney != 0
                    ? FilledBtnStyle.enable(borderRadius: 18)
                    : FilledBtnStyle.disable(borderRadius: 18),
                onPressed: () {
                  if (controller.newJourney != 0) {
                    _updateAIClick();
                  }
                },
                child: Text(
                  "Update",
                  style: AppTextStyles.body1().copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
