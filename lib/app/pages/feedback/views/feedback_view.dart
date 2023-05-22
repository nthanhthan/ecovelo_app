import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class FeedBackView extends GetView<FeedbackController> {
  const FeedBackView({Key? key}) : super(key: key);

  _tapToShowFeedback() {
    controller.isShowFeedback = true;
  }

  _onSubmitFeedback() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(Routes.home);
          },
          icon: SvgPicture.asset(
            AssetsConst.leftArrow,
          ),
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 100),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Image.asset(
                AssetsConst.verifed,
                height: 180,
              ),
              Text(
                "The journey is complete!",
                style: AppTextStyles.heading1().copyWith(
                    color: AppColors.main[200], fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                "Thanks for being eco-conscious and choosing sustainable transportation.",
                style: AppTextStyles.body2().copyWith(
                    color: AppColors.grey[400], fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              (controller.bikeFallCount > 0)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bike Fall Count",
                          style: AppTextStyles.body2().copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey[500]),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${controller.bikeFallCount}" +
                                ((controller.bikeFallCount > 1)
                                    ? " times"
                                    : " time"),
                            style: AppTextStyles.heading2().copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.main[200]),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Please enter the reason why the bike fell",
                          style: AppTextStyles.body2().copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey[400]),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.grey[200] as Color,
                                width: 1,
                              )),
                          child: TextFormField(
                            maxLength: 100,
                            decoration: InputDecoration(
                              hintText: "Enter reason",
                              hintStyle: AppTextStyles.body2().copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.grey[300]),
                              fillColor: AppColors.white,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    )
                  : const SizedBox.shrink(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.main[200],
                    borderRadius: BorderRadius.circular(24)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Tell us your feedback 🙌",
                      style: AppTextStyles.subHeading1().copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 25),
                    RatingBar(
                      ratingWidget: RatingWidget(
                          full: SvgPicture.asset(AssetsConst.activeStar),
                          half: const SizedBox.shrink(),
                          empty: SvgPicture.asset(AssetsConst.deactiveStar)),
                      onRatingUpdate: (value) {
                        controller.star = value.toInt();
                      },
                      itemPadding: const EdgeInsets.symmetric(horizontal: 6),
                    ),
                    const SizedBox(height: 25),
                    GestureDetector(
                      onTap: _tapToShowFeedback,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Write something for us!",
                            style: AppTextStyles.body1().copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            AssetsConst.pointer,
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    Obx(() {
                      return (controller.isShowFeedback)
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(
                                  bottom: 0, left: 16, right: 16, top: 16),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.grey[200] as Color,
                                    width: 1,
                                  )),
                              child: TextFormField(
                                maxLength: 100,
                                decoration: InputDecoration(
                                  hintText: "Enter feedback",
                                  hintStyle: AppTextStyles.body2().copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey[300]),
                                  fillColor: AppColors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 24, right: 24),
        child: InkWell(
          onTap: _onSubmitFeedback,
          child: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                  color: AppColors.main.shade200,
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(
                  "Submit feedback",
                  style: AppTextStyles.body1().copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.main.shade400,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
