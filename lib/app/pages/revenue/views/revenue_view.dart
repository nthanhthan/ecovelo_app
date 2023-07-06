import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class RevenueView extends GetView<RevenueController> {
  const RevenueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _loadingRevenue() {
    controller.isLoading = true;
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).revenue,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              BarChartSample1(loadingRevenue: _loadingRevenue),
              Column(
                children: DefaultValues.listRevenues
                    .asMap()
                    .entries
                    .map(
                      (e) => revenueItem(
                        context,
                        DefaultValues.listRevenues[e.key],
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget revenueItem(BuildContext context, RevenueModel revenueModel) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(revenueModel.color ?? 0xff75CE5A),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        revenueModel.typeRevenue ?? "",
                        style: AppTextStyles.body1(),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: controller.isLoading,
                  child: Row(
                    children: [
                      revenueModel.isRaise == true
                          ? Icon(
                              Icons.arrow_upward_rounded,
                              color: Color(revenueModel.color ?? 0xff75CE5A),
                            )
                          : Icon(
                              Icons.arrow_downward_outlined,
                              color: Color(revenueModel.color ?? 0xff75CE5A),
                            ),
                      const SizedBox(width: 15),
                      const Icon(
                        Icons.navigate_next_rounded,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                )
              ],
            ),
            controller.isLoading
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      controller.parseMoney(revenueModel.money),
                      style: AppTextStyles.body1(),
                    ),
                  )
                : ThreeBounceLoading(),
          ],
        ),
      ),
    );
  }
}
