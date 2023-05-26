import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class JourneyView extends GetView<JourneyConroller> {
  const JourneyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _viewDetailClick(DetailJouneyModel detailJouneyModel) {
    Get.toNamed(
      Routes.journeyDetail,
      arguments: detailJouneyModel,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.defaultBackground,
        title: Text(
          S.of(context).myJourney,
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.colorText,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Color(0xff28303f),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          _topWiget(context),
          _gridAnalysis(context),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                S.of(context).recentActivities,
                style: AppTextStyles.body2().copyWith(
                  color: AppColors.grey.shade500,
                ),
              ),
            ),
          ),
          _recentActivities(context),
          _recentActivities(context),
          _recentActivities(context),
        ],
      )),
    );
  }

  Widget _gridAnalysis(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => _itemAnalysis(
                    context,
                    AssetsConst.iconDistanceGreen,
                    S.of(context).totalDistances,
                    controller.totalDistance.toStringAsFixed(1),
                    "km",
                  ),
                ),
                Obx(
                  () => _itemAnalysis(
                    context,
                    AssetsConst.iconClock,
                    S.of(context).totalTime,
                    (controller.totalTime / 60).toStringAsFixed(1),
                    "minutes",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => _itemAnalysis(
                    context,
                    AssetsConst.iconCarbon,
                    S.of(context).carbon,
                    controller.totalCardbon.toStringAsFixed(1),
                    "kg",
                  ),
                ),
                Obx(
                  () => _itemAnalysis(
                    context,
                    AssetsConst.iconEnrgy,
                    S.of(context).energy,
                    controller.totalEnergy.toStringAsFixed(1),
                    "kcal",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _topWiget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.main.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AssetsConst.iconDistance),
                    const SizedBox(width: 10),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: S.of(context).distances,
                            style: AppTextStyles.body1().copyWith(
                              color: AppColors.main.shade400,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: S.of(context).numDistances("10km"),
                            style: AppTextStyles.body1()
                                .copyWith(color: AppColors.main.shade400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  S.of(context).titleWeekPoint,
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.main.shade400,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  S.of(context).desWeekPoint,
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.grey.shade300,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          _percentWidget(context),
        ],
      ),
    );
  }

  Widget _itemAnalysis(
    BuildContext context,
    String icon,
    String text,
    String number,
    String unit,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        onPressed: null,
        style: OutlineButtonStyle.enable(
          sizeType: SizeButtonType.custom,
          customPadding: const EdgeInsets.fromLTRB(12, 15, 5, 15),
          outlineColor: AppColors.grey.shade100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.main.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(icon),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.tiny().copyWith(
                      color: AppColors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        number,
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.main.shade200),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        unit,
                        style: AppTextStyles.tiny().copyWith(
                          color: AppColors.grey.shade300,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recentActivities(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Obx(
        () => controller.isLoading
            ? controller.historyGroupDay != null
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.historyGroupDay?.length,
                    itemBuilder: (context, index) {
                      final date =
                          controller.historyGroupDay?.keys.elementAt(index);
                      final listHistories = controller.historyGroupDay?[date];
                      return _historyByDay(
                        context,
                        date,
                        listHistories,
                      );
                    })
                : const SizedBox()
            : ThreeBounceLoading(),
      ),
    );
  }

  Widget _historyByDay(
    BuildContext context,
    DateTime? time,
    List<DetailJouneyModel>? listHistories,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat("MMM dd, yyyy").format(time!),
          style: AppTextStyles.body2().copyWith(
              color: AppColors.grey.shade500, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Column(
          children: listHistories!
              .asMap()
              .entries
              .map(
                (e) => _recentActivity(
                  context,
                  listHistories[e.key],
                ),
              )
              .toList(),
        )
      ],
    );
  }

  Widget _recentActivity(
    BuildContext context,
    DetailJouneyModel detailJouneyModel,
  ) {
    DateTime beginTime = DateTime.fromMillisecondsSinceEpoch(
        detailJouneyModel.beginTimeRent ?? 0);
    DateTime endTime =
        DateTime.fromMillisecondsSinceEpoch(detailJouneyModel.endTimeRent ?? 0);
    String begin =
        "${beginTime.hour}:${beginTime.minute} - ${endTime.hour}:${endTime.minute}";
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: OutlinedButton(
        onPressed: () {
          _viewDetailClick(detailJouneyModel);
        },
        style: OutlineButtonStyle.enable(
          sizeType: SizeButtonType.custom,
          outlineColor: AppColors.grey.shade100,
          customPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  begin,
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.main.shade200,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      S.of(context).detail,
                      style: AppTextStyles.tiny()
                          .copyWith(color: AppColors.main.shade200),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.chevron_right,
                      color: AppColors.main.shade200,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Color(0xFFF5F5F5),
                      width: 1.0,
                      style: BorderStyle.solid),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _itemActivites(
                    context,
                    AssetsConst.iconDistanceGreen,
                    S.of(context).totalDistances,
                    detailJouneyModel.distance?.toStringAsFixed(1) ?? "0",
                    "km",
                  ),
                  _itemActivites(
                    context,
                    AssetsConst.iconClock,
                    S.of(context).totalTime,
                    (detailJouneyModel.totalTime! / 60).toStringAsFixed(1),
                    "minutes",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemActivites(
    BuildContext context,
    String icon,
    String text,
    String number,
    String unit,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.main.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(icon),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: AppTextStyles.tiny().copyWith(
                color: AppColors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  number,
                  style: AppTextStyles.body1()
                      .copyWith(color: AppColors.main.shade200),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: AppTextStyles.tiny().copyWith(
                    color: AppColors.grey.shade300,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Widget _percentWidget(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      lineWidth: 13.0,
      animation: true,
      percent: 0.5,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "25/50",
            style:
                AppTextStyles.body1().copyWith(color: AppColors.main.shade400),
          ),
          Text(
            "pts",
            style: AppTextStyles.tiny().copyWith(
              color: AppColors.grey.shade300,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.secondary.shade100.withOpacity(0.2),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppColors.secondary.shade300,
    );
  }
}
