import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthencationView extends GetView<EcoUserController> {
  const AuthencationView({Key? key}) : super(key: key);

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
        bottomNavigationBar: _btnBottom(context),
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
                  "https://firebasestorage.googleapis.com/v0/b/ecovelo-b640d.appspot.com/o/profile%2F1%2Ffront?alt=media&token=521dd114-0fb5-49b5-850d-ccb92bff7c8d",
                  "Font Side",
                ),
                const SizedBox(height: 20),
                _cardItem(
                  context,
                  "https://firebasestorage.googleapis.com/v0/b/ecovelo-b640d.appspot.com/o/profile%2F1%2Fback?alt=media&token=8e64b461-5db1-4d51-9774-fb74dd642731",
                  "Back Side",
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
        onPressed: null,
        style: FilledBtnStyle.enable(
            isFullWidth: true,
            borderRadius: 20,
            customPadding: const EdgeInsets.symmetric(vertical: 15),
            sizeType: SizeButtonType.custom),
        child: Text(
          "Authencated",
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
