import 'package:flutter/material.dart';

import 'package:ecoveloapp/app/core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tags_x/flutter_tags_x.dart';

class AddMoneyView extends GetView<AddMoneyController> {
  const AddMoneyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
                        hintText: "\$0",
                        hintStyle: AppTextStyles.largeHeading2().copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.main[300],
                        ),
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                      style: AppTextStyles.largeHeading2().copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.main[300],
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (string) {
                        if (string != "") {
                          string = controller
                              .formatNumber(string.replaceAll(',', ''));
                        }
                        controller.enterMoneyController.value =
                            TextEditingValue(
                          text: string,
                          selection:
                              TextSelection.collapsed(offset: string.length),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Tags(
                columns: 3,
                itemCount: DefaultValues.addMoneyValues.length,
                itemBuilder: (index) {
                  return Container(
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.grey),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: ItemTags(
                      index: index,
                      title:
                          "\$" + DefaultValues.addMoneyValues[index].toString(),
                      border: Border.all(width: 0, color: Colors.transparent),
                      singleItem: true,
                      elevation: 0.0,
                      activeColor: AppColors.main[300] as Color,
                      textActiveColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45, vertical: 10),
                      onPressed: (i) {
                        controller.enterMoneyController.text =
                            i.title!.split('\$')[1];
                        controller.enterMoneyController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: controller
                                    .enterMoneyController.text.length));
                        FocusScope.of(context).unfocus();
                      },
                      textStyle: AppTextStyles.body2().copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.main[200]),
                    ),
                  );
                },
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
                  children:
                      List.generate(DefaultValues.bankList.length, (index) {
                return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: BuildBankItem(
                      title: DefaultValues.bankList[index]["title"].toString(),
                      body: DefaultValues.bankList[index]["body"].toString(),
                      asset: DefaultValues.bankList[index]["asset"].toString(),
                      controller: controller,
                    ));
              })),
              Column(
                  children: List.generate(
                      DefaultValues.paymentMethodList.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: BuildPaymentItem(
                      title: DefaultValues.paymentMethodList[index]['title']
                          .toString(),
                      asset: DefaultValues.paymentMethodList[index]['asset']
                          .toString()),
                );
              })),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 35, left: 24, right: 24),
        child: InkWell(
          onTap: () {},
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
              )),
        ),
      ),
    );
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
            color: AppColors.grey[00], borderRadius: BorderRadius.circular(16)),
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
                    BuildTextTitle(text: title, color: AppColors.grey[400]),
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

class BuildBankItem extends StatelessWidget {
  const BuildBankItem(
      {Key? key,
      required this.title,
      required this.body,
      required this.asset,
      required this.controller})
      : super(key: key);
  final String title;
  final String body;
  final String asset;
  final AddMoneyController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          controller.selectBank(title);
        },
        child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 350),
          child: Container(
            decoration: BoxDecoration(
                color: controller.selectedBank.value == title
                    ? AppColors.main.shade200
                    : AppColors.grey.shade600,
                borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(12),
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
                        BuildTextTitle(
                          text: title,
                          color: controller.selectedBank.value == title
                              ? AppColors.main.shade400
                              : AppColors.grey.shade500,
                        ),
                        BuildTextBody(
                            text: body,
                            color: controller.selectedBank.value == title
                                ? AppColors.main.shade400
                                : AppColors.grey.shade500)
                      ],
                    ),
                  ],
                ),
                controller.selectedBank.value == title
                    ? SvgPicture.asset(AssetsConst.activeCircle)
                    : SvgPicture.asset(AssetsConst.disableCircle)
              ],
            ),
          ),
        ),
      );
    });
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
