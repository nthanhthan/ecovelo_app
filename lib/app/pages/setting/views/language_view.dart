import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageView extends GetView<SettingController> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedScaleFactor(child: _buildBody(context));
  }

  void _confirmClick(BuildContext context) async {
    controller.selectLanguage(controller.languageSelected);
    await MyApp.of(context)?.changeLanguage(
      controller.languageSelected.languageCode,
    );
    Get.offAllNamed<void>(Routes.home);
  }

  void _languageOnChanged(LanguageModel language) {
    controller.languageOnChanged(language);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).language,
          style: AppTextStyles.heading1().copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColors.grey.shade400),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: AppColors.grey.shade100,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.languageSupported.length,
                itemBuilder: (context, index) {
                  var language = controller.languageSupported[index];
                  return _countryWidget(
                    context: context,
                    language: language,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: Obx(
              () => ElevatedButton(
                onPressed:
                    controller.confirmed ? () => _confirmClick(context) : () {},
                child: Text(
                  S.of(context).confirm,
                  style: controller.confirmed
                      ? AppTextStyles.body2()
                      : AppTextStyles.body2()
                          .copyWith(color: AppColors.hideContent),
                ),
                style: controller.confirmed
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
          )
        ],
      ),
    );
  }

  Widget _countryWidget({
    required BuildContext context,
    required LanguageModel language,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
      child: Obx(
        () {
          bool isSelecting = language.id == controller.languageSelected.id;
          return InkWell(
            onTap: () => _languageOnChanged.call(language),
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: isSelecting
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.main.shade300,
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.grey.shade100.withOpacity(0.5),
                    ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(language.flagIcon, width: 24),
                      const SizedBox(width: 20.0),
                      Text(
                        language.name,
                        style: isSelecting && controller.confirmed == true
                            ? AppTextStyles.body2()
                                .copyWith(color: AppColors.white)
                            : AppTextStyles.body2(),
                      ),
                    ],
                  ),
                  isSelecting
                      ? const Icon(
                          Icons.check,
                          color: AppColors.white,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
