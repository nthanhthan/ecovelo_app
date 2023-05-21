import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        child: Column(
          children: [
            _historyByDay(context),
            _historyByDay(context),
            _historyByDay(context),
          ],
        ),
      ),
    );
  }

  Widget _historyByDay(BuildContext context) {
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
            "Today - 01 May, 2023",
            style: AppTextStyles.body1().copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 20),
          _transferDetail(context),
          _transferDetail(context),
          _transferDetail(context),
          _transferDetail(context),
        ],
      ),
    );
  }

  Widget _transferDetail(BuildContext context) {
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
              AssetsConst.stripeIc,
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
                  "Transfer Money from Stripe",
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
                      "Completed",
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
                      "4:00 PM",
                      style: AppTextStyles.tiny()
                          .copyWith(color: AppColors.grey.shade300),
                    ),
                  ],
                )
              ],
            ),
          ),
          Text(
            "+10.0000",
            style: AppTextStyles.body2().copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
