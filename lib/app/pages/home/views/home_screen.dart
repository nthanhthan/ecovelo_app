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

  void _ecoVeloClicked() {
    Get.toNamed(Routes.rentBicycle);
  }

  void _addMoneyClicked() {}
  void _myWalletClick() {}
  void _myJourneyClicked() {}

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _topBanner(context),
            _animationHome(context),
            _mainContentWiget(context),
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
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AssetsConst.avatar),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
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
                    Text(
                      S.of(context).hi("Than"),
                      style: AppTextStyles.subHeading1()
                          .copyWith(color: AppColors.main.shade300),
                    ),
                    Text(
                      S.of(context).niceDay,
                      style: AppTextStyles.tiny()
                          .copyWith(color: AppColors.main.shade300),
                    )
                  ],
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
                _itemWallet(
                  context,
                  S.of(context).mainWallet,
                  "250000",
                ),
                _itemWallet(
                  context,
                  S.of(context).promoWallet,
                  "20000",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemWallet(BuildContext context, String nameWallet, String money) {
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
        )
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
            _itemMain(
              context,
              S.of(context).ecoitem,
              AssetsConst.icEcovelo,
              _ecoVeloClicked,
            ),
            _itemMain(
              context,
              S.of(context).addMoney,
              AssetsConst.addMoney,
              _addMoneyClicked,
            ),
            _itemMain(
              context,
              S.of(context).myWallet,
              AssetsConst.myWallet,
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
}
