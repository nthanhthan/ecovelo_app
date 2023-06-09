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

  void _changePassClick() {}
  void _notificationClick() {}
  void _deActiveClick() {}
  void _helpCenterClick() {}
  void _aboutClick() {}
  void _transactionHistory() {
    Get.toNamed(Routes.transactionHistory);
  }

  void _logoutClick() {
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
              Center(
                child: ElevatedButton(
                  onPressed: _verifiAccOnClick,
                  style: FilledBtnStyle.enable(
                    isFullWidth: true,
                    borderRadius: 15,
                  ),
                  child: Text(
                    S.of(context).verifiAcc,
                    style: AppTextStyles.body1().copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
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
}
