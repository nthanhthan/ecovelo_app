import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({Key? key}) : super(key: key);
  void _skipOnClicked() {
  }

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.defaultBackground,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 30, top: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    AssetsConst.flagUS,
                    height: 25,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                children: [
                  _onboardingMain(
                    context,
                    AssetsConst.onboarding1,
                    S.of(context).onBoarding1Title,
                    S.of(context).onBoardingPage1Description,
                  ),
                  _onboardingMain(
                    context,
                    AssetsConst.onboarding2,
                    S.of(context).onBoarding2Title,
                    S.of(context).onBoardingPage2Description,
                  ),
                  _onboardingMain(
                    context,
                    AssetsConst.onboarding2,
                    S.of(context).onBoarding3Title,
                    S.of(context).onBoardingPage3Description,
                  ),
                ],
                onPageChanged: (int index) {
                  controller.onPageChange(index);
                },
              ),
            ),
            _bottomIndicator(context),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: _bottomButton(context),
            ),
          ],
        ));
  }

  Widget _bottomIndicator(BuildContext context) {
    return Container(
      width: Get.width,
      height: 30,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppProperties.bottomSheetRadius),
          topRight: Radius.circular(AppProperties.bottomSheetRadius),
        ),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmoothPageIndicator(
            controller: controller.pageController,
            count: 3,
            effect: WormEffect(
              dotWidth: 12,
              dotHeight: 12,
              paintStyle: PaintingStyle.stroke,
              activeDotColor: AppColors.main.shade200,
              dotColor: AppColors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _onboardingMain(
    BuildContext context,
    String path,
    String title,
    String description,
  ) {
    return Column(
      children: [
        SvgPicture.asset(path),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
          child: Text(
            title,
            style: AppTextStyles.largeHeading2().copyWith(
              color: AppColors.main.shade200,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Text(
              description,
              style: AppTextStyles.body2().copyWith(
                color: AppColors.main.shade300,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.visible,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bottomButton(BuildContext context) {
    return AnimatedSwitcher(
      duration:
          const Duration(milliseconds: AppProperties.defaultTransitionDuration),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlineButtonStyle.enable(),
              onPressed: _skipOnClicked,
              child: Text(
                S.of(context).skip,
                style: AppTextStyles.body1().copyWith(
                  color: AppColors.main.shade200,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: ElevatedButton(
              style: FilledBtnStyle.enable(
                sizeType: SizeButtonType.custom,
                borderRadius: 16,
              ),
              onPressed: () {
                controller.onNextPage();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).next,
                    style: AppTextStyles.body1().copyWith(
                      color: AppColors.main.shade400,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: AppColors.main.shade400,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
