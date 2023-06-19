import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class EcoUserDetail extends GetView<EcoUserController> {
  const EcoUserDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _changeRoleClick() {
    Get.toNamed(Routes.changeRole);
  }

  void _authencationClick() {
    Get.toNamed(Routes.authencationView);
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
            Get.back();
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
          child: Column(
            children: [
              _detailItem(
                context,
                "ID",
                "1",
                false,
              ),
              _detailItem(
                context,
                "Name",
                "Thanh Than",
                false,
              ),
              _detailItem(
                context,
                "Role",
                "User",
                true,
                nameChange: "Change",
                handle: _changeRoleClick,
              ),
              _detailItem(
                context,
                "Authencation",
                "Authencated",
                true,
                nameChange: "View",
                handle: _authencationClick,
              ),
              _detailItem(
                context,
                "Num Rent",
                "20",
                true,
                nameChange: "View",
                handle: null,
              ),
              _detailItem(
                context,
                "Num Fall",
                "0",
                true,
                nameChange: "View",
                handle: null,
              ),
              _detailItem(
                context,
                "Report Problem",
                "5",
                true,
                nameChange: "View",
                handle: null,
              ),
              _detailItem(
                context,
                "Phone",
                "0901948483",
                false,
              ),
              _detailItem(
                context,
                "Email",
                "thanthan2k1@gmail.com",
                false,
              ),
              _detailItem(
                context,
                "Address",
                "Da Nang",
                false,
              ),
              _detailItem(
                context,
                "Main Point",
                "200",
                false,
              ),
              _detailItem(
                context,
                "Pro Point",
                "0",
                false,
              ),
              const SizedBox(height: 20),
              _btnBottom(context),
            ],
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
