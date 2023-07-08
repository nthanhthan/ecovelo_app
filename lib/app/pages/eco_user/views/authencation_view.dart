import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthencationView extends GetView<EcoUserDetailController> {
  const AuthencationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _confirmAuthencation() {
    controller.confirmAuthencation().then((value) {
      if (value) {
        Get.back(result: controller.getEcoUserModel?.userModel?.userId);
      } else {
        SnackBars.error(message: S.of(Get.context!).authenError).show();
      }
    });
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.defaultBackground,
        appBar: AppBar(
          backgroundColor: AppColors.colorAppBar,
          title: Text(
            S.of(context).authenUser,
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
        bottomNavigationBar: controller.getEcoUserModel
                    ?.getTypeAuthencation()
                    .compareTo(TypeAuthencation.authencated) ==
                0
            ? null
            : _btnBottom(context),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsConst.cardPerson,
                        height: 40,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        S.of(context).cmnd,
                        style: AppTextStyles.body1().copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.main.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _cardItem(
                  context,
                  controller.getEcoUserModel?.frontSide ?? "",
                  S.of(context).frontSide,
                ),
                const SizedBox(height: 20),
                _cardItem(
                  context,
                  controller.getEcoUserModel?.backSide ?? "",
                  S.of(context).backSide,
                ),
              ],
            ),
          ),
        )
        //Image.asset(AssetsConst.noData),
        );
  }

  Widget _cardItem(
    BuildContext context,
    String path,
    String typeView,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          typeView,
          style: AppTextStyles.body1(),
        ),
        const SizedBox(height: 15),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.main.shade200,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(
              path,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return ThreeBounceLoading();
              },
              errorBuilder: (context, error, stackTrace) => Image.asset(
                AssetsConst.noData,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _btnBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: ElevatedButton(
        onPressed: () {
          _confirmAuthencation();
        },
        style: FilledBtnStyle.enable(
            isFullWidth: true,
            borderRadius: 20,
            customPadding: const EdgeInsets.symmetric(vertical: 15),
            sizeType: SizeButtonType.custom),
        child: Text(
          S.of(context).confirm,
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
