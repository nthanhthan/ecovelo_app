import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChangeRoleView extends GetView<EcoUserDetailController> {
  const ChangeRoleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _changeRoleClick(int id) {
    controller.changeRole(id);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).changeRole,
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  _roleItem(
                    context,
                    AssetsConst.adminRole,
                    "Admin",
                    0,
                  ),
                  _roleItem(
                    context,
                    AssetsConst.userRole,
                    "User",
                    1,
                  ),
                ],
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: 48),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    S.of(context).confirm,
                    style: AppTextStyles.body2()
                        .copyWith(color: AppColors.grey.shade600),
                  ),
                  style: controller.idRoleUser != controller.role
                      ? FilledBtnStyle.enable(
                          sizeType: SizeButtonType.custom,
                          customPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 80,
                          ),
                        )
                      : FilledBtnStyle.disable(
                          sizeType: SizeButtonType.custom,
                          customPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 80,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleItem(
      BuildContext context, String icon, String nameRole, int idRole) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            _changeRoleClick(idRole);
          },
          style: controller.role == idRole
              ? FilledBtnStyle.enable(
                  isFullWidth: true,
                )
              : FilledBtnStyle.disable(
                  isFullWidth: true,
                ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: controller.role == idRole
                    ? AppColors.white
                    : AppColors.main,
                height: 40,
              ),
              const SizedBox(width: 20),
              Text(
                nameRole,
                style: AppTextStyles.subHeading1().copyWith(
                  color: controller.role == idRole
                      ? AppColors.white
                      : AppColors.main,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
