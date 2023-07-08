import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FixProblemView extends GetView<FixProblemController> {
  const FixProblemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  void _fixProblemOnClick() {
    Get.toNamed(Routes.fixProblemDetail);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).fixProblem,
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
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topWiget(context),
              const SizedBox(height: 20),
              const LineChartSample2(),
              _problemItem(
                context,
                "ECOVELO-01",
                "0901948483",
                "Lock Broken",
              ),
              _problemItem(
                context,
                "ECOVELO-02",
                "0901948483",
                "Lock Broken",
              ),
              _problemItem(
                context,
                "ECOVELO-03",
                "0901948483",
                "Lock Broken",
              ),
              _problemItem(
                context,
                "ECOVELO-04",
                "0901948483",
                "Lock Broken",
              ),
              _problemItem(
                context,
                "ECOVELO-05",
                "0901948483",
                "Lock Broken",
              ),
              _problemItem(
                context,
                "ECOVELO-06",
                "0901948483",
                "Lock Broken",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _problemItem(BuildContext context, String idBicycle,
      String phoneNumber, String nameProblem) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: OutlinedButton(
        onPressed: _fixProblemOnClick,
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
                        idBicycle,
                        style: AppTextStyles.body1()
                            .copyWith(color: AppColors.main),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          phoneNumber,
                          style: AppTextStyles.body2()
                              .copyWith(color: AppColors.main),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                Text(
                  "Resolved",
                  style: AppTextStyles.body1().copyWith(color: AppColors.main),
                )
              ],
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
                  Expanded(
                    child: _itemActivites(
                      context,
                      AssetsConst.fixProblem,
                      S.of(context).problem,
                      "Lock Broken",
                    ),
                  ),
                  Expanded(
                    child: _itemActivites(
                      context,
                      AssetsConst.iconClock,
                      S.of(context).time,
                      "12:30 22/6",
                    ),
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
    String number,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        onPressed: null,
        style: OutlineButtonStyle.enable(
          isFullWidth: true,
          outlineColor: AppColors.main,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  height: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: AppTextStyles.tiny().copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              number,
              style: AppTextStyles.tiny().copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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
      child: _gridAnalysis(context),
    );
  }

  Widget _gridAnalysis(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: null,
            style: OutlineButtonStyle.enable(
              sizeType: SizeButtonType.custom,
              customPadding: const EdgeInsets.fromLTRB(12, 15, 5, 15),
              outlineColor: AppColors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetsConst.problemIC,
                  height: 50,
                  color: AppColors.grey.shade600,
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        S.of(context).totalProblem,
                        style: AppTextStyles.body1().copyWith(
                          color: AppColors.grey.shade100,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "10",
                      style: AppTextStyles.body1().copyWith(
                        color: AppColors.grey.shade100,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _itemAnalysis(
                  context,
                  S.of(context).resolvedProblem,
                  "4",
                ),
              ),
              Expanded(
                child: _itemAnalysis(
                  context,
                  S.of(context).pending,
                  "1",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _itemAnalysis(
    BuildContext context,
    String text,
    String number,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        onPressed: null,
        style: OutlineButtonStyle.enable(
          isFullWidth: true,
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
              number,
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

  Widget _btnBottom(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: ElevatedButton(
        onPressed: () {
          showBottomChooseType(context);
        },
        style: FilledBtnStyle.enable(
            isFullWidth: true,
            borderRadius: 20,
            customPadding: const EdgeInsets.symmetric(vertical: 15),
            sizeType: SizeButtonType.custom),
        child: Text(
          S.of(context).changeProblem,
          style: AppTextStyles.subHeading1().copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void showBottomChooseType(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            _itemDocument(context, "Total Problem"),
            _itemDocument(context, "Resolved Problem"),
            _itemDocument(context, "Pending Problem"),
          ]),
        );
      },
    );
  }

  Widget _itemDocument(BuildContext context, String legalModel) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.grey.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          legalModel,
          style: AppTextStyles.body2().copyWith(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
