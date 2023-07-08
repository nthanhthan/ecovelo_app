import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class EcoUserDetail extends GetView<EcoUserDetailController> {
  const EcoUserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _changeRoleClick() {
    Get.toNamed(Routes.changeRole);
  }

  Future<void> _authencationClick() async {
    final result = await Get.toNamed(Routes.authencationView);
    if (result != null && result is int) {
      controller.getDetailUser(result);
    }
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).userDetail,
          style: AppTextStyles.heading1().copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.offNamed(Routes.ecoUser);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.grey.shade100,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => controller.isLoading
                ? Column(
                    children: [
                      _detailItem(
                        context,
                        "ID",
                        controller.getEcoUserModel?.userModel?.userId
                                .toString() ??
                            "0",
                        false,
                      ),
                      _detailItem(
                        context,
                        S.of(context).name,
                        controller.getEcoUserModel?.userModel?.nameUser ??
                            "Not Name",
                        false,
                      ),
                      _detailItem(
                        context,
                        S.of(context).role,
                        "User",
                        true,
                        nameChange: S.of(context).changeRole,
                        handle: _changeRoleClick,
                      ),
                      _detailItem(
                        context,
                        S.of(context).authencation,
                        controller.getEcoUserModel?.getTypeAuthencation() ??
                            TypeAuthencation.unAuthencated,
                        true,
                        nameChange:
                            controller.getEcoUserModel?.getTypeAuthencation() !=
                                    TypeAuthencation.unAuthencated
                                ? S.of(context).view
                                : null,
                        handle:
                            controller.getEcoUserModel?.getTypeAuthencation() !=
                                    TypeAuthencation.unAuthencated
                                ? _authencationClick
                                : null,
                      ),
                      _detailItem(
                        context,
                        S.of(context).numRent,
                        controller.getEcoUserModel?.totalRent.toString() ?? "0",
                        true,
                        nameChange: S.of(context).view,
                        handle: null,
                      ),
                      _detailItem(
                        context,
                        S.of(context).numFall,
                        controller.getEcoUserModel?.numFall.toString() ?? "0",
                        true,
                        nameChange: S.of(context).view,
                        handle: null,
                      ),
                      _detailItem(
                        context,
                        S.of(context).reportProblem,
                        "0",
                        true,
                        nameChange: S.of(context).view,
                        handle: null,
                      ),
                      _detailItem(
                        context,
                        S.of(context).phoneNumber,
                        "0901948483",
                        false,
                      ),
                      _detailItem(
                        context,
                        S.of(context).email,
                        controller.getEcoUserModel?.userModel?.email
                                .toString() ??
                            "No Email",
                        false,
                      ),
                      _detailItem(
                        context,
                        S.of(context).address,
                        "Đà Nẵng",
                        false,
                      ),
                      _detailItem(
                        context,
                        S.of(context).mainWallet,
                        controller.parseMoney(controller
                            .getEcoUserModel?.userModel?.mainPoint
                            ?.toInt()),
                        false,
                      ),
                      _detailItem(
                        context,
                        S.of(context).promoWallet,
                        controller.parseMoney(controller
                            .getEcoUserModel?.userModel?.proPoint
                            ?.toInt()),
                        false,
                      ),
                      const SizedBox(height: 20),
                      _btnBottom(context),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget _detailItem(
    BuildContext context,
    String title,
    String value,
    bool change, {
    String? nameChange,
    Function? handle,
  }) {
    return GestureDetector(
      onTap: () {
        handle?.call();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff8C8C8C),
            width: 1.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body2().copyWith(
                    color: AppColors.grey.shade400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: AppTextStyles.body1().copyWith(
                    color: AppColors.main.shade200,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            change
                ? Text(
                    nameChange ?? "",
                    style: AppTextStyles.body1()
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  Widget _btnBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: ElevatedButton(
        onPressed: null,
        style: FilledBtnStyle.enable(
            isFullWidth: true,
            borderRadius: 20,
            customPadding: const EdgeInsets.symmetric(vertical: 15),
            sizeType: SizeButtonType.custom),
        child: Text(
          S.of(context).deactiveAcc,
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
