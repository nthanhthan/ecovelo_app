
import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransferSuccessView extends GetView<TransferSuccessController>{
  const TransferSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _backToHomeOnClick() {
      Get.offAllNamed(Routes.home);
    }
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetsConst.rentBicycle),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(
                AssetsConst.transferBg,
                width: double.infinity,
              ),
            )
          ),
          Positioned.fill(
            top: 140,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Image.asset(
                      AssetsConst.greenSquare,
                    ),
                    Text(
                      "Transfer Successfully 🎉",
                      style: AppTextStyles.subHeading1().copyWith(
                        color: AppColors.main[200]
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Receipt",
                      style: AppTextStyles.body2().copyWith(
                        color: AppColors.main[200],
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 16),
                    SvgPicture.asset(AssetsConst.divider),
                    const SizedBox(height: 24),
                    _buildBankItem(),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          _buildRowItem(title: "Amount", body: "\$20"),
                          _buildRowItem(title: "Fee", body: "Free"),
                          _buildRowItem(title: "Date", body: "01 April 2023"),
                          _buildRowItem(title: "Time", body: "4:30 PM"),
                          _buildRowItem(title: "Total ", body: "\$20", isTotalItem: true),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomSheet: BottomSheet(
        backgroundColor: const Color.fromARGB(255, 218, 237, 211),
        onClosing: (){},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 35, left: 24, right: 24),
            child: InkWell(
              onTap: _backToHomeOnClick,
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color:AppColors.main[200],
                  borderRadius: BorderRadius.circular(16)
                ),
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    "Back to Home",
                    style: AppTextStyles.body1().copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.main[400]
                    ),
                  ),
                )
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRowItem({required String title, required String body, bool isTotalItem = false}) {
    return Padding(
      padding: (isTotalItem) ? const EdgeInsets.only(top: 20) : const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTextTitle(title, isTotalItem),
          _buildTextBody(body,isTotalItem)
        ],
      ),
    );
  }

  Text _buildTextBody(String text, bool isTotalItem) {
    return Text(
      text,
      style: AppTextStyles.body2().copyWith(
        color: AppColors.grey[500],
        fontWeight: (isTotalItem) ? FontWeight.w600 : FontWeight.w400,
      ),
    );
  }

  Text _buildTextTitle(String text, bool isTotalItem) {
    return Text(
      text,
      style: (isTotalItem) ?
        AppTextStyles.body2().copyWith(
          color: AppColors.grey[400],
          fontWeight: FontWeight.w600,
        ) :
        AppTextStyles.body2().copyWith(
          color: AppColors.grey[300],
          fontWeight: FontWeight.w500,
        ),
    );
  }

  Widget _buildBankItem() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey[00],
        borderRadius: BorderRadius.circular(16)
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(AssetsConst.techcombank),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildTextTitle(text: "Techcombank (TCB)", color:AppColors.grey[500]),
                  BuildTextBody(text: "Ngân hàng TMCP Kỹ thương Việt Nam", color: AppColors.grey[500])
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}