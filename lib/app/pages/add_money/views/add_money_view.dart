import 'package:flutter/material.dart';
import 'package:ecoveloapp/app/core.dart';
import 'package:flutter_svg/svg.dart';

class AddMoneyView extends GetView<AddMoneyController> {
  const AddMoneyView({Key? key}) : super(key: key);

  _continueOnLick() async {
    await controller.payment();
  }

  void _selectedMoney(MoneyModel moneyModel) {
    controller.selectedMoney(moneyModel);
  }

  void _seclectedBank(BankModel bankModel) {
    controller.selectedBank(bankModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            AssetsConst.leftArrow,
          ),
        ),
        elevation: 0.0,
        title: Text(
          S.of(context).addMoney,
          style: AppTextStyles.subLead().copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.grey.shade700,
          ),
        ),
        backgroundColor: AppColors.defaultBackground,
      ),
      backgroundColor: AppColors.defaultBackground,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 20, left: 24, right: 24),
                decoration: BoxDecoration(
                    color: AppColors.secondary.shade100,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).enterMoney,
                      style: AppTextStyles.tiny().copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.enterMoneyController,
                      textAlign: TextAlign.center,
                      cursorColor: AppColors.black,
                      showCursor: false,
                      decoration: InputDecoration(
                        hintText: "0 đ",
                        hintStyle: AppTextStyles.largeHeading2().copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.main.shade300,
                        ),
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      style: AppTextStyles.largeHeading2().copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.main.shade300,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 25,
                runSpacing: 15,
                children: DefaultValues.addMoneyValues.asMap().entries.map((e) {
                  return _moneyItemWidget(
                    context,
                    DefaultValues.addMoneyValues[e.key],
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).selectSource,
                  style: AppTextStyles.body2().copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.grey.shade500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: DefaultValues.bankList.asMap().entries.map(
                  (e) {
                    return _bankWidget(
                      context,
                      DefaultValues.bankList[e.key],
                    );
                  },
                ).toList(),
              ),
              Column(
                children: List.generate(
                  DefaultValues.paymentMethodList.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: BuildPaymentItem(
                          title: DefaultValues.paymentMethodList[index]['title']
                              .toString(),
                          asset: DefaultValues.paymentMethodList[index]['asset']
                              .toString()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 24, right: 24),
        child: InkWell(
          onTap: _continueOnLick,
          child: Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: AppColors.main.shade200,
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                S.of(context).continueBtn,
                style: AppTextStyles.body1().copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.main.shade400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _moneyItemWidget(
    BuildContext context,
    MoneyModel moneyModel,
  ) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          _selectedMoney(moneyModel);
        },
        child: Container(
          width: 110,
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color:
                controller.indexMoney == moneyModel.id ? AppColors.main : null,
            border: controller.indexMoney == moneyModel.id
                ? null
                : Border.all(width: 1.0, color: Colors.grey),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              controller.parseMoney(moneyModel.money),
              style: AppTextStyles.body2().copyWith(
                fontWeight: FontWeight.w500,
                color: controller.indexMoney == moneyModel.id
                    ? AppColors.white
                    : AppColors.main.shade200,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bankWidget(BuildContext context, BankModel bankModel) {
    return Obx(() {
      return InkWell(
        onTap: () {
          _seclectedBank(bankModel);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: AnimatedContainer(
            curve: Curves.easeIn,
            duration: const Duration(milliseconds: 350),
            child: Container(
              decoration: BoxDecoration(
                  color: controller.indexBank == bankModel.id
                      ? AppColors.main.shade200
                      : AppColors.grey.shade600,
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        bankModel.logo,
                        height: 30,
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: Get.width * 0.62,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BuildTextTitle(
                              text: bankModel.nameBank,
                              color: controller.indexBank == bankModel.id
                                  ? AppColors.main.shade400
                                  : AppColors.grey.shade500,
                            ),
                            BuildTextBody(
                                text: bankModel.desBank,
                                color: controller.indexBank == bankModel.id
                                    ? AppColors.main.shade400
                                    : AppColors.grey.shade500)
                          ],
                        ),
                      ),
                    ],
                  ),
                  controller.indexBank == bankModel.id
                      ? SvgPicture.asset(AssetsConst.activeCircle)
                      : SvgPicture.asset(AssetsConst.disableCircle)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class BuildPaymentItem extends StatelessWidget {
  const BuildPaymentItem({
    Key? key,
    required this.title,
    required this.asset,
  }) : super(key: key);
  final String title;
  final String asset;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey[00],
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(asset),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildTextTitle(text: title, color: AppColors.grey[500]),
                  ],
                ),
              ],
            ),
            SvgPicture.asset(AssetsConst.greaterSymbol)
          ],
        ),
      ),
    );
  }
}

class BuildTextTitle extends StatelessWidget {
  const BuildTextTitle({Key? key, required this.text, required this.color})
      : super(key: key);
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.tiny()
          .copyWith(fontWeight: FontWeight.w600, color: color),
    );
  }
}

class BuildTextBody extends StatelessWidget {
  const BuildTextBody({Key? key, required this.text, required this.color})
      : super(key: key);
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.tiny()
          .copyWith(fontWeight: FontWeight.w400, color: color),
    );
  }
}
