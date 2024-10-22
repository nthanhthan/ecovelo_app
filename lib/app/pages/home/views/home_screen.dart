import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  Future<void> _ecoVeloClicked(BuildContext context) async {
    Get.toNamed(Routes.stationBike);
  }

  void _addMoneyClicked() {
    Get.toNamed(Routes.addMoney);
  }

  void _myWalletClick() {
    Get.toNamed(Routes.reportProblem);
  }

  void _myJourneyClicked() {
    Get.toNamed(Routes.journey);
  }

  void _openLockTemporary() {
    controller.openLockTemporary();
  }

  void _ecoUser() {
    Get.toNamed(Routes.ecoUser);
  }

  void _fixProblemClick() {
    Get.toNamed(Routes.fixProblem);
  }

  void _finishRideClick() async {
    notifyStopRent();
    // final RentHttpService _rentHttpService = Get.find<RentHttpService>();
    // ProcessingDialog processingDialog = ProcessingDialog.show();
    // int rentID = Prefs.getInt(AppKeys.rentID);
    // String bicycleID = Prefs.getString(AppKeys.bicycleIDRent);
    // final result = await _rentHttpService.stopRentBicycle(bicycleID, rentID);
    // if (result.isSuccess() && result.data != null) {
    //   // client.disconnect();
    //   processingDialog.hide();
    //   StopResponse? stopResponse = result.data;
    //   Prefs.removeKey(AppKeys.bicycleIDRent);
    //   Prefs.removeKey(AppKeys.beginRent);
    //   Prefs.removeKey(AppKeys.rentID);
    //   //return stopResponse;
    // }
    // processingDialog.hide();
    // // return null;
  }

  void _stationNearClicked() {
    controller.getStationNear();
    Get.toNamed(Routes.nearStation);
  }

  void _ecoStationOnClick() {
    Get.toNamed(Routes.ecoStation);
  }

  void _revenueOnClick() {
    Get.toNamed(Routes.revenueView);
  }

  void __stationAnalysis() {
    Get.toNamed(Routes.newStation);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _topBanner(context),
            _animationHome(context),
            _mainContentWiget(context),
            controller.isAdmin == true
                ? Column(
                    children: [
                      _adminWidget(context),
                      _stationAI(context),
                    ],
                  )
                : const SizedBox.shrink(),
            _voucherWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _topBanner(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(AssetsConst.topBanner),
        Positioned(
          top: 40,
          left: 20,
          right: 20,
          child: Row(
            children: [
              SimpleShadow(
                opacity: .8,
                color: Colors.white,
                offset: const Offset(.5, .5),
                sigma: 10,
                child: SpinKitPumpingHeart(
                  itemBuilder: (ct, int index) {
                    return SvgPicture.asset(
                      AssetsConst.gift,
                      height: 36,
                      width: 36,
                    );
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: S.of(context).textBanner,
                        style: AppTextStyles.tiny()
                            .copyWith(color: AppColors.main.shade400),
                      ),
                      TextSpan(
                        text: S.of(context).discout,
                        style: AppTextStyles.tiny().copyWith(
                          color: AppColors.secondary.shade300,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _animationHome(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.secondary.shade100),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(AssetsConst.avatarr),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40.0)),
                        border: Border.all(
                          color: AppColors.main.shade200,
                          width: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => controller.isLoading
                              ? Text(
                                  S
                                      .of(context)
                                      .hi(controller.userModel?.nameUser ?? ""),
                                  style: AppTextStyles.subHeading1()
                                      .copyWith(color: AppColors.main.shade300),
                                )
                              : ThreeBounceLoading(),
                        ),
                        Text(
                          S.of(context).niceDay,
                          style: AppTextStyles.tiny()
                              .copyWith(color: AppColors.main.shade300),
                        ),
                      ],
                    ),
                  ],
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isCloseBottomModel ??
                        controller.checkCloseBottomModel(),
                    child: Obx(
                      () => Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.checkCloseBottomModel() == true
                                  ? showBottomSheetRentBicycle(context)
                                  : null;
                            },
                            child: _durationRide(context),
                          ),
                          const SizedBox(width: 10),
                          controller.isLockTemporary
                              ? _lockTemporary(context)
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _walletWidget(context),
          Lottie.asset(AssetsConst.home),
        ],
      ),
    );
  }

  Widget _walletWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Stack(
        children: [
          Image.asset(AssetsConst.walletBanner),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => controller.isLoading
                      ? _itemWallet(
                          context,
                          S.of(context).mainWallet,
                          controller.userModel?.mainPoint?.toInt().toString() ??
                              "0",
                        )
                      : ThreeBounceLoading(color: AppColors.white),
                ),
                Obx(
                  () => controller.isLoading
                      ? _itemWallet(
                          context,
                          S.of(context).promoWallet,
                          controller.userModel?.proPoint?.toInt().toString() ??
                              "0",
                        )
                      : ThreeBounceLoading(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemWallet(
    BuildContext context,
    String nameWallet,
    String money,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          nameWallet,
          style: AppTextStyles.tiny().copyWith(
            color: AppColors.secondary.shade200,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          money,
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.main.shade400,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _mainContentWiget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _itemMain(context, S.of(context).ecoitem, AssetsConst.icEcovelo,
                () {
              _ecoVeloClicked(context);
            }),
            _itemMain(
              context,
              S.of(context).addMoney,
              AssetsConst.addMoney,
              _addMoneyClicked,
            ),
            _itemAdmin(
              context,
              S.of(context).reportProblem,
              AssetsConst.fixProblem,
              _myWalletClick,
            ),
            _itemMain(
              context,
              S.of(context).myJourney,
              AssetsConst.journey,
              _myJourneyClicked,
            ),
          ],
        ),
      ),
    );
  }

  Widget _adminWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _itemAdmin(
              context,
              S.of(context).accUser,
              AssetsConst.accUser,
              _ecoUser,
            ),
            _itemAdmin(
              context,
              S.of(context).fixProblem,
              AssetsConst.problemIC,
              _fixProblemClick,
            ),
            _itemAdmin(
              context,
              S.of(context).station,
              AssetsConst.stationIC,
              _ecoStationOnClick,
            ),
            _itemMain(
              context,
              S.of(context).revenue,
              AssetsConst.myWallet,
              _revenueOnClick,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemAdmin(
    BuildContext context,
    String name,
    String icon,
    void Function()? handle,
  ) {
    return GestureDetector(
      onTap: () {
        handle?.call();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.grey.shade600,
              borderRadius: BorderRadius.circular(19),
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  icon,
                  height: 30,
                  width: 30,
                  color: AppColors.main.shade200,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: AppTextStyles.tiny().copyWith(
              color: AppColors.main.shade200,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _itemMain(
    BuildContext context,
    String name,
    String icon,
    void Function()? handle,
  ) {
    return GestureDetector(
      onTap: () {
        handle?.call();
      },
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            height: 60,
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: AppTextStyles.tiny().copyWith(
              color: AppColors.main.shade200,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _voucherWidget(BuildContext context) {
    List<String> vouchers = [
      AssetsConst.voucher,
      AssetsConst.voucher,
      AssetsConst.voucher,
      AssetsConst.voucher,
      AssetsConst.voucher
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              S.of(context).ecoVoucher,
              style: AppTextStyles.subHeading1().copyWith(
                color: AppColors.main.shade300,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, int index) {
                  return SvgPicture.asset(vouchers[index]);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 0),
                itemCount: vouchers.length),
          )
        ],
      ),
    );
  }

  void showBottomSheetRentBicycle(BuildContext context) async {
    controller.updateCloseBottomModel(false);
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    bottom: 25,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.bikeID,
                                    style: AppTextStyles.subHeading1().copyWith(
                                        color: AppColors.main.shade200),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(width: 10),
                                  controller.isLockTemporary
                                      ? _lockTemporary(context)
                                      : Align(
                                          alignment: Alignment.topLeft,
                                          child: SvgPicture.asset(
                                            AssetsConst.checkRent,
                                            height: 20,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            _durationRide(context),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            AssetsConst.bicycle,
                            height: 90,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _bottomItemShowModel(
                          context,
                          AssetsConst.iconHELP,
                          S.of(context).getMoreTime,
                          _stationNearClicked,
                        ),
                      ),
                      Expanded(
                        child: _bottomItemShowModel(
                          context,
                          AssetsConst.iconAdd,
                          S.of(context).stationNearMe,
                          _stationNearClicked,
                        ),
                      ),
                    ],
                  ),
                ),
                _bottomWidget(context),
              ],
            ),
          ),
        );
      },
    );
    controller.updateCloseBottomModel(true);
  }

  Widget _durationRide(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.success.shade400,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Icon(
                  Icons.schedule,
                  color: AppColors.main.shade400,
                ),
              ),
            ),
            Obx(
              () => Text(
                controller.caculateTimer(),
                style: AppTextStyles.tiny().copyWith(
                  color: AppColors.main.shade400,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lockTemporary(BuildContext context) {
    return GestureDetector(
      onTap: _openLockTemporary,
      child: Container(
        width: 50,
        padding: const EdgeInsets.symmetric(
          vertical: 9,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondary.shade300,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.lock_outline,
              color: AppColors.main.shade400,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomItemShowModel(
    BuildContext context,
    String icon,
    String text,
    Function handle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: OutlinedButton(
        onPressed: () {
          handle.call();
        },
        style: OutlineButtonStyle.enable(
          sizeType: SizeButtonType.custom,
          customPadding: const EdgeInsets.fromLTRB(15, 15, 5, 15),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 5),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.main.shade200,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: ElevatedButton(
        onPressed: _finishRideClick,
        style: FilledBtnStyle.enable(
            isFullWidth: true,
            sizeType: SizeButtonType.custom,
            customPadding: const EdgeInsets.symmetric(vertical: 15)),
        child: Text(
          S.of(context).finishRide,
          style: AppTextStyles.body1().copyWith(
            color: AppColors.main.shade400,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void notifyStopRent() {
    showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      S.of(context).lockFirst,
                      style: AppTextStyles.body1().copyWith(
                        color: AppColors.main.shade200,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlineButtonStyle.enable(isFullWidth: true),
                      child: Text(
                        S.of(context).ok,
                        style: AppTextStyles.body2().copyWith(
                          color: AppColors.main.shade200,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _stationAI(BuildContext context) {
    return GestureDetector(
      onTap: __stationAnalysis,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.grey.shade600,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleShadow(
                opacity: 0.8,
                color: AppColors.main,
                offset: const Offset(.8, .8),
                sigma: 15,
                child: SpinKitPumpingHeart(
                  itemBuilder: (ct, int index) {
                    return Image.asset(
                      AssetsConst.ai,
                      height: 70,
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Text(
                S.of(context).newStation,
                style: AppTextStyles.body1().copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
