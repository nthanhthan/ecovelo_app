import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class FixProblemDetail extends GetView<FixProblemController> {
  const FixProblemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _builBody(context);
  }

  void _onChangeProblem(InputItem? item) {
    if (item != null) {
      controller.prioritySelected = item;
    } else {
      controller.prioritySelected = InputItem.empty();
    }
  }

  Widget _builBody(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppColors.colorAppBar,
        title: Text(
          S.of(context).problemDetail,
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
              Obx(
                () => DropdownInput(
                  key: const ValueKey('problem'),
                  itemList: controller.priorities,
                  seleted: controller.prioritySelected,
                  label: S.of(context).resolve,
                  hint: S.of(context).resolve,
                  onChanged: _onChangeProblem,
                  verticalMargin: AppProperties.lineSpace,
                ),
              ),
              _detailItem(context, "ID User", "1"),
              _detailItem(context, "Name", "Nguyen Thanh Than"),
              _detailItem(context, "Phone", "0901948483"),
              _detailItem(context, "ID Bicycle", "ECOVELO-01"),
              _detailItem(context, "Name Problem", "Lock Broken"),
              _detailItem(context, "Address", "Hai Chau, Da Nang"),
              _detailItem(context, "Description", "Khong the mo khoa"),
              _detailItem(context, "Time Report", "15:20  23/6/2023"),
              _imageProblem(
                  context,
                  "https://firebasestorage.googleapis.com/v0/b/ecovelo-b640d.appspot.com/o/profile%2F1%2Fback?alt=media&token=8e64b461-5db1-4d51-9774-fb74dd642731",
                  "Image")
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
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 8),
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
        ],
      ),
    );
  }

  Widget _imageProblem(
    BuildContext context,
    String path,
    String typeView,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            typeView,
            style:
                AppTextStyles.body1().copyWith(color: AppColors.grey.shade500),
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
