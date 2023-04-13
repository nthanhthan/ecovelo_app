import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:action_slider/action_slider.dart';

class RentBicycleView extends GetView<RentBicycleController> {
  const RentBicycleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(child: _buildBody(context));
  }

  void _oneTimeTicketClick() {}
  void _selectVoucherClick() {}
  void _introductionClick() {}
  void _needHelpClick() {}
  void _mainWalletClick() {
    controller.changeWallet();
  }

  void _promoWalletClick() {
    controller.changeWallet();
  }

  Future<void> _startClick() async {
    controller.startRent();
    await Future.delayed(const Duration(seconds: 1));
    Get.back();
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white38,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsConst.rentBicycle),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 210, 20, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "ECO43-001",
                            style: AppTextStyles.subHeading1()
                                .copyWith(color: AppColors.main.shade200),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AssetsConst.checkRent,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              S.of(context).readyRide,
                              style: AppTextStyles.tiny().copyWith(
                                color: AppColors.main.shade200,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SvgPicture.asset(AssetsConst.divider),
                        ),
                        _optionWigdet(
                          context,
                          AssetsConst.iconTicket,
                          S.of(context).oneTimeTicket,
                          S.of(context).ticketType,
                          _oneTimeTicketClick,
                          true,
                        ),
                        _optionWigdet(
                          context,
                          AssetsConst.iconDiscount,
                          S.of(context).selectVoucher,
                          S.of(context).discoutText,
                          _selectVoucherClick,
                          false,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 70),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _itemTextBottom(
                                context,
                                AssetsConst.iconIntroduction,
                                S.of(context).introduction,
                                _introductionClick,
                              ),
                              _itemTextBottom(
                                context,
                                AssetsConst.iconHELP,
                                S.of(context).needHelp,
                                _needHelpClick,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 60, 60, 0),
                    child: Image.asset(
                      AssetsConst.ecovelo,
                      height: 260,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 25,
                    child: Row(
                      children: [
                        _walletWidget(
                          context,
                          AssetsConst.mainWallet,
                          S.of(context).mainWallet,
                          "20000",
                          true,
                          _mainWalletClick,
                        ),
                        _walletWidget(
                          context,
                          AssetsConst.promoWallet,
                          S.of(context).promoWallet,
                          "50000",
                          false,
                          _promoWalletClick,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 50,
                top: 20,
              ),
              child: _sliderWidget(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _optionWigdet(
    BuildContext context,
    String icon,
    String text,
    String title,
    void Function()? handle,
    bool isTicket,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: AppTextStyles.body2().copyWith(
              color: AppColors.grey.shade400,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:
                  isTicket ? AppColors.main.shade200 : AppColors.grey.shade100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(icon),
                  const SizedBox(width: 10),
                  Text(
                    text,
                    style: AppTextStyles.body1().copyWith(
                      color: isTicket
                          ? AppColors.main.shade400
                          : AppColors.grey.shade400,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: !isTicket,
                child: SvgPicture.asset(
                  AssetsConst.iconNext,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _itemTextBottom(
    BuildContext context,
    String icon,
    String text,
    void Function()? handle,
  ) {
    return Row(
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 10),
        Text(
          text,
          style: AppTextStyles.body2().copyWith(
            color: AppColors.main.shade200,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _walletWidget(
    BuildContext context,
    String icon,
    String text,
    String money,
    bool isMainWallet,
    void Function()? handle,
  ) {
    return GestureDetector(
      onTap: () {
        handle?.call();
      },
      child: Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          decoration: BoxDecoration(
            color: controller.isMainWallet == isMainWallet
                ? AppColors.main.shade200
                : AppColors.main.shade400,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              SvgPicture.asset(icon),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: AppTextStyles.small().copyWith(
                      color: controller.isMainWallet == isMainWallet
                          ? AppColors.main.shade400
                          : AppColors.grey.shade400,
                    ),
                  ),
                  Text(
                    money,
                    style: AppTextStyles.tiny().copyWith(
                      color: controller.isMainWallet == isMainWallet
                          ? AppColors.main.shade400
                          : AppColors.grey.shade400,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: controller.isMainWallet == isMainWallet
                        ? AppColors.main.shade400
                        : AppColors.main.shade200,
                    width: controller.isMainWallet == isMainWallet ? 5.0 : 1.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _sliderWidget(BuildContext context) {
    return ActionSlider.custom(
      sliderBehavior: SliderBehavior.stretch,
      width: 342.0,
      height: 56.0,
      toggleWidth: 65.0,
      toggleMargin: EdgeInsets.zero,
      backgroundColor: AppColors.main.shade200,
      foregroundChild: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.main.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: controller.isStart
                ? const Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 30,
                  )
                : SvgPicture.asset(AssetsConst.iconSlider),
          ),
        ),
      ),
      foregroundBuilder: (context, state, child) => child!,
      outerBackgroundBuilder: (context, state, child) => Card(
        margin: EdgeInsets.zero,
        color: Color.lerp(
          AppColors.main.shade400,
          AppColors.main.shade200,
          state.position,
        ),
        child: Center(
          child: Text(
            S.of(context).proceed,
            style: AppTextStyles.body1().copyWith(
              color: AppColors.main.shade200,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      backgroundBorderRadius: BorderRadius.circular(16.0),
      action: (controller) async {
        controller.loading();
        controller.success();
        _startClick();
      },
    );
  }
}