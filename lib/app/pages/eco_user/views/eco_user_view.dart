import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class EcoUserView extends GetView<EcoUserController> {
  const EcoUserView({Key? key}) : super(key: key);

  Future<void> _userDetailClick(EcoUserModel ecoUserModel) async {
    if (ecoUserModel.userModel != null) {
      Get.offNamed(
        Routes.ecoUserDetail,
        arguments: ecoUserModel.userModel!.userId,
      );
    } else {
      SnackBars.error(message: "Error, Try again please").show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).accUser,
          style: AppTextStyles.heading1().copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.grey.shade100,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Obx(
            () => controller.isLoading
                ? controller.listEcoUser.isListNullOrEmpty
                    ? Center(
                        child: Image.asset(
                          AssetsConst.profileEmpty,
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.main),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                const BarChartSample3(),
                                Text(
                                  S.of(context).newUser,
                                  style: AppTextStyles.body1(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          _topWiget(context),
                          const SizedBox(height: 20),
                          Column(
                            children: controller.listEcoUser!
                                .asMap()
                                .entries
                                .map((e) => _itemUser(
                                    context, controller.listEcoUser![e.key]))
                                .toList(),
                          ),
                        ],
                      )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget _topWiget(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: AppColors.main.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: _gridAnalysis(context));
  }

  Widget _gridAnalysis(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemAnalysis(
                  context,
                  S.of(context).totalUser,
                  controller.listEcoUser?.length ?? 0,
                ),
                _itemAnalysis(
                  context,
                  S.of(context).authenticated,
                  controller.authencated,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemAnalysis(
                  context,
                  S.of(context).unauthenticated,
                  controller.unauthencated,
                ),
                _itemAnalysis(
                  context,
                  S.of(context).pendingProcessing,
                  controller.processing,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemAnalysis(
    BuildContext context,
    String text,
    int number,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        onPressed: null,
        style: OutlineButtonStyle.enable(
          sizeType: SizeButtonType.custom,
          customPadding: const EdgeInsets.fromLTRB(12, 15, 5, 15),
          outlineColor: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text,
                style: AppTextStyles.tiny().copyWith(
                  color: AppColors.grey.shade100,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              number.toString(),
              style: AppTextStyles.body1().copyWith(
                color: AppColors.grey.shade100,
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }

  Widget _itemUser(BuildContext context, EcoUserModel ecoUserModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: OutlinedButton(
        onPressed: () {
          _userDetailClick(ecoUserModel);
        },
        style: OutlineButtonStyle.enable(
          sizeType: SizeButtonType.custom,
          outlineColor: AppColors.grey.shade300,
          customPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${ecoUserModel.userModel?.userId} - ${ecoUserModel.userModel?.nameUser}",
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.main),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                Text(
                  ecoUserModel.getTypeAuthencation(),
                  style: AppTextStyles.body1().copyWith(color: AppColors.main),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: AppColors.grey.shade200,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    ecoUserModel.userModel?.email ?? "0901948483",
                    style:
                        AppTextStyles.body2().copyWith(color: AppColors.main),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xffBFBFBF),
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _itemActivites(
                    context,
                    AssetsConst.icEcovelo,
                    S.of(context).totalRent,
                    ecoUserModel.totalRent ?? 0,
                  ),
                  _itemActivites(
                    context,
                    AssetsConst.problemIC,
                    S.of(context).numFall,
                    ecoUserModel.numFall ?? 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemActivites(
    BuildContext context,
    String icon,
    String text,
    int number,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 0),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.main.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(
            icon,
            width: 30,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppTextStyles.tiny().copyWith(
                color: AppColors.grey.shade500,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              number.toString(),
              style: AppTextStyles.body1()
                  .copyWith(color: AppColors.main.shade200),
            ),
            const SizedBox(width: 4),
          ],
        )
      ],
    );
  }
}
