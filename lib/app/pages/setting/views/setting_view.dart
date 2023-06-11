import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(
      child: _buildBody(context),
    );
  }

  void _languageClick() {
    Get.toNamed(Routes.language);
  }

  void _verifiAccOnClick() {
    Get.toNamed(Routes.verifiAccount);
  }

  void _changePassClick() {
    Get.toNamed(Routes.feedback);
  }

  void _notificationClick() {}
  void _deActiveClick() {}
  void _helpCenterClick() {}
  void _aboutClick() {}
  void _transactionHistory() {
    Get.toNamed(Routes.transactionHistory);
  }

  void _logoutClick() {
    showConfirmLogout(Get.context!);
  }

  void _confirmLogout() {
    controller.logoutUser();
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 30, right: 30),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                            width: 2.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S
                                .of(context)
                                .hi(controller.userModel?.nameUser ?? ""),
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
                  SvgPicture.asset(
                    AssetsConst.icEdit,
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () => controller.isLoading
                    ? controller.isVerified
                        ? const SizedBox()
                        : Center(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.isProccesingVerify == true
                                    ? null
                                    : _verifiAccOnClick();
                              },
                              style: controller.isProccesingVerify
                                  ? FilledBtnStyle.disable(
                                      isFullWidth: true,
                                      borderRadius: 15,
                                    )
                                  : FilledBtnStyle.enable(
                                      isFullWidth: true,
                                      borderRadius: 15,
                                    ),
                              child: Text(
                                controller.isProccesingVerify
                                    ? S.of(context).proccessingVerify
                                    : S.of(context).verifiAcc,
                                style: AppTextStyles.body1().copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                    : ThreeBounceLoading(),
              ),
              Container(
                height: 0.3,
                color: AppColors.grey.shade300,
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
              _contentWidget(
                context,
                S.of(context).language,
                AssetsConst.icLanguage,
                _languageClick,
              ),
              _contentWidget(
                context,
                S.of(context).historyTransaction,
                AssetsConst.icChangPass,
                _transactionHistory,
              ),
              _contentWidget(
                context,
                S.of(context).changePass,
                AssetsConst.icChangPass,
                _changePassClick,
              ),
              _contentWidget(
                context,
                S.of(context).notifi,
                AssetsConst.icNotifi,
                _notificationClick,
              ),
              _contentWidget(
                context,
                S.of(context).deactiveAcc,
                AssetsConst.icDeative,
                _deActiveClick,
              ),
              _contentWidget(
                context,
                S.of(context).helpCenter,
                AssetsConst.icHelp,
                _helpCenterClick,
              ),
              _contentWidget(
                context,
                S.of(context).about,
                AssetsConst.icAbout,
                _aboutClick,
              ),
              _contentWidget(
                context,
                S.of(context).logout,
                AssetsConst.icLogout,
                _logoutClick,
                logout: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentWidget(
      BuildContext context, String title, String icon, void Function()? handle,
      {bool logout = false}) {
    return GestureDetector(
      onTap: () {
        handle?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color:
              !logout ? const Color(0xfff5f5f5) : AppColors.defaultBackground,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 25,
                    ),
                    const SizedBox(width: 20.0),
                    Text(
                      title,
                      style: AppTextStyles.tiny().copyWith(
                        color: logout
                            ? AppColors.warning.shade400
                            : AppColors.grey.shade500,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !logout,
                  child: const Icon(
                    Icons.navigate_next,
                    color: Color(0xff28303f),
                    size: 30,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showConfirmLogout(BuildContext context) async {
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
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.35,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).logout,
                      style: AppTextStyles.heading1().copyWith(
                        color: AppColors.warning.shade300,
                      ),
                    ),
                    const SizedBox(width: 20),
                    SvgPicture.asset(
                      AssetsConst.icLogout,
                      height: 30,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  S.of(context).questionLogout,
                  style: AppTextStyles.heading2().copyWith(
                    color: AppColors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).cancel,
                              style: AppTextStyles.body1().copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _confirmLogout();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.main.shade300,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).confirmLogout,
                              style: AppTextStyles.body1().copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
