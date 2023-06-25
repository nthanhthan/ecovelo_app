import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          S.of(context).historyTransaction,
          style: AppTextStyles.subLead().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.grey.shade700,
          ),
        ),
        backgroundColor: AppColors.defaultBackground,
      ),
      body: SingleChildScrollView(
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
              : Padding(
                  padding: const EdgeInsets.all(100),
                  child: ThreeBounceLoading(),
                ),
        ),
      ),
    );
  }

  Widget _historyByDay(
      BuildContext context, DateTime? time, List<HistoryModel>? listHistories) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 25,
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.grey.shade600),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat("MMM dd, yyyy").format(time!),
            style: AppTextStyles.body1().copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 20),
          Column(
            children: listHistories!.asMap().entries.map((e) {
              return _transferDetail(
                context,
                listHistories[e.key],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _transferDetail(BuildContext context, HistoryModel historyModel) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
        historyModel.dateTimeTransaction ?? 0);
    String datetime = "${date.hour} :${date.minute}";
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.grey.shade200.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8)),
            child: SvgPicture.asset(
              historyModel.ecovelo == true
                  ? AssetsConst.logoScanner
                  : AssetsConst.stripeIc,
              height: 25,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  historyModel.titleTransaction ?? "",
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      S.of(context).complete,
                      style: AppTextStyles.tiny()
                          .copyWith(color: AppColors.grey.shade300),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: AppColors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      datetime,
                      style: AppTextStyles.tiny()
                          .copyWith(color: AppColors.grey.shade300),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            (historyModel.ecovelo == true ? "-" : "+") +
                NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                    .format(historyModel.point ?? 0),
            style: AppTextStyles.body2().copyWith(
              color: historyModel.ecovelo == true
                  ? AppColors.warning
                  : AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
